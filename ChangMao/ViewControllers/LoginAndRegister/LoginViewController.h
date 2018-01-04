//
//  LoginViewController.h
//  ChamStore
//
//  Created by 景睦科技 on 2017/10/10.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginSuccessBlock)();
typedef void(^LoginSkipBlock)();

@interface LoginViewController : UIViewController

/**
 *  登录成功之后跳到首页。
 */
@property(nonatomic,copy) LoginSuccessBlock successBlock;
@property(nonatomic,copy) LoginSkipBlock skipBlock;

- (instancetype)initWithLoginSuccess:(LoginSuccessBlock)successBlock
                                skip:(LoginSkipBlock)skipBlock;

@end
