//
//  ConfigManager.m
//  TianTianStar
//
//  Created by LuisX on 16/5/21.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "ConfigManager.h"

@implementation ConfigManager
+ (ConfigManager *)shareManager{
    static ConfigManager *shareManager = nil;
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[self alloc] init];
    });
    
    return shareManager;
}

/**
 *  开启AVOSCloud和跟踪统计应用的打开情况
 *
 *  @param launchOptions AppDelegate加载完成launchOptions
 */
- (void)startAVOSCloudAndAVAnalyticsWithOptions:(NSDictionary *)launchOptions{
    
#pragma mark -初始化learnCloud
    
    //如果使用美国站点，请加上这行代码 [AVOSCloud setServiceRegion:AVServiceRegionUS];
    [AVOSCloud setApplicationId:LEANCLOUD_APPID clientKey:LEANCLOUD_APPKEY];
    //跟踪统计
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
}


/**
 *  开启融云IM
 */
- (void)startRongCloudIM{
    
#pragma mark -初始化融云
    
    [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_APPKEY];
    [[RCIM sharedRCIM] connectWithToken:RONGCLOUD_TOKEN success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
    
    

#pragma mark -聊天界面
    
    //聊天导航条按钮颜色
    [RCIM sharedRCIM].globalNavigationBarTintColor = [UIColor whiteColor];
    //会话列表头像样式
    [RCIM sharedRCIM].globalConversationAvatarStyle = RC_USER_AVATAR_RECTANGLE;
    //聊天界面头像样式
    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
 
    //正在输入状态提示
    [RCIM sharedRCIM].enableTypingStatus = YES;
    //消息已读回执
    [RCIM sharedRCIM].enableReadReceipt = YES;
}
@end
