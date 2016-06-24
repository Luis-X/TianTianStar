//
//  UserInfoViewController.m
//  TianTianStar
//
//  Created by LuisX on 16/6/7.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "UserInfoViewController.h"
#import "AvatarInfoView.h"


@interface UserInfoViewController ()<AvatarInfoViewDelegate>

@end

@implementation UserInfoViewController{
    AvatarInfoView *_avatarInfoView;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.title = HUAER_NAME;
        self.contentSizeInPopup = CGSizeMake(300, 380);
        //边框颜色
        [STPopupNavigationBar appearance].barTintColor = COLOR_BLUE_BACKGROUND;
        //按钮颜色
        [STPopupNavigationBar appearance].tintColor = COLOR_ALL_BACKGROUND;
        //标题属性
        [STPopupNavigationBar appearance].titleTextAttributes = @{ NSFontAttributeName: [UIFont fontWithName:FONT_LANTING_JIANHEI size:18], NSForegroundColorAttributeName: [UIColor whiteColor]};
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createMainViews];
    [self networkGetAvatarInfoData];
}

- (void)createMainViews{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _avatarInfoView = [AvatarInfoView new];
    //_avatarInfoView.backgroundColor = [UIColor redColor];
    _avatarInfoView.myDelegate = self;
    [self.view addSubview:_avatarInfoView];
    [_avatarInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
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


#pragma mark -AvatarInfoViewDelegate
//视图消失,选择了编辑按钮
- (void)chooseEditButtonEvent{
    
     __weak typeof(self) weakSelf = self;
    [self.popupController dismissWithCompletion:^{
        
        [weakSelf.myDelegate showUserEditViewController];
        
    }];
    
}

/**
 *  网络获取名片信息
 */
- (void)networkGetAvatarInfoData{
    
    AVUser *currentUser = [AVUser currentUser];
    [_avatarInfoView updateAvatarInfoViewDataWithName:currentUser.username];
    
}
@end
