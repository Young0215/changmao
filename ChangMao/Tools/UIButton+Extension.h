//
//  UIButton+Extension.h
//  CategoryTool
//
//  Created by mac on 15/12/20.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/**
 *  设置不同状态下的背景色
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

/**
 *  设置通用的按钮颜色(红色背景，白色字体)
 */
- (void)configCustomColor;
@end
