//
//  MessageCodeCell.m
//  ChamStore
//
//  Created by 景睦科技 on 2017/10/10.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import "MessageCodeCell.h"

static CGFloat padding = 0;  //titleLabel与textField的间距
static CGFloat cellFontSize = 16;

@interface MessageCodeCell()<UITextFieldDelegate>

@property(nonatomic,strong) UILabel *label;

@property(nonatomic,strong) UITextField *textField;

@property(nonatomic,strong) MessageCodeButton *codeBtn;

@end

@implementation MessageCodeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MessageCodeCell";
    MessageCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MessageCodeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
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
            //占0.25的宽度
            _label.font = [UIFont systemFontOfSize:cellFontSize];
            _label.textColor = kColorTextDarkGray;
            [self.contentView addSubview:_label];
        }
    }
    
    if (!_codeBtn) {
        _codeBtn = [[MessageCodeButton alloc] init];
        [self.contentView addSubview:_codeBtn];
        [_codeBtn addTarget:self action:@selector(codeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.delegate = self;
        _textField.backgroundColor = [UIColor clearColor];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.font = [UIFont systemFontOfSize:cellFontSize];
        [_textField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.contentView addSubview:_textField];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _label.frame = CGRectMake(15, 0, SCREEN_WIDTH/4, self.height);
    
    CGFloat codeBtnW = 100;
    CGFloat codeBtnX = self.width - 15 - codeBtnW;
    _codeBtn.frame = CGRectMake(codeBtnX, 7, codeBtnW, self.height-7*2);
    
    CGFloat textFieldX = _label.rightX + padding;
    CGFloat textFieldW = _codeBtn.x-10-textFieldX;
    _textField.frame = CGRectMake(textFieldX, 7, textFieldW, self.height-7*2);
}

- (void)configWithLeftTitle:(NSString *)title
                placeholder:(NSString *)phStr
                   valueStr:(NSString *)valueStr
{
    _label.text = title;
    
    _textField.placeholder = phStr?phStr:@"";
    _textField.text = valueStr;
    _textField.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)textValueChanged:(id)sender {
    if (self.textValueChangedBlock) {
        self.textValueChangedBlock(self.textField.text);
    }
}

- (void)codeBtnClicked:(MessageCodeButton *)codeBtn
{
    if (self.sendMessageCodeBtnClickedBlock) {
        self.sendMessageCodeBtnClickedBlock(codeBtn);
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [AppTools isMatchMobileFormat:textField range:range string:string];
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
