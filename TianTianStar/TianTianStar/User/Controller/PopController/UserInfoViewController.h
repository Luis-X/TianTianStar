//
//  UserInfoViewController.h
//  TianTianStar
//
//  Created by LuisX on 16/6/7.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserInfoViewControllerDelegate <NSObject>

- (void)showUserEditViewController;

@end

@interface UserInfoViewController : UIViewController

@property (nonatomic, assign) id <UserInfoViewControllerDelegate> myDelegate;
@end
