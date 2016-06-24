//
//  BillsTableViewCell.m
//  TianTianStar
//
//  Created by LuisX on 16/6/7.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "BillsTableViewCell.h"

@implementation BillsTableViewCell{
    
    UIImageView *_avatarIV;
    UILabel *_firstTitleLB;
    UILabel *_secondTitleLB;
    UILabel *_contentLB;
    
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
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView);
        
    }];
    
    _firstTitleLB = [UILabel new];
    //_firstTitleLB.backgroundColor = [UIColor redColor];
    _firstTitleLB.text = @"399.0";
    _firstTitleLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:25];
    _firstTitleLB.textColor = COLOR_RED_BACKGROUND;
    [cellBackgroundView addSubview:_firstTitleLB];
    [_firstTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(cellBackgroundView).offset(10);
        make.height.mas_equalTo(40);
        make.right.lessThanOrEqualTo(cellBackgroundView.mas_centerX).offset(-30);
        
    }];
    
    UILabel *dayWordLB = [UILabel new];
    //dayWordLB.backgroundColor = [UIColor orangeColor];
    dayWordLB.text = @"元";
    dayWordLB.textColor = COLOR_TEXT_GRAY;
    dayWordLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:14];
    [cellBackgroundView addSubview:dayWordLB];
    [dayWordLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_firstTitleLB).offset(8);
        make.left.equalTo(_firstTitleLB.mas_right).offset(3);
        
    }];
    
     _avatarIV = [UIImageView new];
    //_avatarIV.backgroundColor = [UIColor grayColor];
    _avatarIV.contentMode = 1;
    _avatarIV.clipsToBounds = YES;
    [_avatarIV setImage:[UIImage imageNamed:@"Bills_order"]];
    [cellBackgroundView addSubview:_avatarIV];
    [_avatarIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_firstTitleLB);
        make.right.equalTo(cellBackgroundView).offset(-10);
        make.width.height.mas_equalTo(40);
        
    }];
    
    _secondTitleLB = [UILabel new];
    //_secondTitleLB.backgroundColor = [UIColor redColor];
    _secondTitleLB.text = @"花儿朵朵幼儿园托费";
    _secondTitleLB.textColor = COLOR_TEXT_BLACK28;
    _secondTitleLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:14];
    _secondTitleLB.numberOfLines = 2;
    [cellBackgroundView addSubview:_secondTitleLB];
    [_secondTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(_firstTitleLB);
        make.right.equalTo(_avatarIV.mas_left).offset(-5);
        make.left.greaterThanOrEqualTo(cellBackgroundView.mas_centerX);
        
    }];
    
    _contentLB = [UILabel new];
    //_contentLB.backgroundColor = [UIColor yellowColor];
    _contentLB.text = [[NSDate date] formattedDateWithStyle:NSDateFormatterFullStyle];
    _contentLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:14];
    _contentLB.textColor = COLOR_TEXT_GRAY;
    _contentLB.numberOfLines = 0;
    [cellBackgroundView addSubview:_contentLB];
    [_contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_firstTitleLB.mas_bottom).offset(20);
        make.left.equalTo(_firstTitleLB.mas_left);
        make.right.equalTo(_avatarIV.mas_right);
        make.bottom.lessThanOrEqualTo(cellBackgroundView.mas_bottom).offset(-10);
        
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
