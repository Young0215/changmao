//
//  JWVerCodeImageView.h
//  ChamStore
//
//  Created by 景睦科技 on 2017/10/11.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JWCodeImageBlock)(NSString *codeStr);

@interface JWVerCodeImageView : UIView

@property (nonatomic, strong) NSString *imageCodeStr;
@property (nonatomic, assign) BOOL isRotation;
@property (nonatomic, copy) JWCodeImageBlock bolck;

-(void)freshVerCode;

@end
