//
//  PayViewController.m
//  TianTianStar
//
//  Created by LuisX on 16/6/8.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "PayViewController.h"
#import "PayDetailViewController.h"

@interface PayViewController ()<UITextFieldDelegate>

@end

@implementation PayViewController{
    
    STPopupController *_mySTPopupController;       //弹出视图
    FUITextField *_moneyTextField;
    UILabel *_showMoneyLB;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Constant changeNavigationBarTitleStyleWithTitle:@"交费"];
    [self initailData];
    [self createMainView];
}

- (void)initailData{
    
}

- (void)createMainView{
    //LOGO
    UIImageView *payBackgroundView = [UIImageView new];
    //payBackgroundView.backgroundColor = [UIColor orangeColor];
    payBackgroundView.contentMode = 2;
    payBackgroundView.clipsToBounds = YES;
    [payBackgroundView setImage:[UIImage imageNamed:@"2.jpg"]];
    [self.view addSubview:payBackgroundView];
    [payBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view).offset(50);
        make.centerX.equalTo(self.view);
        make.width.height.mas_equalTo(80);
        
    }];
    
    //显示信息
    UILabel *payProjectLB = [UILabel new];
    payProjectLB.text = [NSString stringWithFormat:@"收费人: %@", HUAER_NAME];
    payProjectLB.font = [UIFont systemFontOfSize:16];
    payProjectLB.textColor = COLOR_TEXT_GRAY;
    payProjectLB.textAlignment = NSTextAlignmentCenter;
    //payProjectLB.backgroundColor = [UIColor blueColor];
    [self.view addSubview:payProjectLB];
    [payProjectLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(payBackgroundView.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        
    }];

    
    //显示金额
    _showMoneyLB = [UILabel new];
    _showMoneyLB.text = @"￥0.00";
    _showMoneyLB.font = [UIFont systemFontOfSize:35];
    _showMoneyLB.textColor = COLOR_TEXT_BLACK28;
    _showMoneyLB.textAlignment = NSTextAlignmentCenter;
    //_showMoneyLB.backgroundColor = [UIColor redColor];
    [self.view addSubview:_showMoneyLB];
    [_showMoneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(payProjectLB.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
        
    }];
    
    
    //自定义金额
    _moneyTextField = [FUITextField new];
    _moneyTextField.placeholder = @"请输入金额";
    _moneyTextField.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:15];
    _moneyTextField.backgroundColor = [UIColor clearColor];
    _moneyTextField.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    _moneyTextField.textFieldColor = [UIColor whiteColor];
    _moneyTextField.borderColor = COLOR_GREEN_BACKGROUND;
    _moneyTextField.borderWidth = 2.0f;
    _moneyTextField.cornerRadius = 3.0f;
    _moneyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    _moneyTextField.textAlignment = NSTextAlignmentCenter;
    _moneyTextField.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:16];
    _moneyTextField.delegate = self;
    [self.view addSubview:_moneyTextField];
    [_moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_showMoneyLB.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(50);
        
    }];

    //支付
    FUIButton *payButton = [FUIButton buttonWithType:UIButtonTypeCustom];
    payButton.buttonColor = COLOR_GREEN_BACKGROUND;
    payButton.shadowColor = [UIColor greenSeaColor];
    payButton.shadowHeight = 5.0f;
    payButton.cornerRadius = 5.0f;
    payButton.titleLabel.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:20];
    [payButton setTitle:@"确定" forState:UIControlStateNormal];
    [payButton setTitle:@"确定" forState:UIControlStateHighlighted];
    [payButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [payButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [self.view addSubview:payButton];
    [payButton addTarget:self action:@selector(showPayDetailViewController:) forControlEvents:UIControlEventTouchUpInside];
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_moneyTextField.mas_bottom).offset(20);
        make.left.right.equalTo(_moneyTextField);
        make.height.mas_equalTo(_moneyTextField);
        
    }];
    
    
    //轻拍背景手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHidden)];
    [self.view addGestureRecognizer:tap];
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

#pragma mark -UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *moneyStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    CGFloat moneyNumber = [moneyStr doubleValue];
    _showMoneyLB.text = [NSString stringWithFormat:@"￥%.2f", moneyNumber];
    return YES;
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    _showMoneyLB.text = @"￥0.00";
    return YES;
    
}

/**
 *  支付
 *
 */
- (void)showPayDetailViewController:(FUIButton *)fButton{
    
    CGFloat payAmount = [_moneyTextField.text floatValue];
    if (payAmount > 0) {
        
        [self showPayDetailViewControllerWithPayAmount:payAmount];
    }else{
        [Constant showHUDProgressTitleWithMessage:@"请输入正确的金额!" AddView:self.view];
    }
    
    NSLog(@"支付金额:%.2f", payAmount);
    
}

/**
 *  支付方式视图
 *
 *  @param payAmount 金额
 */
- (void)showPayDetailViewControllerWithPayAmount:(CGFloat)payAmount{
    
    PayDetailViewController *payDetailVC = [[PayDetailViewController alloc] initWithTitle:@"支付方式" PayAmount:payAmount];
    _mySTPopupController = [[STPopupController alloc] initWithRootViewController:payDetailVC];
    //样式(中心,底部)
    _mySTPopupController.style = STPopupStyleBottomSheet;
    //动画效果
    _mySTPopupController.transitionStyle = STPopupTransitionStyleSlideVertical;
    //透明
    //_mySTPopupController.containerView.backgroundColor = [UIColor clearColor];
    //设置圆角
    _mySTPopupController.containerView.layer.cornerRadius = 0;
    //隐藏导航栏
    //_mySTPopupController.navigationBarHidden = NO;
    [_mySTPopupController presentInViewController:self];
    //关闭视图
    UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSTPopupController)];
    [_mySTPopupController.backgroundView addGestureRecognizer:dismissTap];

}

/**
 *  轻拍背景消失
 */
- (void)dismissSTPopupController{
    [_mySTPopupController dismiss];
}

/**
 *  键盘回收
 */
- (void)keyBoardHidden{
  
    [_moneyTextField resignFirstResponder];
    
}
@end
