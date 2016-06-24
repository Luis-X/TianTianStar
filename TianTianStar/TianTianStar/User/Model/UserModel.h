//
//  UserModel.h
//  TianTianStar
//
//  Created by LuisX on 16/6/15.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, copy) NSString *type;                 //类型
@property (nonatomic, copy) NSString *avater;               //头像
@property (nonatomic, copy) NSString *username;             //姓名(用户名)
@property (nonatomic, copy) NSString *sex;                  //性别
@property (nonatomic, copy) NSString *classroom;            //班级
@property (nonatomic, strong) NSDate *admissionDate;        //入学时间

@property (nonatomic, copy) NSString *address;              //住址
@property (nonatomic, copy) NSString *mobilePhoneNumber;    //手机号
@property (nonatomic, copy) NSString *contactPhone;         //联系电话
@end
