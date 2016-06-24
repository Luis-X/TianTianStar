//
//  SendNoticeViewController.m
//  TianTianStar
//
//  Created by LuisX on 16/6/17.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "SendNoticeViewController.h"
#import "NSString+Icons.h"

@interface SendNoticeViewController ()

@end

@implementation SendNoticeViewController{
    
    FUIButton *_sendNoticeButton;
    UITextView *_noticeTextView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Constant changeNavigationBarTitleStyleWithTitle:@"发布公告"];
    [self createMainView];
}

- (void)createMainView{
    
    //确认发布
    _sendNoticeButton = [FUIButton buttonWithType:UIButtonTypeCustom];
    //_sendNoticeButton.backgroundColor = COLOR_RED_BACKGROUND;
    _sendNoticeButton.buttonColor = [UIColor alizarinColor];
    _sendNoticeButton.shadowColor = [UIColor pomegranateColor];
    _sendNoticeButton.shadowHeight = 3.0f;
    _sendNoticeButton.cornerRadius = 3.0f;
    _sendNoticeButton.titleLabel.font = [UIFont iconFontWithSize:16];
    [_sendNoticeButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [_sendNoticeButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [_sendNoticeButton setTitle:[NSString stringWithFormat:@"%@确认", [NSString iconStringForEnum:FUILocation]] forState:UIControlStateNormal];
    [self.view addSubview:_sendNoticeButton];
    [_sendNoticeButton addTarget:self action:@selector(todoSendNoticeMessageWithButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_sendNoticeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_centerY);
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.height.mas_equalTo(50);
        
    }];
    
    //编辑文本
    _noticeTextView = [UITextView new];
    _noticeTextView.backgroundColor = [UIColor whiteColor];
    _noticeTextView.layer.borderColor = COLOR_LINE_GRAY.CGColor;
    _noticeTextView.layer.borderWidth = 1;
    _noticeTextView.layer.cornerRadius = 5;
    _noticeTextView.textColor = COLOR_TEXT_BLACK28;
    _noticeTextView.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:14];
    _noticeTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _noticeTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:_noticeTextView];
    [_noticeTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(30);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.bottom.equalTo(_sendNoticeButton.mas_top).offset(-30);
        
    }];
    
    //轻拍背景手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHidden)];
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
//回收键盘
- (void)keyboardHidden{
    
    [_noticeTextView resignFirstResponder];
    
}

/**
 *  确认
 */
- (void)todoSendNoticeMessageWithButton:(UIButton *)button{
    
    if (_noticeTextView.text.length <= 0) {
        
        [Constant showHUDProgressTitleWithMessage:@"请填内容!" AddView:self.view];
        return;
        
    }
    
    if (_noticeTextView.text) {
        
        AVObject *noticeObject = [[AVObject alloc] initWithClassName:CLOUD_NOTICE_MESSAGE];
        [noticeObject setObject:_noticeTextView.text forKey:@"noticeMessage"];      //公告信息
        AVUser *currentUser = [AVUser currentUser];
        [noticeObject setObject:currentUser.username forKey:@"sender"];             //发送人
        
        [noticeObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            if (succeeded) {
                
                [Constant showSIAlertViewWithTitle:HUAER_NAME Message:@"发布成功!" OKHandler:^(SIAlertView *alertView) {
                   
                    
                }];
                
            }else{
                
                [Constant showHUDProgressTitleWithMessage:@"发布失败!" AddView:self.view];
            
            }
            
        }];
    }
    
}



@end
