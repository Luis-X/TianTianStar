//
//  AddressBookViewController.m
//  TianTianStar
//
//  Created by LuisX on 16/6/12.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "AddressBookViewController.h"
#import "AddressBookTableViewCell.h"
#import "ContactModel.h"
#import "UserInfoEditViewController.h"
#import "ClassroomMenuViewController.h"
#import "NSString+Icons.h"
#import "SignViewController.h"

@interface AddressBookViewController ()<UITableViewDataSource, UITableViewDelegate, WYPopoverControllerDelegate, ClassroomMenuViewControllerDelegate>

@end

@implementation AddressBookViewController{
    
    NSMutableArray *_allAddressBookDataArr;
    NSMutableArray *_allTitleArr;
    UITableView *_addressBookTV;
    WYPopoverController *_menuPopoverController;
    FUIButton *_menuButton;
    BOOL _firstLoading;
    FUIButton *_signButton;
    FUIButton *_selectedAllBtn;
    NSMutableArray *_allIndexPathArr;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
     self.navigationItem.hidesBackButton = YES;
    
    if (!_firstLoading) {
        
        //NSLog(@"进入页面加载一次");
        [self networkGetUserOfupdateMenuButtonChooseClassroom];
        _firstLoading = YES;
        
    }
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initailData];
    [self createMainView];
    
}

- (void)initailData{
    
    _allAddressBookDataArr = [NSMutableArray array];
    _allTitleArr = [NSMutableArray array];
    _allIndexPathArr= [NSMutableArray array];
    
}

- (void)createMainView{
    
    _addressBookTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _addressBookTV.backgroundColor = COLOR_ALL_BACKGROUND;
    _addressBookTV.sectionIndexBackgroundColor = [UIColor clearColor];      //索引背景颜色
    _addressBookTV.sectionIndexColor = COLOR_TEXT_GRAY;                     //索引颜色
    _addressBookTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _addressBookTV.allowsMultipleSelectionDuringEditing = YES;              //允许多选
    _addressBookTV.dataSource = self;
    _addressBookTV.delegate = self;
    [self.view addSubview:_addressBookTV];
    [_addressBookTV registerClass:[AddressBookTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_addressBookTV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.bottom.right.equalTo(self.view);
        
    }];
    
    [self loadingTopSelectMenu];
 
    
    
    CGFloat button_bounds = 60.0f;
    
    //签到
     _signButton = [FUIButton buttonWithType:UIButtonTypeCustom];
    //_signButton.backgroundColor = [UIColor redColor];
    _signButton.hidden = YES;
    _signButton.buttonColor = [UIColor alizarinColor];
    _signButton.shadowColor = [UIColor pomegranateColor];
    _signButton.shadowHeight = 5.0f;
    _signButton.cornerRadius = button_bounds / 2;
    _signButton.titleLabel.font = [UIFont iconFontWithSize:12];
    [_signButton setTitle:[NSString stringWithFormat:@"%@签到", [NSString iconStringForEnum:FUILocation]] forState:UIControlStateNormal];
    [_signButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [_signButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateSelected];
    [_signButton addTarget:self action:@selector(chooseSignStudent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_signButton];
    [_signButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(60);
        make.bottom.right.equalTo(self.view).offset(-20);
        
    }];

    
    //全选
    _selectedAllBtn = [FUIButton buttonWithType:UIButtonTypeCustom];
    //_selectedAllBtn.backgroundColor = [UIColor redColor];
    _selectedAllBtn.hidden = YES;
    _selectedAllBtn.buttonColor = [UIColor tangerineColor];
    _selectedAllBtn.shadowColor = [UIColor carrotColor];
    _selectedAllBtn.shadowHeight = 5.0f;
    _selectedAllBtn.cornerRadius = button_bounds / 2;
    _selectedAllBtn.titleLabel.font = [UIFont iconFontWithSize:12];
    [_selectedAllBtn setTitle:[NSString stringWithFormat:@"%@全选", [NSString iconStringForEnum:FUICheck]] forState:UIControlStateNormal];
    [_selectedAllBtn setTitle:[NSString stringWithFormat:@"%@重选", [NSString iconStringForEnum:FUICheck]] forState:UIControlStateSelected];
    [_selectedAllBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [_selectedAllBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateSelected];
    [_selectedAllBtn addTarget:self action:@selector(chooseAllStudent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_selectedAllBtn];
    [_selectedAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(60);
        make.centerY.equalTo(_signButton);
        make.right.equalTo(_signButton.mas_left).offset(-20);
        
    }];

}

/**
 *  下拉菜单定制
 */
- (void)loadingTopSelectMenu{
    
    UIView *navigationBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    //navigationBackgroundView.backgroundColor = [UIColor orangeColor];
    self.navigationItem.titleView = navigationBackgroundView;
    
    //返回按钮
    UIButton *gobackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //gobackBtn.backgroundColor = [UIColor redColor];
    [gobackBtn setImage:[UIImage imageNamed:@"header_back_icon"] forState:UIControlStateNormal];
    [gobackBtn setImage:[UIImage imageNamed:@"header_back_icon"] forState:UIControlStateSelected];
    [gobackBtn addTarget:self action:@selector(goLastViewController) forControlEvents:UIControlEventTouchUpInside];
    [navigationBackgroundView addSubview:gobackBtn];
    [gobackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(35);
        make.left.equalTo(navigationBackgroundView).offset(5);
        make.centerY.equalTo(navigationBackgroundView);
        
    }];
    
    //编辑
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //editButton.backgroundColor = [UIColor redColor];
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [editButton setTitle:@"完成" forState:UIControlStateSelected];
    [editButton setTitleColor:COLOR_TEXT_GRAY forState:UIControlStateNormal];
    [editButton setTitleColor:COLOR_RED_BACKGROUND forState:UIControlStateSelected];
    editButton.titleLabel.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:14];
    [editButton addTarget:self action:@selector(editSelectedEventWithButton:) forControlEvents:UIControlEventTouchUpInside];
    [navigationBackgroundView addSubview:editButton];
    [editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(50);
        make.right.equalTo(navigationBackgroundView);
        make.centerY.equalTo(navigationBackgroundView);
        
    }];
    
