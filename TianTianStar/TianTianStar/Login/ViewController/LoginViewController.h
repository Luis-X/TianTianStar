//
//  LoginViewController.h
//  TianTianGarden
//
//  Created by Mr.Feng on 20/3/1.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewControllerDelegate <NSObject>

- (void)userLoginSystemSuccess;

@end

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, weak) id <LoginViewControllerDelegate> myDelegate;
@end
