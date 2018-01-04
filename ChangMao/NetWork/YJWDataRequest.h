//
//  YJWDataRequest.h
//  Loans
//
//  Created by 景睦科技 on 2017/9/19.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import <Foundation/Foundation.h>


//块定义
typedef void(^YJWDateRequestSuccessBlock)(NSInteger statusCode,id data);
typedef void(^YJWDateRequestErrorBlock)(NSError *error);

@interface YJWDataRequest : NSObject

+(instancetype) sharedInstance;

//通用
-(void)universalWithURL:(NSString *)urlString
                  hDict:(NSMutableDictionary *)hDict
           successBlock:(YJWDateRequestSuccessBlock)successblock
             errorBlock:(YJWDateRequestErrorBlock)errorblock;

//+(NSString *)getImageCodeUrlWithImageKey:(NSString *)imageKey;



@end
