//
//  UserCenterViewController.m
//  TianTianStar
//
//  Created by LuisX on 16/6/8.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "UserCenterViewController.h"
#import "MineTableViewCell.h"
#import "UserInformationView.h"
#import "UserInfoEditViewController.h"
#import "SendNoticeViewController.h"


@interface UserCenterViewController ()<UITableViewDataSource, UITableViewDelegate, UserInformationViewDelegate>

@end

@implementation UserCenterViewController{
    
    NSArray *_allUserCenterTitleArr;
    UserInformationView *_userHeaderView;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_ALL_BACKGROUND;
    self.navigationItem.titleView = [Constant changeNavigationBarTitleStyleWithTitle:@"我的"];
    [self initailData];
    [self createMainView];
    [self neworkGetUserInfoData];

}

- (void)initailData{
    
    /**
     *  数组后3个固定不能动
     */
    _allUserCenterTitleArr = @[
                               @"发布公告",
                               @"签到统计",
                               @"交费统计",
                               @"意见反馈",
                               [NSString stringWithFormat:@"客服电话: %@", HUAER_PHONE],
                               @"退出当前账号"
                               ];
    
}


- (void)createMainView{
    
    _userHeaderView = [[UserInformationView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
    //_userHeaderView.backgroundColor = COLOR_BLUELIGHT_BACKGROUND;
    [_userHeaderView setImage:[UIImage imageNamed:@"UserCenter_header_bk"]];
    _userHeaderView.myDelegate = self;
    [self.view addSubview:_userHeaderView];
    
    UITableView *infoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    infoTableView.backgroundColor = [UIColor clearColor];
    infoTableView.dataSource = self;
    infoTableView.delegate = self;
    infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:infoTableView];
    [infoTableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"cell"];
    [infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_userHeaderView.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
        
    }];
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

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _allUserCenterTitleArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentLB.text = [NSString stringWithFormat:@"%@", [_allUserCenterTitleArr objectAtIndex:indexPath.section]];
    
    if (indexPath.section == (_allUserCenterTitleArr.count - 2)) {
        cell.mineStyle = MineCellStylePhone;
    }
    
    if (indexPath.section == (_allUserCenterTitleArr.count - 1)) {
        cell.mineStyle = MineCellStylelogout;
    }
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 20;
    }
    
    if (section == (_allUserCenterTitleArr.count - 1)) {
        
        return 50;
        
    }
    
    return 0.1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == (_allUserCenterTitleArr.count - 3) || section == (_allUserCenterTitleArr.count - 4)) {
        
        return 20;
        
    }
    
    return 1;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //发公告
    if (indexPath.section == 0 && indexPath.row == 0) {
    
        SendNoticeViewController *sendNoticeVC = [SendNoticeViewController new];
        sendNoticeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:sendNoticeVC animated:YES];
        
    }
    
    //打电话
    if (indexPath.section == (_allUserCenterTitleArr.count - 2) && indexPath.row == 0) {
        
        //NSLog(@"调用本地,拨打电话");
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",HUAER_PHONE];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
        
    }
    
    //退出登录
    if (indexPath.section == (_allUserCenterTitleArr.count - 1) && indexPath.row == 0) {
        
        [AVUser logOut];  //(登出)清除缓存用户对象
        [self.tabBarController setSelectedIndex:0];
        
    }
}

/**
 *  打开用户详细信息
 */
- (void)showEditUserInfomationViewController{
    
    AVUser *currentUser = [AVUser currentUser];
    UserInfoEditViewController *userInfoEditVC = [UserInfoEditViewController new];
    userInfoEditVC.objectId = currentUser.objectId;
    userInfoEditVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userInfoEditVC animated:YES];
    
}

#pragma mark -UserInformationViewDelegate
//账户管理
- (void)todoSelectedAccountManagerEvent{
    
    [self showEditUserInfomationViewController];
}
//头像
- (void)todoSelectedHeaderEvent{
    
    [self showEditUserInfomationViewController];
    
}

/**
 *  网络获取用户数据
 */

- (void)neworkGetUserInfoData{
    
    AVUser *currentUser = [AVUser currentUser];
    NSString *type = [currentUser objectForKey:@"type"];
    [_userHeaderView updateUserInfomationViewDataWithUsername:currentUser.username Type:type];
    
}
@end
