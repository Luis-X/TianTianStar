//
//  ClassroomMenuViewController.h
//  TianTianStar
//
//  Created by LuisX on 16/6/16.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClassroomMenuViewControllerDelegate <NSObject>

- (void)completeChooseClassroom;

@end

@interface ClassroomMenuViewController : UIViewController

@property (nonatomic, weak) id <ClassroomMenuViewControllerDelegate> myDelegate;
@end