//显示样式
    if (_myStyle == AddressBookStyleNormal) {
        
        gobackBtn.hidden = YES;
        editButton.hidden = YES;
        
    }

    
    //下拉菜单
    _menuButton = [FUIButton buttonWithType:UIButtonTypeCustom];
    _menuButton.buttonColor = COLOR_RED_BACKGROUND;
    _menuButton.shadowColor = [UIColor pomegranateColor];
    _menuButton.shadowHeight = 2.0f;
    _menuButton.cornerRadius = 3.0f;
    [_menuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _menuButton.titleLabel.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:14];
    _menuButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [navigationBackgroundView addSubview:_menuButton];
    [_menuButton addTarget:self action:@selector(showMenuPopViewController:) forControlEvents:UIControlEventTouchUpInside];
    [_menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(navigationBackgroundView).offset(5);
        make.bottom.equalTo(navigationBackgroundView).offset(-5);
        make.center.equalTo(navigationBackgroundView);
        make.width.mas_equalTo(120);
        
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

/**
 *  编辑/完成
 *
 */
- (void)editSelectedEventWithButton:(UIButton *)button{
    
    //调用编辑
    [_addressBookTV setEditing:!_addressBookTV.editing animated:YES];
    button.selected = !button.selected;
    if (_addressBookTV.editing) {
        
        //NSLog(@"编辑");
        _signButton.hidden = NO;
        _selectedAllBtn.hidden = NO;
        
    }else{
        
        //NSLog(@"完成");
        _signButton.hidden = YES;
        _selectedAllBtn.hidden = YES;
        
    }

    
}

/**
 *  全选
 *
 */
- (void)chooseAllStudent:(UIButton *)button{
    
    
    button.selected = !button.selected;
    if (button.selected) {
        
        //NSLog(@"全选");
        [_allIndexPathArr removeAllObjects];
        [_allAddressBookDataArr enumerateObjectsUsingBlock:^(NSArray *sectionArr, NSUInteger sectionId, BOOL * _Nonnull stop) {
            
            [sectionArr enumerateObjectsUsingBlock:^(AVObject *model, NSUInteger rowId, BOOL * _Nonnull stop) {
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowId inSection:sectionId];
                [_allIndexPathArr addObject:indexPath];
                
            }];
            
        }];
        
        for (NSIndexPath *indexPath in _allIndexPathArr) {
            
            [_addressBookTV selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            
        }
        
    }else{
        
        //NSLog(@"取消全选");
        [_addressBookTV selectRowAtIndexPath:nil animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }
    
}

/**
 *  签到
 *
 */
- (void)chooseSignStudent:(UIButton *)button{
    
    //NSLog(@"签到");
    NSArray *chooseArr = [_addressBookTV indexPathsForSelectedRows];
    if (chooseArr.count > 0) {
        
        for (NSIndexPath *indexPath in chooseArr) {
            
            NSArray *sectionArr = [_allAddressBookDataArr objectAtIndex:indexPath.section];
            AVObject *userObject = (AVObject *)[sectionArr objectAtIndex:indexPath.row];
            [self networkSignDateWithUserObject:userObject];
            
        }
        
    }else{
        
        [Constant showHUDProgressTitleWithMessage:@"请选择签到学生!" AddView:self.view];
    }
    
}

#pragma mark -网络签到
- (void)networkSignDateWithUserObject:(AVObject *)userObject{
    
    //NSLog(@"网络签到%@", userObject);
    NSString *username = [userObject objectForKey:@"username"];
    NSDate *signDate = [NSDate date];
    
    //1.查询今日是否签到
    AVQuery *query = [AVQuery queryWithClassName:CLOUD_SIGN_HISTORY];
    [query whereKey:@"username" equalTo:username];           //查询该用户名
    [query orderByDescending:@"signDate"];                    //时间降序
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        AVObject *signHistoryObject = [objects firstObject];
        NSDate *signHistoryDate = [signHistoryObject objectForKey:@"signDate"];
        if (signDate.year == signHistoryDate.year && signDate.month == signHistoryDate.month && signDate.day == signHistoryDate.day) {
            //2.今日已经签到
            NSLog(@"过滤今日已签到学生:%@", username);
            
        }else{
            //3.今日未签到
            //4.添加签到
            AVObject *signObject = [[AVObject alloc] initWithClassName:CLOUD_SIGN_HISTORY];
            [signObject setObject:username forKey:@"username"];                                 //姓名(被签到人)
            [signObject setObject:signDate forKey:@"signDate"];                                 //签到日期
            AVUser *currentUser = [AVUser currentUser];
            [signObject setObject:currentUser.username forKey:@"signTeacher"];                  //签到人
            
            [signObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (succeeded) {
                    
                    [Constant showSIAlertViewWithTitle:HUAER_NAME Message:@"签到成功!" OKHandler:^(SIAlertView *alertView) {
                        
                        
                    }];
                    
                }else{
                    
                    [Constant showHUDProgressTitleWithMessage:@"签到失败!" AddView:self.view];
                    
                }
                
            }];
            
        }
        
    }];
    
    

    
}

