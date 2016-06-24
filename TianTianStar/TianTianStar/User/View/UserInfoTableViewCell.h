//
//  UserInfoTableViewCell.h
//  TianTianGarden
//
//  Created by LuisX on 16/4/5.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@interface UserInfoTableViewCell : UITableViewCell
@property(nonatomic, strong)UILabel *titleLB;
- (void)updateUserInfoDetailDataWithCellIndexPath:(NSIndexPath *)cellIndexPath Model:(UserModel *)model;
@end
