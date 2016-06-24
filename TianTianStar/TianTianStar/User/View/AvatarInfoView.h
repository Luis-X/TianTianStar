//
//  AvatarInfoView.h
//  TianTianStar
//
//  Created by LuisX on 16/5/30.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AvatarInfoViewDelegate <NSObject>

- (void)chooseEditButtonEvent;

@end

@interface AvatarInfoView : UIView

@property(nonatomic, assign) id <AvatarInfoViewDelegate> myDelegate;
- (void)updateAvatarInfoViewDataWithName:(NSString *)name;

@end
