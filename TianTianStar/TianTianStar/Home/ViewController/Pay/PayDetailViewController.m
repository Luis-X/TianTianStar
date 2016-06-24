//
//  PayDetailViewController.m
//  TianTianStar
//
//  Created by LuisX on 16/6/8.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "PayDetailViewController.h"
#import "PayTypeTableViewCell.h"
#import "PayTypeModel.h"

@interface PayDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation PayDetailViewController{
    
    UITableView *_payTypeTableView;
    NSMutableArray *_allPayTypeDataArr;
    CGFloat _payAmount;
    
}


//重写初始化方法
- (instancetype)initWithTitle:(NSString *)title PayAmount:(CGFloat)payAmount{
    
    if (self = [super init]) {
        
        self.title = title;
        _payAmount = payAmount;
        
        self.contentSizeInPopup = CGSizeMake(self.view.frame.size.width, 260);
        //边框颜色
        [STPopupNavigationBar appearance].barTintColor = COLOR_ALL_BACKGROUND;
        //按钮颜色
        [STPopupNavigationBar appearance].tintColor = COLOR_TEXT_BLACK28;
        //标题属性
        [STPopupNavigationBar appearance].titleTextAttributes = @{ NSFontAttributeName: [UIFont fontWithName:FONT_LANTING_JIANHEI size:18], NSForegroundColorAttributeName: COLOR_TEXT_BLACK28 };
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initailData];
    [self createMainView];
    
}

- (void)initailData{
    
    _allPayTypeDataArr = [NSMutableArray array];
    NSArray *payTypeArr = @[@{@"iconName" : @"pay_alipay@2x.png", @"payTypeName" : @"支付宝付款"},
                            @{@"iconName" : @"pay_weixin@2x.png", @"payTypeName" : @"微信付款"}];
    
    
    [payTypeArr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
        
        PayTypeModel *model = [PayTypeModel new];
        [model setValuesForKeysWithDictionary:dic];
        [_allPayTypeDataArr addObject:model];
        
    }];
    

}

- (void)createMainView{
    
    _payTypeTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _payTypeTableView.backgroundColor = [UIColor clearColor];
    _payTypeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _payTypeTableView.dataSource = self;
    _payTypeTableView.delegate = self;
    //_payTypeTableView.fd_debugLogEnabled = YES;
    [self.view addSubview:_payTypeTableView];
    [_payTypeTableView registerClass:[PayTypeTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_payTypeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
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
    
    PayTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [self setupModelOfCell:cell AtIndexPath:indexPath];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _allPayTypeDataArr.count;
    
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        [self chooseAliPayType];
        
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        [self chooseWeiXinType];
        
    }
    
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
- (void)setupModelOfCell:(PayTypeTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath{
    
    cell.model = (PayTypeModel *)[_allPayTypeDataArr objectAtIndex:indexPath.row];
    
}





/**
 *  支付宝
 */
- (void)chooseAliPayType{
    
    NSLog(@"支付宝付款 %.2f", _payAmount);
    [Constant zhifubaoOrderNO:@"11111" productName:@"学费" productDescription:@"花儿朵朵学费" amount:_payAmount notifyURL:nil returnURL:nil SuccessBlock:^(id result) {
        
        
    }];
    
}

/**
 *  微信
 */
- (void)chooseWeiXinType{
    
    NSLog(@"微信付款 %.2f", _payAmount);
    [Constant weixinOrderName:@"微信" amount:_payAmount * 100 orderNO:@"1111" notifyURL:@"" returnURL:@""];
    
}
@end
