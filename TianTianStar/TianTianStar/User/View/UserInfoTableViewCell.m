//
//  UserInfoTableViewCell.m
//  TianTianGarden
//
//  Created by LuisX on 16/4/5.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "UserInfoTableViewCell.h"

@implementation UserInfoTableViewCell{
    UIImageView *_picContent;
    UILabel *_textContentLB;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self createSubViews];
        
    }
    return self;
}

- (void)createSubViews{
    //标题
    _titleLB = [UILabel new];
    _titleLB.textColor = COLOR_TEXT_BLACK28;
    _titleLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:14];
    //_titleLB.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_titleLB];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    //箭头
    UIImageView *rightArrowIV = [UIImageView new];
    rightArrowIV.contentMode = 1;
    rightArrowIV.image = [UIImage imageNamed:@"userCenter_rightArrow.png"];
    //rightArrowIV.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:rightArrowIV];
    [rightArrowIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-10);
        make.width.height.mas_equalTo(20);
    }];
    
    //文字内容
    _textContentLB = [UILabel new];
    _textContentLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:14];
    _textContentLB.textColor = COLOR_TEXT_GRAY;
    //_textContentLB.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_textContentLB];
    [_textContentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(rightArrowIV.mas_left).offset(-5);
    }];
    
    //图片内容
    _picContent = [UIImageView new];
    //_picContent.backgroundColor = [UIColor redColor];
    _picContent.layer.cornerRadius = 70 / 2;
    _picContent.contentMode = 2;
    _picContent.clipsToBounds = YES;
    _picContent.image = [UIImage imageNamed:@"1.jpg"];
    _picContent.hidden = YES;
    [self.contentView addSubview:_picContent];
    [_picContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(rightArrowIV.mas_left).offset(-5);
        make.width.height.mas_equalTo(70);
    }];
}



- (void)updateUserInfoDetailDataWithCellIndexPath:(NSIndexPath *)cellIndexPath Model:(UserModel *)model{
    
    //头像
    if (cellIndexPath.section == 0 && cellIndexPath.row == 0) {
        _picContent.hidden = NO;
        _textContentLB.text = model.avater;
    }
    
    //姓名
    if (cellIndexPath.section == 0 && cellIndexPath.row == 1) {
        _textContentLB.text = model.username;
        NSLog(@"%@", model.username);
    }
    
    //性别
    if (cellIndexPath.section == 0 && cellIndexPath.row == 2) {
        _textContentLB.text = model.sex;
    }
    
    //班级
    if (cellIndexPath.section == 0 && cellIndexPath.row == 3) {
        _textContentLB.text = model.classroom;
    }
    
    //入学时间
    if (cellIndexPath.section == 0 && cellIndexPath.row == 4) {
        _textContentLB.text = [model.admissionDate formattedDateWithStyle:NSDateFormatterLongStyle];
    }
    
    //手机号
    if (cellIndexPath.section == 0 && cellIndexPath.row == 5) {
        _textContentLB.text = model.mobilePhoneNumber;
    }
    
    //家庭住址
    if (cellIndexPath.section == 1 && cellIndexPath.row == 0) {
        _textContentLB.text = model.address;
    }
    
    //联系电话
    if (cellIndexPath.section == 1 && cellIndexPath.row == 1) {
        _textContentLB.text = model.contactPhone;
    }
    
    //级别
    if (cellIndexPath.section == 2 && cellIndexPath.row == 0) {
        _textContentLB.text = model.type;
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
