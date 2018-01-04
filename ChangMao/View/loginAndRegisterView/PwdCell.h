//
//  PwdCell.h
//  ChamStore
//
//  Created by 景睦科技 on 2017/10/10.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PwdCell : UITableViewCell

@property (nonatomic,copy) void(^textValueChangedBlock)(NSString*);

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)configWithLeftTitle:(NSString *)title
                placeholder:(NSString *)phStr
                   valueStr:(NSString *)valueStr
            secureTextEntry:(BOOL)isSecure
               keyboardType:(UIKeyboardType)type;

@end
