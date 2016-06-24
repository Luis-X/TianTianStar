//
//  AppDelegate.m
//  TianTianStar
//
//  Created by LuisX on 16/5/19.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "AppDelegate.h"
#import "ConfigManager.h"
#import "BaseNavigationController.h"

#import "HomeViewController.h"
#import "ChatViewController.h"
#import "LoginViewController.h"
#import "UserCenterViewController.h"
#import "AddressBookViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //首页
    HomeViewController *homeVC = [HomeViewController new];
    BaseNavigationController *homeNaVC = [self customNavigationController:homeVC Name:@"首页" Image:@"home@2x.png" SelectedImage:@"home@2x.png"];
    
    /*
    //聊天
    ChatViewController *chatVC = [ChatViewController new];
    BaseNavigationController *chatNaVC = [self customNavigationController:chatVC Name:@"聊天" Image:@"chat@2x.png" SelectedImage:@"chat@2x.png"];
     */
    
    //通讯录
    AddressBookViewController *addressBookVC = [AddressBookViewController new];
    addressBookVC.myStyle = AddressBookStyleNormal;
    BaseNavigationController *addressBookNaVC = [self customNavigationController:addressBookVC Name:@"通讯录" Image:@"chat@2x.png" SelectedImage:@"chat@2x.png"];
    
    //我的
    UserCenterViewController *mineVC = [UserCenterViewController new];
    BaseNavigationController *mineNaVC= [self customNavigationController:mineVC Name:@"我" Image:@"mine@2x.png" SelectedImage:@"mine@2x.png"];
    
    UITabBarController *rootTabBC = [UITabBarController new];
    rootTabBC.viewControllers = @[homeNaVC, addressBookNaVC, mineNaVC];
    self.window.rootViewController = rootTabBC;
    [self.window makeKeyAndVisible];
    
    
    
    [self settingCustomAppearanceUI];
    
    
//TODO: 配置相关
    [[ConfigManager shareManager] startRongCloudIM];
    [[ConfigManager shareManager] startAVOSCloudAndAVAnalyticsWithOptions:launchOptions];
    //输出内部日志
    //[AVOSCloud setAllLogsEnabled:YES];
    
    return YES;
}


- (BaseNavigationController *)customNavigationController:(UIViewController*)vc Name:(NSString *)name Image:(NSString *)image SelectedImage:(NSString *)selectedImage{
    
    UIImage *normal_image = [UIImage imageNamed:image];
    UIImage *selected_image = [UIImage imageNamed:selectedImage];
    normal_image = [normal_image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selected_image = [selected_image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    BaseNavigationController *naVC = [[BaseNavigationController alloc] initWithRootViewController:vc];
    naVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:name image:normal_image selectedImage:selected_image];
    
    return naVC;
}

/**
 *  自定义全局UI样式
 */
- (void)settingCustomAppearanceUI {
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    // 设置背景图片
    UITabBar *tabBarAppearance = [UITabBar appearance];
    [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
    
    //去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [UITabBar appearance].backgroundColor = [UIColor whiteColor];
    [UITabBar appearance].translucent = NO;
    [UINavigationBar appearance].translucent = NO;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
