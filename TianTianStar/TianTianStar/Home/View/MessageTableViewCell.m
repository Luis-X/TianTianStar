//
//  MessageTableViewCell.m
//  ShipPad
//
//  Created by LuisX on 16/4/19.
//  Copyright © 2016年 junFun. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell{
    UILabel *_contentLB;
    UILabel *_timeLB;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createMainViews];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return self;
    
}

- (void)createMainViews{
    
    //时间
    _timeLB = [UILabel new];
    //_timeLB.backgroundColor = [UIColor orangeColor];
    _timeLB.textAlignment = NSTextAlignmentCenter;
    _timeLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:12];
    _timeLB.textColor = COLOR_TEXT_GRAY;
    [self.contentView addSubview:_timeLB];
    [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(20);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        
    }];
    
    //内容背景
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.borderColor = COLOR_LINE_GRAY.CGColor;
    contentView.layer.borderWidth = 1;
    contentView.layer.cornerRadius = 5;
    [self.contentView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_timeLB.mas_bottom).offset(5);
        make.left.right.equalTo(_timeLB);
        make.bottom.equalTo(self.contentView);
        
    }];

    
    //内容
    _contentLB = [UILabel new];
    _contentLB.backgroundColor = [UIColor whiteColor];
    _contentLB.numberOfLines = 0;
    _contentLB.lineBreakMode = NSLineBreakByClipping;
    [contentView addSubview:_contentLB];
    [_contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(contentView).offset(10);
        make.bottom.right.equalTo(contentView).offset(-10);
        
    }];
}

- (void)setNoticeMessageObject:(AVObject *)noticeMessageObject{
    
    if (_noticeMessageObject != noticeMessageObject) {
    
        _noticeMessageObject = noticeMessageObject;
        NSString *textStr = [noticeMessageObject objectForKey:@"noticeMessage"];
        NSDate *updatedDate = [noticeMessageObject objectForKey:@"updatedAt"];
        
        _contentLB.attributedText = [[NSAttributedString alloc] initWithString:textStr attributes:[Constant settingAttributesWithLineSpacing:5 FirstLineHeadIndent:0 Font:[UIFont fontWithName:FONT_LANTING_JIANHEI size:14] TextColor:COLOR_TEXT_BLACK28]];
        _timeLB.text = [updatedDate formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
        
    }
    
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
