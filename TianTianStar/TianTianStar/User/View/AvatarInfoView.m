//
//  AvatarInfoView.m
//  TianTianStar
//
//  Created by LuisX on 16/5/30.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "AvatarInfoView.h"

#import "GBFlatButton.h"                //圆角多彩按钮
#import "GBFlatSelectableButton.h"
#import "UIColor+GBFlatButton.h"
@implementation AvatarInfoView{
    
    GBFlatButton *_normalButton;
    UIImageView *_avatarIV;
    UILabel *_nameLB;
    UILabel *_leftTextLB;
    UILabel *_rightTextLB;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {

        [self createSubViews];
        
    }
    
    return self;
    
}

- (void)createSubViews{
    
    UIImageView *backgroundIV = [UIImageView new];
    backgroundIV.backgroundColor = [UIColor lightGrayColor];
    [backgroundIV setImage:[UIImage imageNamed:@"UserCenter_header_bk"]];
    backgroundIV.contentMode = 2;
    backgroundIV.clipsToBounds = YES;
    [self addSubview:backgroundIV];
    [backgroundIV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(140);
    
    }];
    
//头像边长
    CGFloat avatarBounds = 100;
    
    _avatarIV = [UIImageView new];
    _avatarIV.backgroundColor = [UIColor grayColor];
    _avatarIV.contentMode = 2;
    _avatarIV.layer.cornerRadius = avatarBounds / 2;
    _avatarIV.layer.masksToBounds = YES;
    _avatarIV.clipsToBounds = YES;
    [self addSubview:_avatarIV];
    [_avatarIV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(backgroundIV.mas_bottom).offset(-20);
        make.centerX.equalTo(self.mas_centerX);
        make.width.height.mas_equalTo(avatarBounds);
        
    }];
    
    _nameLB = [UILabel new];
    //_nameLB.backgroundColor = [UIColor redColor];
    _nameLB.textColor = COLOR_TEXT_BLACK28;
    _nameLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:20];
    [self addSubview:_nameLB];
    [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_avatarIV.mas_bottom).offset(10);
        make.centerX.equalTo(self.mas_centerX);
        
    }];
    
    /**
     *  黑线
     */
    UIView *blackLine = [UIView new];
    blackLine.backgroundColor = COLOR_LINE_GRAY;
    [self addSubview:blackLine];
    [blackLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(30);
        
    }];
    

    CGFloat button_width = 120;
    CGFloat button_height = 40;
    
    _normalButton = [[GBFlatButton alloc] initWithFrame:CGRectMake(0, 0, button_width, button_height)];
    _normalButton.tintColor = [UIColor gb_yellowColor];
    _normalButton.backgroundColor = [UIColor whiteColor];
    [_normalButton setTitle:@"确定" forState:UIControlStateNormal];
    [_normalButton setTitle:@"确定" forState:UIControlStateHighlighted];
    [self addSubview:_normalButton];
    [_normalButton addTarget:self action:@selector(avatarChoose_normalButtonThing:) forControlEvents:UIControlEventTouchUpInside];
    [_normalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(blackLine.mas_top).offset(-30);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(button_width);
        make.height.mas_equalTo(button_height);
        
    }];

    
     _leftTextLB = [UILabel new];
    //_leftTextLB.backgroundColor = [UIColor redColor];
    _leftTextLB.textAlignment = NSTextAlignmentCenter;
    _leftTextLB.numberOfLines = 2;
    [self addSubview:_leftTextLB];
    [_leftTextLB mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(blackLine).offset(-15);
        make.left.bottom.equalTo(self);
        make.right.equalTo(blackLine.mas_left);
        
    }];
    
    _rightTextLB = [UILabel new];
    //_rightTextLB.backgroundColor = [UIColor orangeColor];
    _rightTextLB.textAlignment = NSTextAlignmentCenter;
    _rightTextLB.numberOfLines = 2;
    [self addSubview:_rightTextLB];
    [_rightTextLB mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(blackLine).offset(-15);
        make.right.bottom.equalTo(self);
        make.left.equalTo(blackLine.mas_right);
        
    }];
    
}


- (void)setDifferentLineWithUILabel:(UILabel *)label FirstString:(NSString *)firstString SecondString:(NSString *)secondString{
    
    if (firstString != nil && secondString != nil) {
        
        //第一行样式
        NSMutableAttributedString *firstLineAttributedString = [[NSMutableAttributedString alloc] initWithString:firstString attributes:@{NSForegroundColorAttributeName : COLOR_TEXT_BLACK28, NSFontAttributeName : [UIFont systemFontOfSize:14]}];
        //第二行样式
        NSMutableAttributedString *secondLineAttributedString = [[NSMutableAttributedString alloc] initWithString:secondString attributes:@{NSForegroundColorAttributeName : COLOR_TEXT_GRAY, NSFontAttributeName : [UIFont systemFontOfSize:12]}];
        //拼接换行
        [firstLineAttributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        //拼接第二行
        [firstLineAttributedString appendAttributedString:secondLineAttributedString];
        
        label.attributedText = firstLineAttributedString;
    }
    
}


//编辑
- (void)avatarChoose_normalButtonThing:(GBFlatButton *)button{
    
    [self.myDelegate chooseEditButtonEvent];
    
}


/**
 *  更新名片数据
 */
- (void)updateAvatarInfoViewDataWithName:(NSString *)name{
    
    [_avatarIV setImage:[UIImage imageNamed:@"2.jpg"]];
    _nameLB.text = name;
    [self setDifferentLineWithUILabel:_leftTextLB FirstString:@"累计签到" SecondString:@"456天"];
    [self setDifferentLineWithUILabel:_rightTextLB FirstString:@"累计学费" SecondString:@"2月"];
}
@end
