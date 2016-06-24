//
//  PayTypeTableViewCell.m
//  TianTianStar
//
//  Created by LuisX on 16/6/8.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "PayTypeTableViewCell.h"

@implementation PayTypeTableViewCell{
    
    UIImageView *_payIconIV;
    UILabel *_contentLB;
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
    
    //图标
    _payIconIV = [UIImageView new];
    //_payIconIV.backgroundColor = [UIColor redColor];
    _payIconIV.contentMode = 1;
    _payIconIV.clipsToBounds = YES;
    [self.contentView addSubview:_payIconIV];
    [_payIconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(self.contentView).offset(20);
        make.width.height.mas_equalTo(44);
        
    }];
    
    
    UIImageView *rightArrow = [UIImageView new];
    //rightArrow.backgroundColor = [UIColor redColor];
    [rightArrow setImage:[UIImage imageNamed:@"userCenter_rightArrow"]];
    rightArrow.contentMode = 1;
    rightArrow.clipsToBounds = YES;
    [self.contentView addSubview:rightArrow];
    [rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(_payIconIV);
        make.width.height.mas_equalTo(22);
        
    }];
    
    //文本
    _contentLB = [UILabel new];
    //_contentLB.backgroundColor = [UIColor redColor];
    _contentLB.textColor = COLOR_TEXT_BLACK28;
    _contentLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:16];
    [self.contentView addSubview:_contentLB];
    [_contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.bottom.equalTo(_payIconIV);
        make.left.equalTo(_payIconIV.mas_right).offset(10);
        make.right.equalTo(rightArrow.mas_left).offset(-10);
        make.bottom.equalTo(self.contentView);
    }];
    
}




- (void)setModel:(PayTypeModel *)model{
    
    if (_model != model) {
        
        _model = model;
        [_payIconIV setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", model.iconName]]];
        _contentLB.text = [NSString stringWithFormat:@"%@", model.payTypeName];
        
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