/**
 *  返回上级视图
 */
- (void)goLastViewController{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

/**
 *  展开气泡菜单
 *
 */
- (void)showMenuPopViewController:(UIButton *)button{
    
    //NSLog(@"展开气泡");
    ClassroomMenuViewController *menuVC = [ClassroomMenuViewController new];
    menuVC.myDelegate = self;
    
    _menuPopoverController = [[WYPopoverController alloc] initWithContentViewController:menuVC];
    _menuPopoverController.delegate = self;
    _menuPopoverController.popoverContentSize = CGSizeMake(FX_SCREEN_WIDTH / 2, FX_SCREEN_HEIGHT / 2);               //弹出视图大小
#pragma 气泡主题
    _menuPopoverController.theme.borderWidth = 5;                  //边宽
    _menuPopoverController.theme.outerCornerRadius = 5;             //外部圆角
    _menuPopoverController.theme.innerCornerRadius = 5;             //内部圆角
    _menuPopoverController.theme.fillTopColor = COLOR_BLUE_BACKGROUND;         //顶部颜色(渐变)
    _menuPopoverController.theme.fillBottomColor = COLOR_RED_BACKGROUND;        //底部颜色(渐变)
    
    [_menuPopoverController presentPopoverFromRect:button.bounds inView:button permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES options:WYPopoverAnimationOptionFadeWithScale completion:nil];

}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _allTitleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddressBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *sectionArr = [_allAddressBookDataArr objectAtIndex:indexPath.section];
    cell.model = (AVObject *)[sectionArr objectAtIndex:indexPath.row];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *sectionArr = [_allAddressBookDataArr objectAtIndex:section];
    return sectionArr.count;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return (NSString *)[_allTitleArr objectAtIndex:section];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return _allTitleArr;
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!tableView.editing) {
        
        NSArray *sectionArr = [_allAddressBookDataArr objectAtIndex:indexPath.section];
        AVObject *model = (AVObject *)[sectionArr objectAtIndex:indexPath.row];
        
        if (_myStyle == AddressBookStyleNormal) {//正常样式
            
            UserInfoEditViewController *userInfoEditVC = [UserInfoEditViewController new];
            userInfoEditVC.objectId = model.objectId;
            userInfoEditVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:userInfoEditVC animated:YES];
            
        }
        
        if (_myStyle == AddressBookStyleSign) {//签到样式
            
            SignViewController *signVC = [SignViewController new];
            signVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:signVC animated:YES];
            [signVC networkGetSignHistoryWithUserName:[model objectForKey:@"username"]];
            
        }
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
    
}


