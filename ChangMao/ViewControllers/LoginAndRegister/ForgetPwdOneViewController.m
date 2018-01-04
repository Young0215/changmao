//
//  ForgetPwdOneViewController.m
//  ChamStore
//
//  Created by 景睦科技 on 2017/10/11.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import "ForgetPwdOneViewController.h"
#import "JWVerCodeImageView.h"
#import "ForgetPwdTwoViewController.h"

@interface ForgetPwdOneViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) JWVerCodeImageView *codeImageView;

@property (nonatomic, strong) UITextField        *phoneTextField;

@property (nonatomic, strong) UITextField        *imageCodeTextField;

@property (nonatomic, strong) UIButton           *nextBtn;

@end

@implementation ForgetPwdOneViewController

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
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, SCREEN_WIDTH - 20, 50)];
    self.phoneTextField.delegate = self;
    self.phoneTextField.placeholder = @"请输入手机号";
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTextField.returnKeyType = UIReturnKeyDone;
    self.phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneTextField.leftViewMode = UITextFieldViewModeUnlessEditing;
    self.phoneTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.phoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.phoneTextField.layer.borderWidth = 1;
    self.phoneTextField.layer.cornerRadius = 1;
    self.phoneTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.phoneTextField.layer.masksToBounds = YES;
    [self.view addSubview:self.phoneTextField];
    
    
    self.imageCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 150, (SCREEN_WIDTH - 30)/2, 50)];
    self.imageCodeTextField.placeholder = @"验证码";
    self.imageCodeTextField.keyboardType = UIKeyboardTypeDefault;
    self.imageCodeTextField.returnKeyType = UIReturnKeyDone;
    self.imageCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.imageCodeTextField.leftViewMode = UITextFieldViewModeUnlessEditing;
    self.imageCodeTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.imageCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.imageCodeTextField.layer.borderWidth = 1;
    self.imageCodeTextField.layer.cornerRadius = 1;
    self.imageCodeTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.imageCodeTextField.layer.masksToBounds = YES;
    [self.view addSubview:self.imageCodeTextField];
    
    _codeImageView = [[JWVerCodeImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 30)/2 + 20, 150, (SCREEN_WIDTH - 30)/2, 50)];
    _codeImageView.bolck = ^(NSString *imageCodeStr){//看情况是否需要
        NSLog(@"imageCodeStr = %@",imageCodeStr);
    };
    _codeImageView.isRotation = NO;
    [_codeImageView freshVerCode];
    
    //点击刷新
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [_codeImageView addGestureRecognizer:tap];
    [self.view addSubview: _codeImageView];
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame = CGRectMake(10, 220, SCREEN_WIDTH - 20, 50);
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextBtn setBackgroundColor:[UIColor colorWithHexString:@"c40516"]];
    self.nextBtn.layer.cornerRadius = 5;
    self.nextBtn.layer.borderWidth = 1;
    self.nextBtn.layer.borderColor = [[UIColor clearColor] CGColor];
    self.nextBtn.layer.masksToBounds = YES;
    [self.nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextBtn];
    
}

#pragma mark - UIButton

- (void)tapClick:(UITapGestureRecognizer*)tap
{
    [_codeImageView freshVerCode];
}

- (void)nextBtnClick:(UIButton*)sender {
    
    //下一步 跳到忘记密码第二步
    [self.view endEditing:YES];
    
    NSString *phone = [self.phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *imageCode = [self.imageCodeTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (phone ==nil || phone.length == 0) {
        [AppTools showString:@"手机号不能为空"];
        return ;
    }
    if (imageCode ==nil || imageCode.length == 0) {
        [AppTools showString:@"验证码不能为空"];
        return ;
    }
    if (phone.length < 11 || phone.length > 11) {
        [AppTools showString:@"请输入正确的手机号码"];
        return ;
    }
    if (imageCode.length < 4 || imageCode.length > 4) {
        [AppTools showString:@"请输入正确的验证码"];
        return ;
    }
    if (![AppTools isValidateMobile:phone]) {
        [AppTools showString:@"请输入正确的手机号码."];
        return ;
    }
    //找回密码第一个接口 mobile=15713861029
    YJWDataRequest *request = [YJWDataRequest sharedInstance];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@mobile=%@",FindPswOne_URL,phone];
    
    [request universalWithURL:urlStr hDict:nil successBlock:^(NSInteger statusCode, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *codeStr = [data objectForKey:@"data"];
        NSLog(@"忘记密码1：%ld %@ %@",(long)statusCode,data,codeStr);
        if (data != nil && [codeStr isEqualToString:@"验证成功!"])
        {
            
            ForgetPwdTwoViewController *two = [[ForgetPwdTwoViewController alloc] initWithPhoneNum:self.phoneTextField.text];
            [self.navigationController pushViewController:two animated:NO];
            
        }else {
            
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
