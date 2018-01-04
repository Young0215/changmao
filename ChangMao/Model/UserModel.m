//
//  UserModel.m
//  Loans
//
//  Created by 景睦科技 on 2017/9/18.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

@synthesize userId,phoneNum,phoneNumPsw;
@synthesize userName;

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - NSCoding
-(void) encodeWithCoder: (NSCoder *) encoder
{
    [encoder encodeObject:self.userId forKey: @"userId"];
    [encoder encodeObject:self.phoneNumPsw forKey: @"password"];


    [encoder encodeObject:self.phoneNum forKey: @"phonenum"];
    [encoder encodeObject:self.accessToken forKey: @"accessToken"];
    [encoder encodeObject:self.userName forKey:@"username"];
    
    
}

-(id) initWithCoder: (NSCoder *) decoder
{
        
    self.userId = [decoder decodeObjectForKey:@"userId"];
    self.phoneNumPsw = [decoder decodeObjectForKey:@"password"];
    self.phoneNum = [decoder decodeObjectForKey:@"phonenum"];
    self.accessToken = [decoder decodeObjectForKey:@"accessToken"];
    self.userName = [decoder decodeObjectForKey:@"username"];

    return self;
}

@end
