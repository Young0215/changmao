//
//  UIView+Extension.h
//  CategoryTool
//
//  Created by mac on 15/12/20.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property(nonatomic, assign) CGFloat x;
@property(nonatomic, assign) CGFloat y;

@property(nonatomic, assign) CGFloat centerX;
@property(nonatomic, assign) CGFloat centerY;

@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, assign) CGSize size;
@property(nonatomic, assign) CGPoint origin;

/**最大X值*/
@property(nonatomic, assign) CGFloat rightX;
/**最大Y值*/
@property(nonatomic, assign) CGFloat bottomY;

/**截屏*/
- (UIImage *)snapshotImage;

- (void)doBorderWidth:(CGFloat)width color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

/**
 *  圆形裁剪
 */
- (void)doCircleFrame;

/*
 *  获取view所在的controller
 */
- (UIViewController *)findCurrentViewController;

+ (instancetype)viewFromXib;

@end
