//
//  PwdCell.m
//  ChamStore
//
//  Created by 景睦科技 on 2017/10/10.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import "PwdCell.h"

static CGFloat padding = 0;  //titleLabel与textField的间距
static CGFloat cellFontSize = 16;

@interface PwdCell ()<UITextFieldDelegate>

@property(nonatomic,strong) UILabel *label;

@property (strong, nonatomic) UITextField *textField;

@end

@implementation PwdCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"PwdCell";
    PwdCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (cell == nil) {
        cell = [[PwdCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (!_label) {
            _label = [[UILabel alloc] init];
            _label.font = [UIFont systemFontOfSize:cellFontSize];
            _label.textColor = kColorTextDarkGray;
            [self.contentView addSubview:_label];
        }
        
        if (!_textField) {
            _textField = [[UITextField alloc]init];
            _textField.backgroundColor = [UIColor clearColor];
            _textField.delegate = self;
            _textField.borderStyle = UITextBorderStyleNone;
            _textField.font = [UIFont systemFontOfSize:cellFontSize];
            [_textField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
            _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            [self.contentView addSubview:_textField];
        }
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _label.frame = CGRectMake(15, 0, SCREEN_WIDTH/4, self.height);
    
    CGFloat textFieldH = self.height - 7*2;
    _textField.frame = CGRectMake(_label.rightX+padding, 7.0, SCREEN_WIDTH*0.75 - padding - 15*2, textFieldH);
}

- (void)configWithLeftTitle:(NSString *)title
                placeholder:(NSString *)phStr
                   valueStr:(NSString *)valueStr
            secureTextEntry:(BOOL)isSecure
               keyboardType:(UIKeyboardType)type
{
    _label.text = title;
    
    _textField.placeholder = phStr?phStr:@"";
    _textField.text = valueStr;
    _textField.secureTextEntry = isSecure;
    _textField.keyboardType = type;
}

- (void)textValueChanged:(id)sender {
    if (self.textValueChangedBlock) {
        self.textValueChangedBlock(self.textField.text);
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [AppTools isMatchPasswordFormat:textField range:range string:string];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
