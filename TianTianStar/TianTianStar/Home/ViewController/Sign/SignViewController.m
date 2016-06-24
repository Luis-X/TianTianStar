//
//  SignViewController.m
//  TianTianStar
//
//  Created by LuisX on 16/6/7.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "SignViewController.h"

@interface SignViewController ()<FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance>

@end

@implementation SignViewController{
    
    FSCalendar *_signCalendar;
    NSMutableArray *_allSignDateArr;
    UILabel *_contentLB;
    
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Constant changeNavigationBarTitleStyleWithTitle:@"签到记录"];
    [self inintailData];
    [self loadSignCalendar];
    [self createMainView];

}

- (void)inintailData{
    
    _allSignDateArr = [NSMutableArray array];
    
}

- (void)createMainView{
    
    UIImageView *downImageView = [UIImageView new];
    downImageView.backgroundColor = [UIColor redColor];
    downImageView.contentMode = 2;
    downImageView.clipsToBounds = YES;
    [downImageView setImage:[UIImage imageNamed:@"sign_bk@2x.jpg"]];
    [self.view addSubview:downImageView];
    [downImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_signCalendar.mas_bottom).offset(10);
        make.left.right.bottom.equalTo(self.view);
        
    }];
    
    
    _contentLB = [UILabel new];
    _contentLB.textColor = COLOR_TEXT_BLACK28;
    _contentLB.textAlignment = NSTextAlignmentCenter;
    _contentLB.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:25];
    _contentLB.numberOfLines = 2;
    [downImageView addSubview:_contentLB];
    [_contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(downImageView);
        
    }];

}

- (void)loadSignCalendar{
    
    //日历
    _signCalendar = [[FSCalendar alloc] initWithFrame:CGRectZero];
    _signCalendar.firstWeekday = 2;                                         //从周几显示
    _signCalendar.headerHeight = 60;                                        //显示年月高度
    _signCalendar.allowsSelection = YES;                                    //允许选择日期
    _signCalendar.allowsMultipleSelection = NO;                             //允许选择多个日期
    _signCalendar.scrollDirection = FSCalendarScrollDirectionHorizontal;    //滑动方向
    
    
#pragma 标题样式
    _signCalendar.appearance.headerTitleColor = COLOR_RED_BACKGROUND;      //头部标题颜色
    _signCalendar.appearance.weekdayTextColor = COLOR_TEXT_GRAY;           //星期颜色
    _signCalendar.appearance.eventColor = COLOR_RED_BACKGROUND;            //事件点颜色
    
#pragma 日期文本
    _signCalendar.appearance.titleDefaultColor = COLOR_TEXT_BLACK28;            //默认
    _signCalendar.appearance.titleSelectionColor = [UIColor whiteColor];        //选中
    _signCalendar.appearance.titleTodayColor = [UIColor whiteColor];            //今日
    _signCalendar.appearance.titlePlaceholderColor = COLOR_TEXT_GRAY;           //占位
    _signCalendar.appearance.titleWeekendColor = COLOR_TEXT_GRAY;               //周末
    
#pragma 子文本
    _signCalendar.appearance.subtitleDefaultColor = COLOR_TEXT_BLACK28;         //默认
    _signCalendar.appearance.subtitleSelectionColor = [UIColor whiteColor];     //选中
    _signCalendar.appearance.subtitleTodayColor = [UIColor whiteColor];         //今日
    _signCalendar.appearance.subtitlePlaceholderColor = COLOR_TEXT_GRAY;        //占位
    _signCalendar.appearance.subtitleWeekendColor  = COLOR_TEXT_GRAY;           //周末
    
#pragma 其他
    _signCalendar.appearance.selectionColor = COLOR_RED_BACKGROUND;             //选中
    _signCalendar.appearance.todayColor = COLOR_BLUELIGHT_BACKGROUND;           //今日
    _signCalendar.appearance.todaySelectionColor = COLOR_RED_BACKGROUND;        //今日选中
    _signCalendar.appearance.borderDefaultColor = [UIColor clearColor];         //默认边框
    _signCalendar.appearance.borderSelectionColor = [UIColor clearColor];       //选中边框
    
    
    _signCalendar.dataSource = self;
    _signCalendar.delegate = self;
    _signCalendar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_signCalendar];
    [_signCalendar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(400);
        
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

#pragma mark -FSCalendarDataSource

//添加子标题
- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date{
    
    return [_allSignDateArr containsObject:date] ? 0 : @"未签到";
}

/*
//添加圆点(显示几个点)
- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date{
    
    return [_allSignDateArr containsObject:date] ? 1 : 0;
    
}
*/

//添加图片
- (UIImage *)calendar:(FSCalendar *)calendar imageForDate:(NSDate *)date{
    
    return [_allSignDateArr containsObject:date] ? [UIImage imageNamed:@"sign_star"] : 0;
}


#pragma mark -FSCalendarDelegate
//是否可以选择
- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(nonnull NSDate *)date{
    
    return YES;
    
}

//选择日期
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date{
    
    //NSLog(@"选择");
    
}


/**
 *  网络获取签到记录
 *
 */
- (void)networkGetSignHistoryWithUserName:(NSString *)username{
    
    [_allSignDateArr removeAllObjects];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AVQuery *query = [AVQuery queryWithClassName:CLOUD_SIGN_HISTORY];
    [query whereKey:@"username" equalTo:username];           //查询该用户名
    [query orderByAscending:@"signDate"];                    //时间升序
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        //NSLog(@"签到日期%@", objects);
        for (AVObject *signObject in objects) {
            
            // 使用FSCalendar的简介方法处理NSDate
            NSDate *signDate = [signObject objectForKey:@"signDate"];
            NSInteger year = [_signCalendar yearOfDate:signDate];
            NSInteger month = [_signCalendar monthOfDate:signDate];
            NSDate *resultDate = [_signCalendar dateWithYear:year month:month day:signDate.day];
            [_allSignDateArr addObject:resultDate];
            
            
        }
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [_signCalendar reloadData];
        
    }];

}
@end