#pragma mark -WYPopoverControllerDelegate

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller{
    
    return YES;
    
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller{
    
    _menuPopoverController.delegate = nil;
    _menuPopoverController = nil;
    
}

#pragma mark -ClassroomMenuViewControllerDelegate
/**
 *  选择班级完成(更新菜单按钮标题)
 */
- (void)completeChooseClassroom{
    
    __weak typeof(self) weakSelf = self;
    [_menuPopoverController dismissPopoverAnimated:YES completion:^{
        
        [weakSelf networkGetUserOfupdateMenuButtonChooseClassroom];
        
    }];
    
}

/**
 *  更新按钮标题
 */
- (void)networkGetUserOfupdateMenuButtonChooseClassroom{
    
    if ([Constant defaultsGetMyChooseClassroom]) {//有保存选中班级
        
        NSString *chooseClassroom = [Constant defaultsGetMyChooseClassroom];
        [_menuButton setTitle:[NSString stringWithFormat:@"%@", chooseClassroom] forState:UIControlStateNormal];
        [self networkGetAllUserInfoDataWithClassroom:chooseClassroom];
        
    }else{//默认班级
        
        [_menuButton setTitle:@"请选择班级" forState:UIControlStateNormal];
        
    }
    
}
/**
 *  网络获取某班所有用户
 */

- (void)networkGetAllUserInfoDataWithClassroom:(NSString *)classroom{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AVQuery *query = [AVQuery queryWithClassName:CLOUD_USER];
    [query whereKey:@"classroom" equalTo:classroom];         //查询该班级用户名
    [query orderByAscending:@"username"];                    //名字升序
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        [self dealAddressBookDataWithAVObjectArr:objects];
        
    }];
    
}

#pragma mark -重要(处理按姓名首字母排序)
- (void)dealAddressBookDataWithAVObjectArr:(NSArray*)avObjectArr{
    
    [_allAddressBookDataArr removeAllObjects];
    [_allTitleArr removeAllObjects];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //1.去重首字母数组
        for (AVObject *model in avObjectArr) {
            
            NSString *username = [model objectForKey:@"username"];
            NSString *pinyinFirst = [Constant transformToBigPinYinFirst:username];
            if (![_allTitleArr containsObject:pinyinFirst]) {
                
                [_allTitleArr addObject:pinyinFirst];
                
            }

        }
        
        //2.根据首字母分区存储数据
        for (NSString *sectionPinyinFirst in _allTitleArr) {
            
            NSMutableArray *sectionArr = [NSMutableArray array];
            for (AVObject *model in avObjectArr) {
                
                //3.判断云姓名大写拼音首字母是否和分区首字母一致
                NSString *username = [model objectForKey:@"username"];
                NSString *pinyinFirst = [Constant transformToBigPinYinFirst:username];
                if ([pinyinFirst isEqualToString:sectionPinyinFirst]) {
                    
                    [sectionArr addObject:model];
                    
                }
                
            }
            
            [_allAddressBookDataArr addObject:sectionArr];
            
        }
        
        //4.两个数组存储数据要对应即(首字母对应分区)
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [_addressBookTV reloadData];

        });
        
    });
    
    
}
@end
