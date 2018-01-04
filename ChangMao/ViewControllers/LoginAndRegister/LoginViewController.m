//
//  LoginViewController.m
//  ChamStore
//
//  Created by 景睦科技 on 2017/10/10.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPwdOneViewController.h"
//#import "TabBarViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField  *phoneTextField;//手机号

@property (nonatomic, strong) UITextField  *pswTextField;//密码

@property (nonatomic, strong) UIButton     *loginBtn;//登录

@property (nonatomic, strong) UIButton     *registerBtn;//注册

@property (nonatomic, strong) UIButton     *forgetPswBtn;//忘记密码

@property (nonatomic, strong) UIButton     *rememberPswBtn;//记住密码

@property (nonatomic, assign) BOOL         checkRemember;

@end

@implementation LoginViewController

- (instancetype)initWithLoginSuccess:(LoginSuccessBlock)successBlock
                                skip:(LoginSkipBlock)skipBlock
{
    self = [super init];
    if (self) {
        self.successBlock = successBlock;
        self.skipBlock = skipBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self setupNavView];
    
    [self initUI];
    
}

#pragma mark - initMethod

- (void)setupNavView {
    
//    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
//    [self.view addSubview:self.bgView];
    
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(10, 20, 44, 44);
//    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:backBtn];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBtnClick)];
    
}

- (void)initUI {
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 90)/2, 90, 90, 90)];
//    imgView.image = [UIImage imageNamed:@"changmao"];
    [self.view addSubview:imgView];
    
    UIView *textFieldView = [[UIView alloc] initWithFrame:CGRectMake(16, 90 + 90 + 80, SCREEN_WIDTH - 32, 80)];
    textFieldView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textFieldView];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 70, 25)];
    phoneLabel.text = @"用户名";
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    [textFieldView addSubview:phoneLabel];
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, textFieldView.frame.size.width - 70, 40)];
    self.phoneTextField.delegate = self;
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTextField.returnKeyType = UIReturnKeyDone;
    self.phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneTextField.leftViewMode = UITextFieldViewModeUnlessEditing;
    self.phoneTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.phoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//    BOOL check = [def objectForKey:@"PswStatus"];
    if ([def objectForKey:@"PswStatus"]) {
        self.phoneTextField.text = [AppTools getLoginUser].phoneNum;
    }else{
       self.phoneTextField.placeholder = @"用户名/手机号";
    }
    self.phoneTextField.backgroundColor = [UIColor clearColor];
    [textFieldView addSubview:self.phoneTextField];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH - 32, 1)];
    lineView.backgroundColor = [UIColor darkGrayColor];
    [textFieldView addSubview:lineView];
    
    UILabel *pswLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 48, 70, 25)];
    pswLabel.text = @"密码";
    pswLabel.textAlignment = NSTextAlignmentLeft;
    [textFieldView addSubview:pswLabel];
    
    self.pswTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 40, textFieldView.frame.size.width - 70, 40)];
    self.pswTextField.delegate = self;
    self.pswTextField.keyboardType = UIKeyboardTypeDefault;
    self.pswTextField.returnKeyType = UIReturnKeyDone;
    self.pswTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pswTextField.leftViewMode = UITextFieldViewModeUnlessEditing;
    self.pswTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.pswTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    if ([def objectForKey:@"PswStatus"]) {
        self.pswTextField.text = [AppTools getLoginUser].phoneNumPsw;
    }else{
        self.pswTextField.placeholder = @"密码";
    }
    self.pswTextField.secureTextEntry = YES;
//    self.phoneTextField.font = [UIFont systemFontOfSize:18];
    self.pswTextField.backgroundColor = [UIColor clearColor];
    [textFieldView addSubview:self.pswTextField];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH - 32, 1)];
    lineView1.backgroundColor = [UIColor darkGrayColor];
    [textFieldView addSubview:lineView1];
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(16, textFieldView.frame.origin.y + textFieldView.frame.size.height + 20, SCREEN_WIDTH - 32, 90)];
    buttonView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonView];
    
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH - 32, 45);
    self.loginBtn.backgroundColor = [UIColor colorWithHexString:@"c40516"];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize: 18.0];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.loginBtn.layer.cornerRadius= 5.0f;
    [self.loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:self.loginBtn];
    
    self.rememberPswBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rememberPswBtn.frame = CGRectMake(0, 65, 20, 20);
    [self.rememberPswBtn setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    [self.rememberPswBtn addTarget:self action:@selector(rememberPswClick:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:self.rememberPswBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, 70, 30)];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = @"记住密码";
    label.font = [UIFont systemFontOfSize:16];
    [buttonView addSubview:label];
    
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.frame = CGRectMake(buttonView.frame.size.width/2 + 10, 60, 80, 30);
    [self.registerBtn setTitle:@"免费注册" forState:UIControlStateNormal];
    self.registerBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [self.registerBtn setTitleColor:[UIColor colorWithHexString:@"c40516"] forState:UIControlStateNormal];
    self.registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:self.registerBtn];
    
    self.forgetPswBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetPswBtn.frame = CGRectMake(buttonView.frame.size.width - 80, 60, 80, 30);
    [self.forgetPswBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    self.forgetPswBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [self.forgetPswBtn setTitleColor:[UIColor colorWithHexString:@"c40516"] forState:UIControlStateNormal];
    self.forgetPswBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.forgetPswBtn addTarget:self action:@selector(forgetPswBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:self.forgetPswBtn];
    
    
    
    
}

