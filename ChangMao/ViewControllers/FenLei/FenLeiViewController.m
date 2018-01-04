//
//  FenLeiViewController.m
//  ChangMao
//
//  Created by 景睦科技 on 2017/10/17.
//  Copyright © 2017年 景睦科技. All rights reserved.
//  分类

#import "FenLeiViewController.h"

@interface FenLeiViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,UIWebViewDelegate>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, assign) BOOL      checkLoading;

@end

@implementation FenLeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatusBarBackgroundColor:[UIColor whiteColor]];//@"c40516"
    self.checkLoading = NO;
    //    WKWebView
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREENH_HEIGHT - 20) configuration:configuration];
    
    // 创建URL
    NSURL *url = [NSURL URLWithString:@"http://www.168zgcm.com/mobile/catalog.php"];
    // 创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 加载网页
    [self.webView loadRequest:request];
    
    
    self.webView.UIDelegate = self;
    
    self.webView.navigationDelegate = self;
    
    [self.view addSubview:self.webView];

}

#pragma mark   ==============产生随机订单号==============

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

#pragma mark-----  设置状态栏颜色

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    if (self.checkLoading) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    NSLog(@"didStartProvisionalNavigation");
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"didCommitNavigation");
   [MBProgressHUD hideHUDForView:self.view animated:YES]; 
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [MBProgressHUD hideHUDForView:webView animated:YES];
    NSLog(@"didFinishNavigation");
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
    NSLog(@"didReceiveServerRedirectForProvisionalNavigation");
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
//    [webView stopLoading];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"33%@",navigationAction.request.URL.absoluteString);
    NSString *urlString = navigationAction.request.URL.absoluteString;
    if (WKNavigationTypeBackForward) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
   
    // containsString
    if ([urlString containsString:@"goods.php"]) {
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = YES;
    }else if ([urlString containsString:@"step=cart"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = YES;
        
    }else if ([urlString containsString:@"step=checkout"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = YES;
        
    }else if ([urlString containsString:@"act=order_list"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = YES;
        
    }
//    else if ([urlString containsString:@"flow.php"]){
//        NSLog(@"包含");
//        self.checkLoading = YES;
//        [self.tabBarController setSelectedIndex:3];
//        self.tabBarController.tabBar.hidden = NO;
//        
//    }
    else if ([urlString containsString:@"supplier.php"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = YES;
        
    }else if ([urlString isEqualToString:@"http://www.168zgcm.com/mobile/"]){
        
        [self.tabBarController setSelectedIndex:0];
        self.tabBarController.tabBar.hidden = NO;
        
    }else if ([urlString containsString:@"tencent://message"]){
        self.checkLoading = YES;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //是否安装QQ
        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
        {
            //调用QQ客户端,发起QQ临时会话
//            NSString  *qqNumber=@"1918263902";
//            NSString *url = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",QQ];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }else{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"温馨提示"message:@"你还没安装QQ，请安装后再进行咨询！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                
            }];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }else if ([urlString containsString:@"mqqwpa://im"]){
        self.checkLoading = YES;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //是否安装QQ
        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
        {
            //调用QQ客户端,发起QQ临时会话
//            NSString  *qqNumber=@"1918263902";
//            NSString *url = [NSString stringWithFormat:@"mqqwpa://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web&web_src=oicqzone.com",qqNumber];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }else{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"温馨提示"message:@"你还没安装QQ，请安装后再进行咨询！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                
            }];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }else if ([urlString containsString:@"weixin://wap/pay?"]){
        // 微信支付
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        
    }else if ([urlString containsString:@"wappaygw.alipay.com"]){//  alipay
        self.checkLoading = YES;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
//        if ([urlString containsString:@"wappaygw.alipay.com"]) {//  alipayapi.php?
        // 支付宝支付
        NSString* orderInfo = [[AlipaySDK defaultService]fetchOrderInfoFromH5PayUrl:urlString];
        NSLog(@"信息：%@",orderInfo);
        if (orderInfo.length > 0) {
            [self payWithUrlOrder:orderInfo];
        }
            
//            NSDictionary *strDic = [AppTools dictionaryWithUrlString:urlString];
//            NSLog(@"订单号 金额 %@",strDic);
//            NSString *appScheme = @"cmalipay";
//            Order *order = [[Order alloc] init];
//            order.partner = PARTNER;
//            order.sellerID = SELLER;
//            order.outTradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
//            order.subject = [strDic objectForKey:@"out_trade_no"]; //商品标题
//            order.totalFee = [strDic objectForKey:@"total_fee"]; //商品价格
//            NSString *orderSpec = [order description];
//            NSLog(@"orderSpec = %@",orderSpec);
//            
//            //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//            id<DataSigner> signer = CreateRSADataSigner(RSA_PRIVATE);
//            NSString *signedString = [signer signString:orderSpec];
//            
//            //将签名成功字符串格式化为订单字符串,请严格按照该格式
//            NSString *orderString = nil;
//            if (signedString != nil) {
//                orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                               orderSpec, signedString, @"RSA"];
//                [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//                    NSLog(@"reslut3 = %@",resultDic);
//                }];
//            }
//        }
    }
    else {
        NSLog(@"不包含");
        self.tabBarController.tabBar.hidden = NO;
    }
    
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}

#pragma mark -- WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //JS调用OC方法
    
    [self.webView evaluateJavaScript:@"android.setFinish()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"11%@",result);
    }];
    
    //message.boby就是JS里传过来的参数
    NSLog(@"body:%@",message.body);
    
}

- (void)removeScriptMessageHandlerForName:(NSString *)name {
    
    
}

#pragma mark   ============== URL pay 开始支付 ==============

- (void)payWithUrlOrder:(NSString*)urlOrder
{
    if (urlOrder.length > 0) {
//        __weak FenLeiViewController* wself = self;
        [[AlipaySDK defaultService]payUrlOrder:urlOrder fromScheme:@"cmalipay" callback:^(NSDictionary* result) {
            // 处理支付结果
            NSLog(@"支付结果%@", result);
            
            NSLog(@"结果 %@",[result objectForKey:@"memo"]);
            // isProcessUrlPay 代表 支付宝已经处理该URL
//            if ([result[@"isProcessUrlPay"] boolValue]) {
//                // returnUrl 代表 第三方App需要跳转的成功页URL
//                NSString* urlStr = result[@"returnUrl"];
//                
//            }
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
