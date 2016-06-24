//
//  AddressBookTableViewCell.m
//  TianTianStar
//
//  Created by LuisX on 16/6/12.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "AddressBookTableViewCell.h"


@implementation AddressBookTableViewCell{
    UIImageView *_avaterIV;
    UILabel *_nameLB;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        [self createSubViews];
        
    }
    
    return self;
}

- (void)createSubViews{
    
    _avaterIV = [UIImageView new];
    //_avaterIV.backgroundColor = [UIColor redColor];
    [_avaterIV setImage:[UIImage imageNamed:@"2.jpg"]];
    _avaterIV.contentMode = 2;
    _avaterIV.clipsToBounds = YES;
    [self.contentView addSubview:_avaterIV];
    [_avaterIV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.width.height.mas_equalTo(40);
        
    }];
    
    _nameLB = [UILabel new];
    //_nameLB.backgroundColor = [UIColor redColor];
    _nameLB.textColor = COLOR_TEXT_BLACK28;
    _nameLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:16];
    [self.contentView addSubview:_nameLB];
    [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_avaterIV.mas_right).offset(10);
        make.centerY.equalTo(self.contentView);
        make.right.lessThanOrEqualTo(self.contentView).offset(-15);
        
    }];
}

- (void)setModel:(AVObject *)model{
    
    if (_model != model) {
        _model = model;
        
        _nameLB.text = [NSString stringWithFormat:@"%@", [model objectForKey:@"username"]];
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
