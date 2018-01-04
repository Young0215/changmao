//
//  ForgetPwdDoneViewController.m
//  ChamStore
//
//  Created by 景睦科技 on 2017/10/11.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import "ForgetPwdDoneViewController.h"

@interface ForgetPwdDoneViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField        *nPswTextField;

@property (nonatomic, strong) UITextField        *surePswTextField;

@property (nonatomic, strong) UIButton           *sureBtn;

@property (nonatomic, strong) NSString           *phoneNum;

@end

@implementation ForgetPwdDoneViewController

- (id)initWithPhoneNum:(NSString *)phone {
    
    self = [super init];
    if (self) {
        
        self.phoneNum = phone;
        
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    
    [self setupNavView];
    
    [self setupUI];
    
}

#pragma mark - initMethod

- (void)setupNavView {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    
}

- (void)setupUI {
    
    UIView *newView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 50)];
//    newView.backgroundColor = [UIColor redColor];
    [self.view addSubview:newView];
    
    
    UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 50)];
    nLabel.textAlignment = NSTextAlignmentLeft;
    nLabel.text = @"输入新密码：";
    nLabel.font = [UIFont systemFontOfSize:16];
    [newView addSubview:nLabel];
    
    self.nPswTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 0, SCREEN_WIDTH - 110, 50)];
    self.nPswTextField.delegate = self;
    self.nPswTextField.placeholder = @"请输入新密码";
    self.nPswTextField.keyboardType = UIKeyboardTypeDefault;
    self.nPswTextField.returnKeyType = UIReturnKeyDone;
    self.nPswTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nPswTextField.leftViewMode = UITextFieldViewModeUnlessEditing;
    self.nPswTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.nPswTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nPswTextField.backgroundColor = [UIColor clearColor];
    [newView addSubview:self.nPswTextField];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 48, SCREEN_WIDTH, 2)];
    lineView.backgroundColor = [UIColor grayColor];
    [newView addSubview:lineView];
    
    
    UIView *sureView = [[UIView alloc] initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH, 50)];
//    sureView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:sureView];
    
    UILabel *sLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 50)];
    sLabel.textAlignment = NSTextAlignmentLeft;
    sLabel.text = @"确认新密码：";
    sLabel.font = [UIFont systemFontOfSize:16];
    [sureView addSubview:sLabel];
    
    self.surePswTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 0, SCREEN_WIDTH - 110, 50)];
    self.surePswTextField.placeholder = @"请确认新密码";
    self.surePswTextField.keyboardType = UIKeyboardTypeDefault;
    self.surePswTextField.returnKeyType = UIReturnKeyDone;
    self.surePswTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.surePswTextField.leftViewMode = UITextFieldViewModeUnlessEditing;
    self.surePswTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.surePswTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.surePswTextField.backgroundColor = [UIColor clearColor];
    [sureView addSubview:self.surePswTextField];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 48, SCREEN_WIDTH, 2)];
    lineView1.backgroundColor = [UIColor grayColor];
    [sureView addSubview:lineView1];
    
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(10, 70 + newView.frame.size.height + sureView.frame.size.height + 30, SCREEN_WIDTH - 20, 40);
    [self.sureBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sureBtn setBackgroundColor:[UIColor colorWithHexString:@"c40516"]];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.borderWidth = 1;
    self.sureBtn.layer.borderColor = [[UIColor clearColor] CGColor];
    self.sureBtn.layer.masksToBounds = YES;
//    self.nextBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sureBtn];
    
    
    
}

#pragma mark - UIButton

- (void)sureBtnClick:(UIButton*)sender {
    
    //修改密码
    [self.view endEditing:YES];
    NSString *nPsw = [self.nPswTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *sPsw = [self.surePswTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (nPsw == nil || nPsw.length == 0 || sPsw == nil || sPsw.length == 0) {
        [AppTools showString:@"密码不能为空"];
        return;
    }
    
    if(nPsw.length < 6 || nPsw.length > 20 || sPsw.length < 6 || sPsw.length > 20)
    {
        [AppTools showString:@"密码长度有误，密码为6-20个字符."];
        return;
    }
    
    if(![nPsw isEqualToString:sPsw])
    {
        [AppTools showString:@"两次密码不一致"];
        return;
    }
    
    //修改密码第三个接口 mobile=15713861029&password=123456
    YJWDataRequest *request = [YJWDataRequest sharedInstance];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@mobile=%@&password=%@",FindPswThree_URL,self.phoneNum,sPsw];
    
    [request universalWithURL:urlStr hDict:nil successBlock:^(NSInteger statusCode, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *codeStr = [data objectForKey:@"data"];
        NSLog(@"忘记密码3：%ld %@ %@",(long)statusCode,data,codeStr);
        if (data != nil && [codeStr isEqualToString:@"修改成功!"])
        {
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
        else
        {
            [AppTools showString:[data objectForKey:@"data"]];
        }
    } errorBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"忘记密码错误：%@",error.localizedDescription);
        [AppTools showString:error.localizedDescription];
    }];

    
    
    
}

-(void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
