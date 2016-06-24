//
//  BillsDetailTableViewCell.m
//  TianTianStar
//
//  Created by LuisX on 16/6/7.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "BillsDetailTableViewCell.h"

@implementation BillsDetailTableViewCell{
    
    UIImageView *_avatarIV;
    UILabel *_firstTitleLB;
    UILabel *_secondeTitleLB;
    UILabel *_orderNameLB;
    UILabel *_orderNumberLB;
    UILabel *_tradeNumberLB;
    UILabel *_orderTimeLB;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createMainView];
        
    }
    
    return self;
    
}

- (void)createMainView{
    
    UIView *cellBackgroundView = [UIView new];
    cellBackgroundView.backgroundColor = [UIColor whiteColor];
    cellBackgroundView.layer.masksToBounds = YES;
    cellBackgroundView.layer.cornerRadius = 3;
    [self.contentView addSubview:cellBackgroundView];
    [cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(20);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.bottom.equalTo(self.contentView);
        
    }];
    
    //头像
    _avatarIV = [UIImageView new];
    _avatarIV.backgroundColor = COLOR_ALL_BACKGROUND;
    _avatarIV.contentMode = 2;
    _avatarIV.clipsToBounds = YES;
    _avatarIV.contentMode = 2;
    _avatarIV.clipsToBounds = YES;
    [cellBackgroundView addSubview:_avatarIV];
    [_avatarIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(cellBackgroundView).offset(10);
        make.width.height.mas_equalTo(80);
        
    }];
    
    //主标题
    _firstTitleLB = [UILabel new];
    //_firstTitleLB.backgroundColor = [UIColor redColor];
    _firstTitleLB.text = @"花儿朵朵幼儿园托费";
    _firstTitleLB.numberOfLines = 0;
    _firstTitleLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:14];
    _firstTitleLB.textColor = COLOR_TEXT_BLACK28;
    [cellBackgroundView addSubview:_firstTitleLB];
    [_firstTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_avatarIV);
        make.left.equalTo(_avatarIV.mas_right).offset(10);
        make.right.equalTo(cellBackgroundView).offset(-10);
        
    }];
    
    //次标题
    _secondeTitleLB = [UILabel new];
    //_secondeTitleLB.backgroundColor = [UIColor orangeColor];
    _secondeTitleLB.text = @"399.00元";
    _secondeTitleLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:30];
    _secondeTitleLB.textColor = COLOR_RED_BACKGROUND;
    [cellBackgroundView addSubview:_secondeTitleLB];
    [_secondeTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.greaterThanOrEqualTo(_firstTitleLB.mas_bottom).offset(10);
        make.right.equalTo(cellBackgroundView).offset(-10);
        
    }];
    
    //黑线
    UIView *blackLine = [UIView new];
    blackLine.backgroundColor = COLOR_LINE_GRAY;
    [cellBackgroundView addSubview:blackLine];
    [blackLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_secondeTitleLB.mas_bottom).offset(5);
        make.top.greaterThanOrEqualTo(_avatarIV.mas_bottom).offset(20);
        make.left.right.equalTo(cellBackgroundView);
        make.height.mas_equalTo(1.0f);
        
    }];
    
    //订单名称
    _orderNameLB = [UILabel new];
    _orderNameLB.text = @"收费单位:  花儿朵朵";
    _orderNameLB.textColor = COLOR_TEXT_GRAY;
    _orderNameLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:14];
    _orderNameLB.numberOfLines = 0;
    _orderNameLB.lineBreakMode = NSLineBreakByCharWrapping;
    //_orderNameLB.backgroundColor = [UIColor orangeColor];
    [cellBackgroundView addSubview:_orderNameLB];
    [_orderNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(blackLine.mas_bottom).offset(20);
        make.left.equalTo(_avatarIV);
        make.right.equalTo(_secondeTitleLB);
        
    }];
    
    //订单编号
    _orderNumberLB = [UILabel new];
    _orderNumberLB.text = @"订单编号:  13487231980748321";
    _orderNumberLB.textColor = COLOR_TEXT_GRAY;
    _orderNumberLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:14];
    _orderNumberLB.numberOfLines = 0;
    _orderNumberLB.lineBreakMode = NSLineBreakByCharWrapping;
    //_orderNumberLB.backgroundColor = [UIColor orangeColor];
    [cellBackgroundView addSubview:_orderNumberLB];
    [_orderNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_orderNameLB.mas_bottom).offset(10);
        make.left.right.equalTo(_orderNameLB);
        
    }];
    
    
    //交易号
    _tradeNumberLB = [UILabel new];
    _tradeNumberLB.text = @"交易号码:  32532908578490327";
    _tradeNumberLB.textColor = COLOR_TEXT_GRAY;
    _tradeNumberLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:14];
    _tradeNumberLB.numberOfLines = 0;
    _tradeNumberLB.lineBreakMode = NSLineBreakByCharWrapping;
    //_tradeNumberLB.backgroundColor = [UIColor orangeColor];
    [cellBackgroundView addSubview:_tradeNumberLB];
    [_tradeNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_orderNumberLB.mas_bottom).offset(10);
        make.left.right.equalTo(_orderNameLB);
        
    }];
    
    
    //成交时间
    _orderTimeLB = [UILabel new];
    _orderTimeLB.text = @"成交时间:  2016-0606 13:35:00";
    _orderTimeLB.textColor = COLOR_TEXT_GRAY;
    _orderTimeLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:14];
    _orderTimeLB.numberOfLines = 0;
    _orderTimeLB.lineBreakMode = NSLineBreakByCharWrapping;
    //_orderTimeLB.backgroundColor = [UIColor orangeColor];
    [cellBackgroundView addSubview:_orderTimeLB];
    [_orderTimeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_tradeNumberLB.mas_bottom).offset(10);
        make.left.right.equalTo(_orderNameLB);
        make.bottom.equalTo(self.contentView).offset(-30);
    }];

    
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
