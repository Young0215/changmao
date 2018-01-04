//
//  MessageCodeButton.m
//  ChamStore
//
//  Created by 景睦科技 on 2017/10/10.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import "MessageCodeButton.h"


@interface MessageCodeButton()

@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) NSTimeInterval durationToValidity;

@end

static CGFloat kFonfSize = 14;

@implementation MessageCodeButton

- (instancetype)init{
    self = [super init];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:kFonfSize];
        self.enabled = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:kFonfSize];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor colorWithHexString:@"c40516"] forState:UIControlStateNormal];
        self.enabled = YES;
        self.layer.borderColor = [[UIColor colorWithHexString:@"c40516"] CGColor];
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.height/2;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if (enabled) {
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    }else if ([self.titleLabel.text isEqualToString:@"获取验证码"]){
        [self setTitle:@"正在发送..." forState:UIControlStateNormal];
    }
}

- (void)startUpTimer{
    _durationToValidity = 60;
    
    if (self.isEnabled) {
        self.enabled = NO;
    }
    [self setTitle:[NSString stringWithFormat:@"%.0fs重新发送", _durationToValidity] forState:UIControlStateNormal];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(redrawTimer:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)invalidateTimer{
    if (!self.isEnabled) {
        self.enabled = YES;
    }
    [self.timer invalidate];
    self.timer = nil;
}

- (void)redrawTimer:(NSTimer *)timer {
    _durationToValidity--;
    if (_durationToValidity > 0) {
        self.titleLabel.text = [NSString stringWithFormat:@"%.0fs重新发送", _durationToValidity];//防止 button_title 闪烁
        [self setTitle:[NSString stringWithFormat:@"%.0fs重新发送", _durationToValidity] forState:UIControlStateNormal];
    }else{
        [self invalidateTimer];
    }
}



@end
