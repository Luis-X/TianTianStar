//
//  ChatMessageViewController.m
//  TianTianStar
//
//  Created by LuisX on 16/6/6.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "ChatMessageViewController.h"

@interface ChatMessageViewController ()

@end

@implementation ChatMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createMianViews];
}

- (void)createMianViews{

    
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

/*
 点击Cell中头像
 */
- (void)didTapCellPortrait:(NSString *)userId{
    
    NSLog(@"用户ID: %@", userId);
    
}

/*
 点击Cell中电话号码
 */
- (void)didTapPhoneNumberInMessageCell:(NSString *)phoneNumber
                                 model:(RCMessageModel *)model{
    
    NSLog(@"电话号码: %@", phoneNumber);
    
}

/*
 点击Cell中URL
 */
- (void)didTapUrlInMessageCell:(NSString *)url
                         model:(RCMessageModel *)model{
    
    NSLog(@"%@", url);
    
}
@end
