//
//  AddressBookViewController.h
//  TianTianStar
//
//  Created by LuisX on 16/6/12.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    AddressBookStyleNormal,
    AddressBookStyleSign,
} AddressBookStyle;

@interface AddressBookViewController : UIViewController

@property (nonatomic, assign) AddressBookStyle myStyle;

@end
