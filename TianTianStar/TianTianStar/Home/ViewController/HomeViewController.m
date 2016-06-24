//
//  HomeViewController.m
//  TianTianStar
//
//  Created by LuisX on 16/5/21.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "BillsViewController.h"
#import "NSString+Icons.h"
#import "UserInfoViewController.h"
#import "UserInfoEditViewController.h"
#import "NoticeMessageViewController.h"
#import "SignViewController.h"
#import "AddressBookViewController.h"
#import "PayViewController.h"
#import "FBShimmeringView.h"
@interface HomeViewController ()<UserInfoViewControllerDelegate, LoginViewControllerDelegate>

@property (nonatomic, strong)LoginViewController *loginVC;

@end

@implementation HomeViewController{
    
    NSMutableArray *_allHomeDataArr;
    UIView *_noticeView;
    UIImageView *_studentAvatorIV;
    UILabel *_studentNameLB;
    UILabel *_userTypeLB;
    UILabel *_noticeMessageLB;
    STPopupController *_mySTPopupVC;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self checkUserLoginStatusAndShowLoginViewController];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [Constant changeNavigationBarTitleStyleWithTitle:HUAER_NAME];
    
    [self initailData];
    [self createMainView];
    [self loadCreateNoticeView];
    
}

- (void)initailData{
    
    _allHomeDataArr = [NSMutableArray array];
    
}

- (void)createMainView{
    //背景图片
    UIImageView *homeBackgroundIV = [UIImageView new];
    //homeBackgroundIV.backgroundColor = [UIColor blueColor];
    homeBackgroundIV.contentMode = 2;
    homeBackgroundIV.clipsToBounds = YES;
    [homeBackgroundIV setImage:[UIImage imageNamed:@"home_bg@2x.png"]];
    [self.view addSubview:homeBackgroundIV];
    [homeBackgroundIV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.bottom.right.equalTo(self.view);
        
    }];
    
    
    //账单
    UIButton *billsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //billsBtn.backgroundColor = [UIColor redColor];
    [billsBtn setImage:[UIImage imageNamed:@"home_checkBill"] forState:UIControlStateNormal];
    [self.view addSubview:billsBtn];
    [billsBtn addTarget:self action:@selector(showBillsViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    [billsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(80);
        make.right.equalTo(self.view).offset(-20);
        make.width.height.mas_equalTo(44);
        
    }];
    
    UILabel *billsWord = [UILabel new];
    //billsWord.backgroundColor = [UIColor orangeColor];
    billsWord.text = @"交费记录";
    billsWord.textColor = [UIColor whiteColor];
    billsWord.font = [UIFont boldFlatFontOfSize:12];
    [self.view addSubview:billsWord];
    [billsWord mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(billsBtn.mas_bottom);
        make.centerX.equalTo(billsBtn);
        
    }];
    
    //头像
    _studentAvatorIV = [UIImageView new];
    _studentAvatorIV.backgroundColor = [UIColor whiteColor];
    _studentAvatorIV.layer.masksToBounds = YES;
    _studentAvatorIV.layer.cornerRadius = 5;
    _studentAvatorIV.contentMode = 2;
    _studentAvatorIV.clipsToBounds = YES;
     _studentAvatorIV.userInteractionEnabled = YES;
    [self.view addSubview:_studentAvatorIV];
    [_studentAvatorIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(billsBtn);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.height.mas_equalTo(80);
        
    }];
    
    //姓名
    FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] initWithFrame:CGRectZero];
    //shimmeringView.backgroundColor = [UIColor redColor];
    shimmeringView.shimmeringOpacity = 1;
    [self.view addSubview:shimmeringView];
    [shimmeringView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_studentAvatorIV.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
        
    }];
    _studentNameLB = [[UILabel alloc] initWithFrame:shimmeringView.bounds];
    _studentNameLB.textAlignment = NSTextAlignmentCenter;
    _studentNameLB.font = [UIFont systemFontOfSize:35 weight:0.5];
    _studentNameLB.textColor = [UIColor whiteColor];
    shimmeringView.contentView = _studentNameLB;
    shimmeringView.shimmering = YES;
    
    
    //级别
    _userTypeLB = [UILabel new];
    //_userTypeLB.backgroundColor = [UIColor orangeColor];
    _userTypeLB.font = [UIFont systemFontOfSize:16];
    _userTypeLB.textColor = [UIColor whiteColor];
    [self.view addSubview:_userTypeLB];
    [_userTypeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(shimmeringView.mas_bottom).offset(5);
        make.centerX.equalTo(self.view.mas_centerX);
        
    }];

