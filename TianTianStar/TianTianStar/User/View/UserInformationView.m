//
//  UserInformationView.m
//  TianTianGarden
//
//  Created by Mr.Feng on 20/3/15.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "UserInformationView.h"

@implementation UserInformationView{
    
    UILabel *_userNameLB;
    UIButton *_rankButton;
    UIImageView *_userHeaderIV;
    
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.contentMode = 2;
        self.clipsToBounds = YES;
        [self createSubViews];
        
    }
    return self;
}

- (void)createSubViews{
    //头像
    _userHeaderIV = [UIImageView new];
    _userHeaderIV.backgroundColor = COLOR_ALL_BACKGROUND;
    _userHeaderIV.layer.cornerRadius = 80 / 2;
    _userHeaderIV.layer.masksToBounds = YES;
    _userHeaderIV.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.6].CGColor;
    _userHeaderIV.layer.borderWidth = 2;
    _userHeaderIV.contentMode = 2;
    _userHeaderIV.clipsToBounds = YES;
    _userHeaderIV.userInteractionEnabled = YES;
    [self addSubview:_userHeaderIV];
    [_userHeaderIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(10);
        make.width.and.height.mas_equalTo(80);
        make.left.equalTo(self).offset(10);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_userHeaderIVEvent)];
    [_userHeaderIV addGestureRecognizer:tap];
    
    
    //名称
    _userNameLB = [UILabel new];
    //_userNameLB.backgroundColor = [UIColor redColor];
    _userNameLB.textColor = [UIColor whiteColor];
    _userNameLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:20];
    [self addSubview:_userNameLB];
    [_userNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_userHeaderIV.mas_centerY).offset(-2);
        make.left.equalTo(_userHeaderIV.mas_right).offset(10);
    }];
    
    //等级
    _rankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rankButton.titleLabel.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:16];
    //_rankButton.backgroundColor = [UIColor redColor];
    [self addSubview:_rankButton];
    [_rankButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userHeaderIV.mas_centerY).offset(2);
        make.left.equalTo(_userNameLB);
    }];
    
    //右箭头
    UIImageView *rightArrow = [UIImageView new];
    //rightArrow.backgroundColor = [UIColor orangeColor];
    [rightArrow setImage:[UIImage imageNamed:@"userCenter_rightArrow.png"]];
    [self addSubview:rightArrow];
    [rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_userHeaderIV);
        make.right.equalTo(self).offset(-10);
        make.width.and.height.mas_equalTo(20);
    }];
    
    //账户管理
    UIButton *accountManageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //accountManageButton.backgroundColor = [UIColor redColor];
    [accountManageButton setTitle:@"账户管理" forState:UIControlStateNormal];
    accountManageButton.titleLabel.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:12];
    [self addSubview:accountManageButton];
    [accountManageButton addTarget:self action:@selector(accountManageButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [accountManageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rightArrow);
        make.right.equalTo(rightArrow.mas_left);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
 *  更新数据
 *
 *  @param username  用户名
 *  @param type 班级
 */
- (void)updateUserInfomationViewDataWithUsername:(NSString *)username Type:(NSString *)type{
    
    [_userHeaderIV setImage:[UIImage imageNamed:@"1.jpg"]];
    _userNameLB.text = username;
    [_rankButton setTitle:type forState:UIControlStateNormal];
    
}

/**
 *  账号管理
 *
 */
- (void)accountManageButtonEvent:(id)sender{
    
    [self.myDelegate todoSelectedAccountManagerEvent];
    
}

/**
 *  头像
 */
- (void)_userHeaderIVEvent{
    
    [self.myDelegate todoSelectedHeaderEvent];
    
}
@end