#pragma mark-----UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        self.phoneTextField.text = [self.phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    
    if (textField == self.pswTextField) {
        self.pswTextField.text = [self.pswTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        [self.phoneTextField resignFirstResponder];
    }
    
    if (textField == self.pswTextField) {
        [self.pswTextField resignFirstResponder];
    }
    
    return YES;
}



#pragma mark - UIButton

- (void)leftBtnClick {
    
    //登录失败
    if (self.skipBlock) {
        self.skipBlock();
    }
    
    [self dismissViewControllerAnimated:NO completion:^{
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        [tabBarController setSelectedIndex:0];
        [tabBarController dismissViewControllerAnimated:NO completion:nil];
    }];
    
}


- (void)loginBtnClick:(UIButton *)sender {
    
    //登录
    NSLog(@"登录");
    [self.view endEditing:YES];
    NSString *phone = [self.phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [self.pswTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (phone ==nil || phone.length == 0) {
        [AppTools showString:@"手机号不能为空"];
        return ;
    }
    
    if (phone.length < 11 || phone.length > 11) {
        [AppTools showString:@"请输入正确的手机号码"];
        return ;
    }
    
    if (![AppTools isValidateMobile:phone]) {
        [AppTools showString:@"请输入正确的手机号码."];
        return ;
    }
    
    if (password == nil || password.length == 0 ) {
        [AppTools showString:@"密码不能为空."];
        return;
    }
    
    if(password.length < 6 || password.length > 20 )
    {
        [AppTools showString:@"密码长度有误，密码为6-16个字符."];
        return;
    }
    //登录接口 username=admin9@qq.com&password=xjd520
    YJWDataRequest *request = [YJWDataRequest sharedInstance];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@username=%@&password=%@",Login_URL,phone,password];
    
    [request universalWithURL:urlStr hDict:nil successBlock:^(NSInteger statusCode, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary *dataDic = [data objectForKey:@"data"];
        NSString *string = [data objectForKey:@"result"];
        if ([string isEqualToString:@"1"]) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [AppTools showString:@"登录失败"];
        }else {
            NSLog(@"登录：%ld %@ %@",(long)statusCode,data,dataDic);
            if (dataDic != nil && dataDic.count != 0)
            {
                UserModel *user = [[UserModel alloc] init];
                user.userId = [dataDic objectForKey:@"user_id"];
                user.phoneNum = [dataDic objectForKey:@"username"];
                user.phoneNumPsw = password;
                NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
                NSData * userData = [NSKeyedArchiver archivedDataWithRootObject:user];
                [def setObject:userData forKey:LOGINED_USER];
                [def setBool:YES forKey:ISLOGINED];
                [def synchronize];
                NSLog(@"user：%@ %@",user.userId,user.phoneNum);
    
                [self dismissViewControllerAnimated:NO completion:nil];
    
                //登录成功
                if (self.successBlock) {
                    self.successBlock();
                }
    //            //进入首页
    //            TabBarViewController *tab = [[TabBarViewController alloc] init];
    //            [tab setSelectedIndex:TabBarControllerIndex_Home];
    //            [tab dismissViewControllerAnimated:NO completion:nil];
                
            }else {
                
                [AppTools showString:[data objectForKey:@"data"]];
                
            }
        }

    } errorBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"登录错误：%@",error.localizedDescription);
        [AppTools showString:error.localizedDescription];
    }];
    
    
}

- (void)rememberPswClick:(UIButton *)sender {
    
    //记住密码
    [self.view endEditing:YES];
    if (self.checkRemember) {
        [self.rememberPswBtn setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        self.checkRemember = NO;
    }else{
        [self.rememberPswBtn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
        self.checkRemember = YES;
    }
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setBool:self.checkRemember forKey:@"PswStatus"];
    [def synchronize];
    
}

- (void)registerBtnClick:(UIButton *)sender {
    
    //免费注册
    [self.view endEditing:YES];
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:NO];
    
}

- (void)forgetPswBtnClick:(UIButton *)sender {
    
    //忘记密码 跳到第一步
    [self.view endEditing:YES];
    ForgetPwdOneViewController *forgetPsw = [[ForgetPwdOneViewController alloc] init];
    [self.navigationController pushViewController:forgetPsw animated:NO];
    
}


#pragma mark----- touchesBegan

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
