//
//  AppDelegate.m
//  ChangMao
//
//  Created by 景睦科技 on 2017/10/17.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "FenLeiViewController.h"
#import "NewestViewController.h"
#import "ShoppingCarViewController.h"
#import "MyViewController.h"
#import "LoginViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [WXApi registerApp:@"wx4dc2965a4bd21563"];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    [NSThread sleepForTimeInterval:1];
    
    [self congigVender];
    
    [self addTabBarController];
    
    return YES;
}

- (void)addTabBarController
{
    
    //  tabBar控制器
    self.customerTB = [[UITabBarController alloc] init];
    self.customerTB.delegate = self;
    self.window.rootViewController = self.customerTB;
    
    HomeViewController *home = [[HomeViewController alloc] init];
    home.tabBarItem.tag = 1;
    home.tabBarItem.image = [UIImage imageNamed:@"home"];
    home.tabBarItem.selectedImage = [UIImage imageNamed:@"home_s"];
    home.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
//    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    
    FenLeiViewController *fenlei = [[FenLeiViewController alloc] init];
    fenlei.tabBarItem.tag = 2;
    fenlei.tabBarItem.image = [UIImage imageNamed:@"fenlei"];
    fenlei.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    fenlei.tabBarItem.selectedImage = [UIImage imageNamed:@"fenlei_s"];
//    UINavigationController *messageNav = [[UINavigationController alloc] initWithRootViewController:message];
    
    NewestViewController *newest = [[NewestViewController alloc] init];
    newest.tabBarItem.tag = 3;
    newest.tabBarItem.image = [UIImage imageNamed:@"suosuo"];
    newest.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    newest.tabBarItem.selectedImage = [UIImage imageNamed:@"suosuo_se"];
//    UINavigationController *myNav = [[UINavigationController alloc] initWithRootViewController:my];
    
    ShoppingCarViewController *car = [[ShoppingCarViewController alloc] init];
    car.tabBarItem.tag = 4;
    car.tabBarItem.image = [UIImage imageNamed:@"shop"];
    car.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    car.tabBarItem.selectedImage = [UIImage imageNamed:@"shop_s"];
//    UINavigationController *myNav = [[UINavigationController alloc] initWithRootViewController:my];
    
    MyViewController *my = [[MyViewController alloc] init];
    my.tabBarItem.tag = 5;
    my.tabBarItem.image = [UIImage imageNamed:@"me"];
    my.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0,-6, 0);
    my.tabBarItem.selectedImage = [UIImage imageNamed:@"me_s"];
//    UINavigationController *myNav = [[UINavigationController alloc] initWithRootViewController:my];
    
    self.customerTB.viewControllers = @[home,fenlei,newest,car,my];
    
    
}

- (void)congigVender
{
    //IQKeyboardManager
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    
}

#pragma mark - Tabbar Delegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
//    if (viewController.tabBarItem.tag == 5) {
//        
//        // 弹出登录页面
//        if (![AppTools isUserLogin]) {
//            LoginViewController *loginVC = [[LoginViewController alloc] init];
//            UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginVC];
//            [self.window.rootViewController presentViewController:loginNav animated:NO completion:^(){
////            [UserModel clearLocalUserModel];
//            }];
//            return NO;
//        }else{
//            return YES;
//        }
//    }else {
//        if (viewController.tabBarItem.tag == 1) {
//            [self.customerTB setSelectedIndex:0];
//            return YES;
//        }else if (viewController.tabBarItem.tag == 2){
//            [self.customerTB setSelectedIndex:1];
//            return YES;
//        }else if (viewController.tabBarItem.tag == 3){
//            [self.customerTB setSelectedIndex:2];
//            return YES;
//        }else {
//            [self.customerTB setSelectedIndex:3];
//            return YES;
//        }
//        
//    }
    
    return YES;
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//9.0前的方法

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result1 = %@",resultDic);
            
        }];
    }else{
        return [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result2 = %@",resultDic);
        }];
    }else{
        return  [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

//9.0前的方法，为了适配低版本 保留
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    return [WXApi handleOpenURL:url delegate:self];
//}
//
////9.0后的方法
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
//    //这里判断是否发起的请求为微信支付，如果是的话，用WXApi的方法调起微信客户端的支付页面（://pay 之前的那串字符串就是你的APPID，）
//    return  [WXApi handleOpenURL:url delegate:self];
//}


#pragma mark -- WXApiDelegate
//微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的
-(void) onResp:(BaseResp*)resp
{
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                payResoult = @"支付结果：成功！";
                break;
            case -1:
                payResoult = @"支付结果：失败！";
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
