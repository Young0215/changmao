//
//  RegisterViewController.m
//  ChamStore
//
//  Created by 景睦科技 on 2017/10/10.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import "RegisterViewController.h"
#import "LeftTitleRightInputTextCell.h"
#import "PwdCell.h"
#import "MessageCodeCell.h"
#import "UIButton+Extension.h"
#import "LoginViewController.h"
//#import "TabBarViewController.h"

@interface RegisterViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong) NSString *phone, *pwd, *surePwd, *messageCode, *recommendPhone;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UIButton *registerBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    [self setupNavView];
    
    [self setupUI];
    
    
}

#pragma mark - initMethod

- (void)setupNavView {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    
}

- (void)setupUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStyleGrouped];
    tableView.backgroundColor = kColorTableBG;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [self tableFooterView];
    _tableView = tableView;
    
}

- (UIView*)tableFooterView
{
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    
    UIButton *nextBtn = [[UIButton alloc] init];
    [nextBtn setTitle:@"注册" forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:[UIColor colorWithHexString:@"c40516"]];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    nextBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    [footerV addSubview:nextBtn];
    [nextBtn setCenter:footerV.center];
    nextBtn.enabled = NO;
    [nextBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _registerBtn = nextBtn;
    return footerV;
}

#pragma mark - UIButton

-(void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)registerBtnClick {
    
    //注册
    [self.view endEditing:YES];
//    if (self.recommendPhone ==nil || self.recommendPhone.length == 0) {
//        [AppTools showString:@"推荐人账号不能为空"];
//        return ;
//    }
    if (self.phone ==nil || self.phone.length == 0) {
        [AppTools showString:@"手机号不能为空"];
        return ;
    }
    if (self.phone.length < 11 || self.phone.length > 11) {
        [AppTools showString:@"请输入正确的手机号码"];
        return ;
    }
    if (![AppTools isValidateMobile:self.phone]) {
        [AppTools showString:@"请输入正确的手机号码."];
        return ;
    }
    if (self.messageCode == nil || [@"" isEqualToString:self.messageCode]) {
        [AppTools showString:@"请输入验证码"];
        return;
    }
    
    if (self.messageCode.length < 6 || self.messageCode.length > 6) {
        [AppTools showString:@"请输入正确的验证码"];
        return;
    }
    
    if (self.pwd == nil || self.pwd.length == 0 || self.surePwd == nil || self.surePwd.length == 0) {
        [AppTools showString:@"密码不能为空"];
        return;
    }
    
    if(self.pwd.length < 6 || self.pwd.length > 20 || self.surePwd.length < 6 || self.surePwd.length > 20)
    {
        [AppTools showString:@"密码长度有误，密码为6-20个字符."];
        return;
    }
    if(![self.pwd isEqualToString:self.surePwd])
    {
        [AppTools showString:@"两次密码不一致"];
        return;
    }
    
    //注册接口 mobile=15713861029&code=706774&password=123456&password1=123456&p_mobile=
    YJWDataRequest *request = [YJWDataRequest sharedInstance];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@mobile=%@&code=%@&password=%@&password1=%@&p_mobile=",Register_URL,_phone,self.messageCode,self.pwd,self.surePwd];
    
    [request universalWithURL:urlStr hDict:nil successBlock:^(NSInteger statusCode, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *codeStr = [data objectForKey:@"data"];
        NSLog(@"注册：%ld %@ %@",(long)statusCode,data,codeStr);
        if (data != nil && [codeStr isEqualToString:@"注册成功!"])
        {
            [AppTools showString:@"恭喜！您已注册成功! "];
            
//            //进入首页
//            UITabBarController *tab = [[UITabBarController alloc] init];
//            [tab setSelectedIndex:0];
//            [tab dismissViewControllerAnimated:NO completion:nil];
            
            LoginViewController *login = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:login animated:NO];
        }
        else
        {
            
            [AppTools showString:[data objectForKey:@"data"]];
            
        }
    } errorBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"注册错误：%@",error.localizedDescription);
        [AppTools showString:error.localizedDescription];
    }];
    
    
    
}

- (void)updateNextBtnStatus
{
    _registerBtn.enabled = (_phone.length && _pwd.length && _surePwd.length && _messageCode.length);
}

