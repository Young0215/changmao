//
//  MessageCodeCell.h
//  ChamStore
//
//  Created by 景睦科技 on 2017/10/10.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageCodeButton.h"

@interface MessageCodeCell : UITableViewCell

@property (nonatomic,copy) void(^textValueChangedBlock)(NSString*);
@property (nonatomic,copy) void(^sendMessageCodeBtnClickedBlock)(MessageCodeButton *btn);

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)configWithLeftTitle:(NSString *)title
                placeholder:(NSString *)phStr
                   valueStr:(NSString *)valueStr;

@end
