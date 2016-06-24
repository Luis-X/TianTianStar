//
//  BillsViewController.m
//  TianTianStar
//
//  Created by LuisX on 16/6/6.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "BillsViewController.h"
#import "BillsTableViewCell.h"
#import "BillsDetailViewController.h"


@interface BillsViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation BillsViewController{
    
    UITableView *_billsTableView;
    NSMutableArray *_allBillsDataArr;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Constant changeNavigationBarTitleStyleWithTitle:@"交费记录"];
    [self createMainView];
    
}

- (void)initailData{
    
    _allBillsDataArr = [NSMutableArray array];
    
}

- (void)createMainView{
    
    _billsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _billsTableView.backgroundColor = [UIColor clearColor];
    _billsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _billsTableView.dataSource = self;
    _billsTableView.delegate = self;
    //_billsTableView.fd_debugLogEnabled = YES;
    [self.view addSubview:_billsTableView];
    [_billsTableView registerClass:[BillsTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_billsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
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
    
    BillsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [self setupModelOfCell:cell AtIndexPath:indexPath];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BillsDetailViewController *billsDetailVC = [BillsDetailViewController new];
    [self.navigationController pushViewController:billsDetailVC animated:YES];
    
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
- (void)setupModelOfCell:(BillsTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    
    //cell.model = [_allBillsDataArr objectAtIndex:indexPath.row];
    
}



@end
