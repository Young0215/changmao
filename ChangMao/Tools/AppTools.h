//
//  AppTools.h
//  Loans
//
//  Created by 景睦科技 on 17/9/11.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UserModel.h"

//块定义
typedef void(^YJWFetcherSuccessBlock)(NSInteger statusCode,id data);
typedef void(^YJWFetcherErrorBlock)(NSError *error);

@interface AppTools : NSObject

/**
 正则表达式
 */

+ (BOOL)validateByRegex:(NSString *)regex withObject:(id)object;

/**
 验证手机号码格式
 */
+(BOOL) isValidateMobile:(NSString *)mobile;

/**
 验证身份证号格式
 */
+ (BOOL)validateIdentityCard: (NSString *)identityCard;


/**
 提示框
 */
+ (void)showString:(NSString*)string, ...;

+ (void)showStringWithTime:(NSTimeInterval)delayTime string:(NSString*)string, ...;


/**
 图片转data
 */
+ (NSData*)getDataFromImage:(UIImage*)image;

/**
 验证手机登录状态
 */
+(BOOL) isUserLogin;

/*
 获取登录用户
 */
+(UserModel *)getLoginUser;

/**
 MD5加密
 */
+ (NSString *)encryption:(NSString *)input;

/**
 限制验证码输入格式-6位数字
 */
+ (BOOL)isMatchVerifyCodeFormat:(UITextField *)textField range:(NSRange)range string:(NSString *)string;
/**
 限制验证码输入格式-4位数字
 */
+ (BOOL)isMatchImageCodeFormat:(UITextField *)textField range:(NSRange)range string:(NSString *)string;
/**
 限制密码输入格式
 */
+ (BOOL)isMatchPasswordFormat:(UITextField *)textField range:(NSRange)range string:(NSString *)string;

/**
 限制手机号输入格式
 */
+ (BOOL)isMatchMobileFormat:(UITextField *)textField range:(NSRange)range string:(NSString *)string;

/**
 截取URL 获取订单信息 和支付金额
 */

+ (NSDictionary *)dictionaryWithUrlString:(NSString *)urlStr;

/**
 get请求数据
 */
+ (void)doGet:(NSString*)urlString
        hDict:(NSMutableDictionary *)hDict
 successBlock:(YJWFetcherSuccessBlock)successblock
   errorBlock:(YJWFetcherErrorBlock)errorblock;

/**
 post请求数据
 */
+ (void)doPost:(NSString*)urlString
    parameters:(NSMutableDictionary *)pDict
  successBlock:(YJWFetcherSuccessBlock)successblock
    errorBlock:(YJWFetcherErrorBlock)errorblock;

@end