//发送验证码
- (void)sendMessageCodeBtnClicked:(MessageCodeButton *)btn
{
    [self.view endEditing:YES];
    
    if ([_phone length] == 0) {
        [AppTools showString:@"手机号不能为空"];
        return;
    }
    if (_phone.length < 11 || _phone.length > 11) {
        [AppTools showString:@"请输入正确的手机号码."];
        return ;
    }
    if (![AppTools isValidateMobile:_phone]) {
        [AppTools showString:@"请输入正确的手机号码"];
        return;
    }
    btn.enabled = NO;
    
    //注册 验证码接口 mobile=15713861029&type=1 1 注册 2 忘记密码
    YJWDataRequest *request = [YJWDataRequest sharedInstance];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@mobile=%@&type=%d",MessageCode_URL,_phone,1];
    
    [request universalWithURL:urlStr hDict:nil successBlock:^(NSInteger statusCode, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *codeStr = [data objectForKey:@"data"];
        NSLog(@"验证码：%ld %@ %@",(long)statusCode,data,codeStr);
        if (data != nil && [codeStr isEqualToString:@"发送成功!"])
        {
            [btn startUpTimer];
            
        }else {
            
            [AppTools showString:[data objectForKey:@"data"]];
            [btn invalidateTimer];
            
        }
    } errorBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"错误：%@",error.localizedDescription);
        [AppTools showString:error.localizedDescription];
    }];

}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    if (indexPath.row == 0){
        LeftTitleRightInputTextCell *cell = [LeftTitleRightInputTextCell cellWithTableView:tableView];
        [cell configWithLeftTitle:@"推荐人"
                      placeholder:@"请输入推荐人账号"
                         valueStr:self.recommendPhone
                  secureTextEntry:NO
                     keyboardType:UIKeyboardTypeNumberPad];
        cell.textValueChangedBlock = ^(NSString *valueStr){
            weakSelf.recommendPhone = valueStr;
        };
        return cell;
    }else if (indexPath.row == 4)
    {
        MessageCodeCell *cell = [MessageCodeCell cellWithTableView:tableView];
        [cell configWithLeftTitle:@"验证码"
                      placeholder:@"短信验证码"
                         valueStr:self.messageCode];
        cell.textValueChangedBlock = ^(NSString *valueStr){
            weakSelf.messageCode = valueStr;
            [weakSelf updateNextBtnStatus];
        };
        cell.sendMessageCodeBtnClickedBlock = ^(MessageCodeButton *btn){
            [weakSelf sendMessageCodeBtnClicked:btn];
        };
        return cell;
        
    }else if (indexPath.row == 3)
    {
        PwdCell *cell = [PwdCell cellWithTableView:tableView];
        [cell configWithLeftTitle:@"确认密码"
                      placeholder:@"请确认密码"
                         valueStr:self.surePwd
                  secureTextEntry:YES
                     keyboardType:UIKeyboardTypeDefault];
        cell.textValueChangedBlock = ^(NSString *valueStr){
            weakSelf.surePwd = valueStr;
            [weakSelf updateNextBtnStatus];
        };
        return cell;
    }else if (indexPath.row == 2)
    {
        PwdCell *cell = [PwdCell cellWithTableView:tableView];
        [cell configWithLeftTitle:@"密码"
                      placeholder:@"请输入6至20位字符"
                         valueStr:self.pwd
                  secureTextEntry:YES
                     keyboardType:UIKeyboardTypeDefault];
        cell.textValueChangedBlock = ^(NSString *valueStr){
            weakSelf.pwd = valueStr;
            [weakSelf updateNextBtnStatus];
        };
        return cell;
    }else
    {
        LeftTitleRightInputTextCell *cell = [LeftTitleRightInputTextCell cellWithTableView:tableView];
        [cell configWithLeftTitle:@"手机号"
                      placeholder:@"请输入手机号"
                         valueStr:self.phone
                  secureTextEntry:NO
                     keyboardType:UIKeyboardTypeNumberPad];
        cell.textValueChangedBlock = ^(NSString *valueStr){
            weakSelf.phone = valueStr;
            [weakSelf updateNextBtnStatus];
        };
        return cell;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