#pragma mark -轻拍手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showUserInfoViewController)];
    [_studentAvatorIV addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showUserInfoViewController)];
    [_studentNameLB addGestureRecognizer:tap2];
    
    
    //公告
    _noticeView = [UIView new];
    //_noticeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_noticeView];
    [_noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view);
        make.top.equalTo(_userTypeLB.mas_bottom).offset(25);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(100);
        
    }];
    
    
    CGFloat button_bounds_width = FX_SCREEN_WIDTH - 120;
    CGFloat button_bounds_height = 50.0f;
    CGFloat button_bottom = -50;
    
    //签到
    FUIButton *signInBtn = [FUIButton buttonWithType:UIButtonTypeCustom];
    //signInBtn.backgroundColor = COLOR_RED_BACKGROUND;
    signInBtn.buttonColor = [UIColor alizarinColor];
    signInBtn.shadowColor = [UIColor pomegranateColor];
    signInBtn.shadowHeight = 3.0f;
    signInBtn.cornerRadius = 3.0f;
    signInBtn.titleLabel.font = [UIFont iconFontWithSize:16];
    [signInBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [signInBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [self.view addSubview:signInBtn];
    [signInBtn addTarget:self action:@selector(showSignViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    [signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view).offset(button_bottom);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(button_bounds_width);
        make.height.mas_equalTo(button_bounds_height);
        
    }];
    
    //交费
    FUIButton *payBtn = [FUIButton buttonWithType:UIButtonTypeCustom];
    //payBtn.backgroundColor = COLOR_GREEN_BACKGROUND;
    payBtn.buttonColor = COLOR_GREEN_BACKGROUND;
    payBtn.shadowColor = [UIColor greenSeaColor];
    payBtn.shadowHeight = 3.0f;
    payBtn.cornerRadius = 3.0f;
    payBtn.titleLabel.font = [UIFont iconFontWithSize:16];
    [payBtn setTitle:[NSString stringWithFormat:@"%@交费", [NSString iconStringForEnum:FUIPaypal]] forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [self.view addSubview:payBtn];
    [payBtn addTarget:self action:@selector(showPayViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(signInBtn.mas_top).offset(-20);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(button_bounds_width);
        make.height.mas_equalTo(button_bounds_height);
        
    }];


#pragma mark- 根据权限划分签到
    
    NSString *type = [Constant checkCurrentUserType];
    if ([type isEqualToString:TYPE_STUDENT]) {//学生(查看签到)
        
        [signInBtn setTitle:[NSString stringWithFormat:@"%@签到记录", [NSString iconStringForEnum:FUILocation]] forState:UIControlStateNormal];

    }
    
    if ([type isEqualToString:TYPE_TEACHER]) {//教师
        
        [signInBtn setTitle:[NSString stringWithFormat:@"%@签到", [NSString iconStringForEnum:FUILocation]] forState:UIControlStateNormal];
        
    }
    if ([type isEqualToString:TYPE_MASTER]) {//园长
        
        [signInBtn setTitle:[NSString stringWithFormat:@"%@签到", [NSString iconStringForEnum:FUILocation]] forState:UIControlStateNormal];
        
    }

}

/**
 *  通知视图
 */
- (void)loadCreateNoticeView{
    
    UIImageView *noticeIV = [UIImageView new];
    //noticeIV.backgroundColor = [UIColor blueColor];
    [noticeIV setImage:[UIImage imageNamed:@"home_notice"]];
    noticeIV.contentMode = 1;
    noticeIV.clipsToBounds = YES;
    noticeIV.userInteractionEnabled = YES;
    [_noticeView addSubview:noticeIV];
    [noticeIV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.bottom.right.equalTo(_noticeView);
    
    }];
    
    
    _noticeMessageLB = [UILabel new];
    //_noticeMessageLB.backgroundColor = [UIColor redColor];
    _noticeMessageLB.numberOfLines = 4;
    _noticeMessageLB.textColor = COLOR_TEXT_BLACK28;
    _noticeMessageLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:12];
    [noticeIV addSubview:_noticeMessageLB];
    [_noticeMessageLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(noticeIV).offset(20);
        make.left.equalTo(noticeIV).offset(90);
        make.right.equalTo(noticeIV).offset(-30);
        make.bottom.equalTo(noticeIV).offset(-20);
        
    }];
    
    
    UITapGestureRecognizer *noticeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showNoticeMessageViewController)];
    [noticeIV addGestureRecognizer:noticeTap];
}

/**
 *  弹出视图
 */
