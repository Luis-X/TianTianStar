//
//  BillsDetailViewController.m
//  TianTianStar
//
//  Created by LuisX on 16/6/7.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "BillsDetailViewController.h"
#import "BillsDetailTableViewCell.h"


@interface BillsDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation BillsDetailViewController{
    
    NSMutableArray *_allBillsDetailDataArr;
    UITableView *_billsDetailTableView;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Constant changeNavigationBarTitleStyleWithTitle:@"账单详情"];
    [self initailData];
    [self createMianView];
    
}

- (void)initailData{
    
    _allBillsDetailDataArr = [NSMutableArray array];
    
}

- (void)createMianView{
    
    _billsDetailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _billsDetailTableView.backgroundColor = [UIColor clearColor];
    _billsDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _billsDetailTableView.dataSource = self;
    _billsDetailTableView.delegate = self;
    //_billsDetailTableView.fd_debugLogEnabled = YES;
    [self.view addSubview:_billsDetailTableView];
    [_billsDetailTableView registerClass:[BillsDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_billsDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
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
    
    BillsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [self setupModelOfCell:cell AtIndexPath:indexPath];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
    
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
- (void)setupModelOfCell:(BillsDetailTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    
    //cell.model = [_allBillsDataArr objectAtIndex:indexPath.row];
    
}
@end
