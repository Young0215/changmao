//
//  YJWDataRequest.m
//  Loans
//
//  Created by 景睦科技 on 2017/9/19.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import "YJWDataRequest.h"

@implementation YJWDataRequest

#pragma mark - 单例初始化
static YJWDataRequest *instance = nil;

+(instancetype)sharedInstance
{
    @synchronized(self) {
        if (instance == nil) {
            instance = [[YJWDataRequest alloc] init];  //此处调用allocWithZone
        }
    }
    return instance;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self) {
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

-(id)copyWithZone:(NSZone*)zone
{
    return self;
}

#pragma mark - 以下开始获取数据
//通用

-(void)universalWithURL:(NSString *)urlString
                  hDict:(NSMutableDictionary *)hDict
           successBlock:(YJWDateRequestSuccessBlock)successblock
             errorBlock:(YJWDateRequestErrorBlock)errorblock;
{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    if(reach.isReachable){
        [AppTools doGet:urlString hDict:hDict successBlock:^(NSInteger statusCode, id data) {
            if ([data isKindOfClass:[NSDictionary class]]) {
                successblock(statusCode,data);
            }else{
                NSError *error = [[NSError alloc] initWithDomain:@"error" code:ServerDataErrorCode userInfo:@{@"msg":ServerDataErrorMessage}];
                errorblock(error);
            }
        } errorBlock:^(NSError *error) {
            errorblock(error);
        }];
    }else{
        NSError *error = [[NSError alloc] initWithDomain:@"error" code:NoNetWorkErrorCode userInfo:@{@"msg":NoNetWorkErrorMessage}];
        errorblock(error);
    }
}


@end
