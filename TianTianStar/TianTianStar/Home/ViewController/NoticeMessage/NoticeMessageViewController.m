//
//  NoticeMessageViewController.m
//  TianTianStar
//
//  Created by LuisX on 16/6/7.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "NoticeMessageViewController.h"
#import "MessageTableViewCell.h"


@interface NoticeMessageViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation NoticeMessageViewController{
    
    UITableView *_noticeMessageTableView;
    NSMutableArray *_allNoticeMessageDataArr;
    
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Constant changeNavigationBarTitleStyleWithTitle:@"公告"];
    [self initailData];
    [self createMainView];
    [self networkGetAllNoticeMessage];
    
}

- (void)initailData{
    
    _allNoticeMessageDataArr = [NSMutableArray array];
    
}

- (void)createMainView{
    
    _noticeMessageTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _noticeMessageTableView.backgroundColor = [UIColor clearColor];
    _noticeMessageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _noticeMessageTableView.dataSource = self;
    _noticeMessageTableView.delegate = self;
    //_noticeMessageTableView.fd_debugLogEnabled = YES;
    [self.view addSubview:_noticeMessageTableView];
    [_noticeMessageTableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_noticeMessageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.bottom.equalTo(self.view);
        
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [self setupModelOfCell:cell AtIndexPath:indexPath];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _allNoticeMessageDataArr.count;
    
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 20;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"cell" cacheByIndexPath:indexPath configuration:^(id cell) {
        
        [self setupModelOfCell:cell AtIndexPath:indexPath];
        
    }];
    
}

#pragma 重点(自适应高度必须实现)
//预加载Cell内容
- (void)setupModelOfCell:(MessageTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    
    cell.noticeMessageObject = (AVObject *)[_allNoticeMessageDataArr objectAtIndex:indexPath.row];
    
}


/**
 *  网络获取所有公告
 */
- (void)networkGetAllNoticeMessage{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_allNoticeMessageDataArr removeAllObjects];
    
    AVQuery *query = [AVQuery queryWithClassName:CLOUD_NOTICE_MESSAGE];
    [query whereKeyExists:@"noticeMessage"];                     //非空公告
    [query orderByDescending:@"updatedAt"];                      //时间倒序
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        [_allNoticeMessageDataArr addObjectsFromArray:objects];
        [_noticeMessageTableView reloadData];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];
    
}
@end
