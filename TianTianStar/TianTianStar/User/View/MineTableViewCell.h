//
//  MineTableViewCell.h
//  TianTianStar
//
//  Created by LuisX on 16/6/15.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MineCellStyleNormal,
    MineCellStylePhone,
    MineCellStylelogout,
} MineTableViewCellStyle;

@interface MineTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *contentLB;
@property (nonatomic, assign) MineTableViewCellStyle mineStyle;
@end
