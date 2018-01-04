//
//  UserModel.h
//  Loans
//
//  Created by 景睦科技 on 2017/9/18.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString       *userId; //用户ID

@property (nonatomic, copy) NSString       *phoneNum; //用户手机号

@property (nonatomic, copy) NSString       *phoneNumPsw; //账户密码

@property (nonatomic, copy) NSString       *accessToken;//用户token

@property (nonatomic, copy) NSString       *userName; //用户名称


@end