- (void)loadingSTPopuVCStyle{
    
    //样式(中心,底部)
    _mySTPopupVC.style = STPopupStyleFormSheet;
    //动画效果
    _mySTPopupVC.transitionStyle = STPopupTransitionStyleSlideVertical;
    //透明
    _mySTPopupVC.containerView.backgroundColor = [UIColor clearColor];
    _mySTPopupVC.containerView.layer.cornerRadius = 5;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/**
 *  修改学生信息
 */
- (void)showUserInfoViewController{
    
    NSLog(@"学生信息");
    UserInfoViewController *userInfoVC = [UserInfoViewController new];
    userInfoVC.myDelegate = self;
    _mySTPopupVC = [[STPopupController alloc] initWithRootViewController:userInfoVC];
    [self loadingSTPopuVCStyle];
    [_mySTPopupVC presentInViewController:self];

}

/**
 *  账单按钮
 *
 */
- (void)showBillsViewController:(UIButton *)button{
    
    NSLog(@"账单");
    BillsViewController *billsVC = [BillsViewController new];
    billsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:billsVC animated:YES];
    
}

/**
 *  交费
 *
 */
- (void)showPayViewController:(FUIButton *)fButton{
    
    NSLog(@"交费");
    PayViewController *payVC = [PayViewController new];
    payVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:payVC animated:YES];
    
}

/**
 *  签到
 *
 */
- (void)showSignViewController:(FUIButton *)fButton{
    
    //NSLog(@"签到");

    NSString *type = [Constant checkCurrentUserType];
    
    if ([type isEqualToString:TYPE_STUDENT]) {//学生(查看签到)
        
        SignViewController *signVC = [SignViewController new];
        signVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:signVC animated:YES];
        [signVC networkGetSignHistoryWithUserName:[AVUser currentUser].username];
        
    }
    
    if ([type isEqualToString:TYPE_TEACHER]) {//教师
        
        AddressBookViewController *addressBookVC = [AddressBookViewController new];
        addressBookVC.hidesBottomBarWhenPushed = YES;
        addressBookVC.myStyle = AddressBookStyleSign;
        [self.navigationController pushViewController:addressBookVC animated:YES];
        
    }
    if ([type isEqualToString:TYPE_MASTER]) {//园长
        
        AddressBookViewController *addressBookVC = [AddressBookViewController new];
        addressBookVC.myStyle = AddressBookStyleSign;
        addressBookVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addressBookVC animated:YES];
        
    }
        
}

/**
 *  公告信息
 *
 */
- (void)showNoticeMessageViewController{
    
    NSLog(@"公告");
    NoticeMessageViewController *noticeMessageVC = [NoticeMessageViewController new];
    noticeMessageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:noticeMessageVC animated:YES];
    
}
#pragma mark -UserInfoViewControllerDelegate
- (void)showUserEditViewController{
    
    AVUser *currentUser = [AVUser currentUser];
    UserInfoEditViewController *userInfoEditVC = [UserInfoEditViewController new];
    userInfoEditVC.objectId = currentUser.objectId;
    userInfoEditVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userInfoEditVC animated:YES];
    
}

#pragma mark -网络获取最新公告
- (void)networkGetNewNoticeMessage{
     
     AVQuery *query = [AVQuery queryWithClassName:CLOUD_NOTICE_MESSAGE];
     [query whereKeyExists:@"noticeMessage"];                     //非空公告
     [query orderByDescending:@"updatedAt"];                      //时间降序
      query.limit = 10;                                           //限制返回10条
     [query getFirstObjectInBackgroundWithBlock:^(AVObject *object, NSError *error) {
        
        //NSLog(@"最新公告: %@", object);
        _noticeMessageLB.text = [NSString stringWithFormat:@"%@", [object objectForKey:@"noticeMessage"]];
         
    }];
}



#pragma mark -登录用户信息
/**
 *  检查登录状态,未登录显示登录界面
 */
- (void)checkUserLoginStatusAndShowLoginViewController{
    
    BOOL loginStatus = [Constant checkUserLoginStatus];
    
    //未登录
    if (NO == loginStatus) {
        
        if (!_loginVC) {    //防止重复创建视图
            self.loginVC = [LoginViewController new];
            self.loginVC.myDelegate = self;
        }
        _loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:_loginVC animated:NO];
        
    }
    
    //登录中
    if (loginStatus) {
        
        AVUser *currentUser = [AVUser currentUser];
        [_studentAvatorIV setImage:[UIImage imageNamed:@"2.jpg"]];
        _studentNameLB.text = currentUser.username;
        _userTypeLB.text = [currentUser objectForKey:@"type"];
        [self networkGetNewNoticeMessage];                      //更新公告
        
    }
}

#pragma mark -LoginViewControllerDelegate
//登录成功
- (void)userLoginSystemSuccess{
    
    [self checkUserLoginStatusAndShowLoginViewController];
    
}


@end
