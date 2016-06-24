//
//  Constant.h
//  TianTianStar
//
//  Created by LuisX on 16/5/26.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIAlertView.h"

typedef void(^SuccessHandler)(SIAlertView *alertView);
typedef void (^AllPaySuccessBlock)(id result);

@interface Constant : NSObject
//颜色
#define COLOR_ALL_BACKGROUND [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]
#define COLOR_BLUELIGHT_BACKGROUND [UIColor colorWithRed:86/255.0 green:168/255.0 blue:232/255.0 alpha:1]
#define COLOR_BLUE_BACKGROUND [UIColor colorWithRed:68/255.0 green:158/255.0 blue:230/255.0 alpha:1]
#define COLOR_GREEN_BACKGROUND [UIColor colorWithRed:30/255.0 green:170/255.0 blue:100/255.0 alpha:1]
#define COLOR_RED_BACKGROUND [UIColor colorWithRed:251/255.0 green:74/255.0 blue:71/255.0 alpha:1]
#define COLOR_YELLOW_BACKGROUND  [UIColor colorWithRed:255/255.0 green:174/255.0 blue:1/255.0 alpha:1]

#define COLOR_LINE_GRAY [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]

//字体
#define FONT_LANTING_JIANHEI @"FZLTHJW--GB1-0"                   //兰亭简黑
#define FONT_LANTING_XIHEI @"FZLTXHKM"                           //兰亭细黑

#define COLOR_TEXT_BLACK28  [UIColor colorWithRed:28/255.0 green:27/255.0 blue:36/255.0 alpha:1]
#define COLOR_TEXT_GRAY [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1]
#define COLOR_TEXT_ORANGE [UIColor colorWithRed:252/255.0 green:97/255.0 blue:32/255.0 alpha:1]

#define FX_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define FX_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

+ (UILabel *)changeNavigationBarTitleStyleWithTitle:(NSString *)titleStr;
+ (void)showAllFontBank;
+ (NSDictionary *)settingAttributesWithLineSpacing:(CGFloat)lineSpacing FirstLineHeadIndent:(CGFloat)firstLineHeadIndent Font:(UIFont *)font TextColor:(UIColor *)textColor;
+ (NSString *)transformToBigPinYinFirst:(NSString *)chinese;                                    //汉字转拼音(大写)

+ (void)showSIAlertViewWithTitle:(NSString *)title Message:(NSString *)message OKHandler:(SuccessHandler)OKHandler;
+ (void)showSIAlertViewWithTitle:(NSString *)title Message:(NSString *)message OK:(NSString *)ok OKHandler:(SuccessHandler)OKHandler;
+ (void)showHUDProgressTitleWithMessage:(NSString *)message AddView:(UIView *)view;

+ (BOOL)checkUserLoginStatus;                                   //检查登录状态
+ (NSString *)checkCurrentUserType;                             //账户类型

+ (NSArray *)getAllClassroomArray;                              //所有班级

+ (void)defaultsSaveMyChooseClassroom:(NSString *)chooseClassroom;          //保存选择班级
+ (NSString *)defaultsGetMyChooseClassroom;                                 //获取班级


//支付宝支付(订单号,商品名,商品详情,金额,通知URL,回调URL)
+ (void)zhifubaoOrderNO:(NSString *)tradeNO productName:(NSString *)productName productDescription:(NSString *)productDescription amount:(CGFloat)amount notifyURL:(NSString *)notifyURL returnURL:(NSString *)returnURL SuccessBlock:(AllPaySuccessBlock)success;

//微信支付(订单名,价格,订单编号,通知URL,回调URL) (金额以分为单位)
+ (void)weixinOrderName:(NSString *)orderName amount:(NSInteger)amount orderNO:(NSString *)orderno notifyURL:(NSString *)notify_url returnURL:(NSString *)returnURL;
@end
