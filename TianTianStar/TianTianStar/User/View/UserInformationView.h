//
//  UserInformationView.h
//  TianTianGarden
//
//  Created by Mr.Feng on 20/3/15.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserInformationViewDelegate <NSObject>

- (void)todoSelectedHeaderEvent;
- (void)todoSelectedAccountManagerEvent;
@end

@interface UserInformationView : UIImageView
@property(nonatomic, weak) id<UserInformationViewDelegate> myDelegate;
- (void)updateUserInfomationViewDataWithUsername:(NSString *)username Type:(NSString *)type;
@end
