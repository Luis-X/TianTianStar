//
//  MineTableViewCell.m
//  TianTianStar
//
//  Created by LuisX on 16/6/15.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell{
    
    UIImageView *_rightArrowIV;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createMainView];
        
    }
    
    return self;
}


- (void)createMainView{
    
    //文字居中
    _contentLB = [UILabel new];
    _contentLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:16];
    _contentLB.layer.masksToBounds = YES;
    _contentLB.layer.cornerRadius = 3;
    [self.contentView addSubview:_contentLB];
    [_contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(25);
        make.right.equalTo(self.contentView).offset(-25);
        
    }];
    
    //箭头
    _rightArrowIV = [UIImageView new];
    _rightArrowIV.contentMode = 1;
    _rightArrowIV.image = [UIImage imageNamed:@"userCenter_rightArrow.png"];
    //_rightArrowIV.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_rightArrowIV];
    [_rightArrowIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-5);
        make.width.height.mas_equalTo(20);
    }];

}

- (void)setMineStyle:(MineTableViewCellStyle)mineStyle{
    
    if (_mineStyle != mineStyle) {
        _mineStyle = mineStyle;
    }
    
    //普通样式
    if (_mineStyle == MineCellStyleNormal) {
        
        _rightArrowIV.hidden = NO;
        self.backgroundColor = [UIColor whiteColor];
        _contentLB.textColor = COLOR_TEXT_BLACK28;
        _contentLB.textAlignment = NSTextAlignmentLeft;
        
    }
    
    //电话样式
    if (_mineStyle == MineCellStylePhone) {
        
        _rightArrowIV.hidden = YES;
        self.backgroundColor = [UIColor whiteColor];
        _contentLB.backgroundColor = [UIColor clearColor];
        _contentLB.textColor = COLOR_TEXT_ORANGE;
        _contentLB.textAlignment = NSTextAlignmentCenter;
        
    }
    
    //登出样式
    if (_mineStyle == MineCellStylelogout) {
        
        _rightArrowIV.hidden = YES;
         self.backgroundColor = [UIColor clearColor];
         _contentLB.backgroundColor = COLOR_RED_BACKGROUND;
         _contentLB.textColor = [UIColor whiteColor];
        _contentLB.textAlignment = NSTextAlignmentCenter;
        
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
