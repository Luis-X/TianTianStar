//
//  UserInfoEditViewController.m
//  TianTianStar
//
//  Created by LuisX on 16/6/7.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "UserInfoEditViewController.h"
#import "UserInfoTableViewCell.h"
#import "UserModel.h"

@interface UserInfoEditViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation UserInfoEditViewController{
    
    NSDictionary *_allTitleDic;
    UITableView *_infoTableView;
    NSMutableArray *_allUserInfoDetailArr;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [Constant changeNavigationBarTitleStyleWithTitle:@"详细资料"];
    [self initailData];
    [self createMainView];
    [self networkGetUserInfoDetailData];
}

- (void)initailData{
    
    _allTitleDic = @{
                      @"0" : @[@"头像", @"姓名", @"性别", @"班级", @"入学时间", @"手机号"],
                      @"1" : @[@"家庭住址", @"联系电话"],
                      @"2" : @[@"级别"]
                      };
    _allUserInfoDetailArr = [NSMutableArray array];
}


- (void)createMainView{
    
    _infoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _infoTableView.dataSource = self;
    _infoTableView.delegate = self;
    [self.view addSubview:_infoTableView];
    [_infoTableView registerClass:[UserInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.equalTo(self.view);
        
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
    
    return _allTitleDic.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *rowArr = [_allTitleDic objectForKey:[NSString stringWithFormat:@"%ld", indexPath.section]];
    cell.titleLB.text = [NSString stringWithFormat:@"%@", [rowArr objectAtIndex:indexPath.row]];
    if (_allUserInfoDetailArr.count > 0) {
        
        UserModel *model = (UserModel *)[_allUserInfoDetailArr firstObject];
        [cell updateUserInfoDetailDataWithCellIndexPath:indexPath Model:model];
        
    }
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *rowArr = [_allTitleDic objectForKey:[NSString stringWithFormat:@"%ld", section]];
    return rowArr.count;
    
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        return 90;
        
    }
    
    return 50;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 20;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //头像
    if (indexPath.section == 0 && indexPath.row == 0) {
      
    }
    
    //家庭住址
    if (indexPath.section == 1 && indexPath.row == 0) {
        
    }
    
    //联系电话
    if (indexPath.section == 1 && indexPath.row == 1) {
        
    }
    
}

/**
 *  网络获取用户详细信息
 */
- (void)networkGetUserInfoDetailData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_allUserInfoDetailArr removeAllObjects];
    
    //NSLog(@"objectId:   %@", _objectId);
    AVQuery *query = [AVQuery queryWithClassName:CLOUD_USER];
    [query getObjectInBackgroundWithId:_objectId block:^(AVObject *object, NSError *error) {
        
        UserModel *userModel = [UserModel new];
        userModel.type = [object objectForKey:@"type"];                               //账号类型
        userModel.avater = [object objectForKey:@"avater"];                           //头像
        userModel.username = [object objectForKey:@"username"];                       //姓名
        userModel.sex = [object objectForKey:@"sex"];                                 //性别
        userModel.classroom = [object objectForKey:@"classroom"];                     //班级
        userModel.admissionDate = [object objectForKey:@"admissionDate"];             //入学时间
        userModel.address = [object objectForKey:@"address"];                         //地址
        userModel.mobilePhoneNumber = [object objectForKey:@"mobilePhoneNumber"];     //手机号
        userModel.contactPhone = [object objectForKey:@"contactPhone"];               //联系电话
        
        
        [_allUserInfoDetailArr addObject:userModel];
        [_infoTableView reloadData];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];
    
}
@end
