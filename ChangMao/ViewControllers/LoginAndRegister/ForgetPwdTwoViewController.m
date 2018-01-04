//
//  ForgetPwdTwoViewController.m
//  ChamStore
//
//  Created by 景睦科技 on 2017/10/11.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import "ForgetPwdTwoViewController.h"
#import "ForgetPwdDoneViewController.h"

@interface ForgetPwdTwoViewController ()

@property (nonatomic, strong) UITextField        *messageCodeTextField;

@property (nonatomic, strong) UIButton           *reSendBtn;

@property (nonatomic, strong) UIButton           *nextBtn;

@property (nonatomic, assign) NSInteger          countdown; // 验证码倒计时

@property (nonatomic, strong) NSTimer            *countdownTimer;

@property (nonatomic, strong) NSString           *phoneNum;

@end

@implementation ForgetPwdTwoViewController

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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, SCREEN_WIDTH/2 , 30)];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = @"请选择验证身份的方式:";
    label.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 20, 80, SCREEN_WIDTH/2, 30)];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.text = @"已验证的手机号码";
    label1.layer.cornerRadius = 1;
    label1.layer.borderWidth = 1;
    label1.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    label1.layer.masksToBounds = YES;
    [self.view addSubview:label1];
    
    
    UILabel  *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 70, 30)];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.text = @"手机号:   ";
    label2.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(80, 120, 120, 30)];
    label3.textAlignment = NSTextAlignmentLeft;
    NSString *numberString = [self.phoneNum stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    label3.text = numberString;
    [self.view addSubview:label3];
    
    //发送验证码
    self.messageCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 160, (SCREEN_WIDTH - 20)/2, 40)];
    self.messageCodeTextField.placeholder = @"验证码";
    self.messageCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.messageCodeTextField.returnKeyType = UIReturnKeyDone;
    self.messageCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.messageCodeTextField.leftViewMode = UITextFieldViewModeUnlessEditing;
    self.messageCodeTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.messageCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.messageCodeTextField.layer.borderWidth = 1;
    self.messageCodeTextField.layer.cornerRadius = 1;
    self.messageCodeTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.messageCodeTextField.layer.masksToBounds = YES;
    [self.view addSubview:self.messageCodeTextField];
    
    self.reSendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reSendBtn.frame = CGRectMake((SCREEN_WIDTH - 20)/2 + 40, 160, 140, 40);
    [self.reSendBtn setTitle:@"获取手机验证码" forState:UIControlStateNormal];//30s重新发送
    [self.reSendBtn setTitleColor:[UIColor colorWithHexString:@"c40516"] forState:UIControlStateNormal];
    [self.reSendBtn setBackgroundColor:[UIColor whiteColor]];
    self.reSendBtn.layer.cornerRadius = 20;
    self.reSendBtn.layer.borderWidth = 2;
    self.reSendBtn.layer.borderColor = [[UIColor colorWithHexString:@"c40516"] CGColor];
    self.reSendBtn.layer.masksToBounds = YES;
    self.reSendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.reSendBtn addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.reSendBtn];
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame = CGRectMake(10, 220, SCREEN_WIDTH - 20, 50);
    [self.nextBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextBtn setBackgroundColor:[UIColor colorWithHexString:@"c40516"]];
    self.nextBtn.layer.cornerRadius = 5;
    self.nextBtn.layer.borderWidth = 1;
    self.nextBtn.layer.borderColor = [[UIColor clearColor] CGColor];
    self.nextBtn.layer.masksToBounds = YES;
    self.nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextBtn];
    
    
}


#pragma mark - UIButton

-(void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//发送验证码
- (void)sendCode:(UIButton *)sender {
    
    //忘记密码 验证码接口 mobile=15713861029&type=1 1 注册 2 忘记密码
    YJWDataRequest *request = [YJWDataRequest sharedInstance];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@mobile=%@&type=%d",MessageCode_URL,self.phoneNum,2];
    
    [request universalWithURL:urlStr hDict:nil successBlock:^(NSInteger statusCode, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *codeStr = [data objectForKey:@"data"];
        NSLog(@"忘记密码验证码：%ld %@ %@",(long)statusCode,data,codeStr);
        if (data != nil && [codeStr isEqualToString:@"发送成功!"])
        {
            [self startUpTimer];
            
        }else {
            
            [AppTools showString:[data objectForKey:@"data"]];
            
        }
    } errorBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"错误：%@",error.localizedDescription);
        [AppTools showString:error.localizedDescription];
    }];

    
    
}

// 提交 跳到找回密码第三步
- (void)nextBtnClick:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    NSString *messageCode = [self.messageCodeTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (messageCode ==nil || messageCode.length == 0) {
        [AppTools showString:@"验证码不能为空"];
        return ;
    }
    if (messageCode.length < 6 || messageCode.length > 6) {
        [AppTools showString:@"请输入正确的验证码"];
        return ;
    }
    //找回密码第二个接口 mobile=15713861029&code=123456
    YJWDataRequest *request = [YJWDataRequest sharedInstance];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@mobile=%@&code=%@",FindPswTwo_URL,self.phoneNum,self.messageCodeTextField.text];
    
    [request universalWithURL:urlStr hDict:nil successBlock:^(NSInteger statusCode, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *codeStr = [data objectForKey:@"data"];
        NSLog(@"忘记密码2：%ld %@ %@",(long)statusCode,data,codeStr);
        if (data != nil && [codeStr isEqualToString:@"验证成功!"])
        {
            ForgetPwdDoneViewController *done = [[ForgetPwdDoneViewController alloc] initWithPhoneNum:self.phoneNum];
            [self.navigationController pushViewController:done animated:NO];
            
        }else {
            
            [AppTools showString:[data objectForKey:@"data"]];
            [self invalidateTimer];
            
        }
    } errorBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"忘记密码错误：%@",error.localizedDescription);
        [AppTools showString:error.localizedDescription];
    }];

    
    
    
}

#pragma mark-----定时器

- (void)startUpTimer {
    
    self.countdown = 60;
    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    
}

- (void)timeFireMethod
{
    
    self.countdown--;
    if (self.countdown == 0) {
        
        [self invalidateTimer];
    }
    [self flashReSendBtn];
}

- (void)invalidateTimer {
    
    [self.countdownTimer invalidate];
    self.countdownTimer = nil;
    
}

- (void)flashReSendBtn
{
    if (self.countdown > 0) {
        [self.reSendBtn setTitle:[NSString stringWithFormat:@"%zds重新发送", self.countdown] forState:UIControlStateNormal];
        self.reSendBtn.userInteractionEnabled = NO;
    } else {
        [self.reSendBtn setTitle:@"获取手机验证码" forState:UIControlStateNormal];
        self.reSendBtn.userInteractionEnabled = YES;
        [self invalidateTimer];
    }
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
