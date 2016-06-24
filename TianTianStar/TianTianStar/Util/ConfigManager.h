//
//  ConfigManager.h
//  TianTianStar
//
//  Created by LuisX on 16/5/21.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigManager : NSObject
//幼儿园信息
#define HUAER_NAME @"花儿朵朵幼儿园"
#define HUAER_PHONE @"15504222202"

//LeanCloud 设置
#define LEANCLOUD_APPID @"nrF4GHanQW92O3II6HghNs9f-gzGzoHsz"
#define LEANCLOUD_APPKEY @"JoszQWpl2WoaedVJnERn6Pqr"

//RongCloud 设置
#define RONGCLOUD_APPKEY @"0vnjpoadns42z"
#define RONGCLOUD_TOKEN @"Av655gu7bTEWDO5fkryZ1LqPcTHu7tZO8ioxQmmSCIcREWAM2YTxnc5tB94ICjE3YJr2WyNg8YsvMWwNLIcEKXm2CYQpyHV/" 
//账号:15504222202 用户名:fengxu
//需要先请求服务端Token

//**************** 支付宝相关宏文件    *****************************
// 合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088121633615127"
// 收款支付宝账号
#define SellerID  @"2088121633615127"
// 商户私钥，自助生成
#define PartnerPrivateKey @"MIICXwIBAAKBgQCo7U80Z1vFD36AyYJNXJ4QIyj3Xu38ND3RC+k2Ex0sylm/LYDMRlXYKBghkSvyQtc7+Z4tAUlCrUC5eccubI7xdswYdOeD1F8q7bZQaEgqkHrDoCi3s71QnHSuRtSi/GnQsGDKduskvejfREN+EzOXxUFtwFNMkSEaeuz023jnzQIDAQABAoGBAIDjB2KRVdiF2NxEY1HJT6Q6X2BWIrgh1+Ru9RHYBZOOFGmkOzgglhDljnvV+rTNwNC2xLPL3mysKc0aGBnYpDpjpw+bBAaaMo6kHD04gxw34Hpr/R6w1kfQ4YZBbAkAOkjUJ4XFl4U2XKJc246QyDvbaKbwTOzgo8wx6jptjbuVAkEA3Lh3NQ4P1NtBHFUgt47r/KN/yr9WInJy9QMyuDwkFb3wSp1H4BGFYL7VzEbZXSmCi5P7+xJmsFBUV+OBSDIaMwJBAMPtiG3CdRkCssCOk2cZybHqXsF2aZHhoJCorraYJ9guYzF0OhgEuJl4SFySQ6Z0wOkxfrAQVOaktanFC6WK9f8CQQC0WY4eLeVFufnT2sMm+YNeJYKP+hO5hebkyL4yyAF8On0TmrxWHDrtuEEd725Ar2BaCItGtdxuiNTCE8VZZob9AkEAiLjoPFe3aSWV4YNc31SCiDIZv31HPDKr3manzOmu3E+6jpchtwMMYqQqMtcqeCz/NXuBgZFT/cMwtfC4KOQotwJBALRhWyEvYiouKhU4LBW5zFDw8HhhTZcWT4pQnfj/eh4mwi3MhxS6hIBgi75TeJC9oF0Nce82XxHrgjdsQOnpN0c="
// 支付宝公钥
#define AlipayPublicKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDLKUarN26BG8Wqs/GUf1VAJtAMPuZJWkM07WBDChwUF2U3jznT4Q4mk4bULrX1a5Q4dpPHbpH/sgnFXiHDiUarpA1vQ/q4O8VXTZVhh7lDWjGomWz4N17FQzRvjD/GVf78mHhRYvMqTpArf/Pxg8QGlmzoP6BnX6IgCSW47MGf7wIDAQAB"

// 安全校验码（MD5）密钥，以数字和字母组成的32位字符(这个可有可无暂时没用上)
#define MD5_KEY @"uxt01uurwxvstkxpmleeok76ezicp8k4"



//****************************** 微信支付***************************
#define WX_APP_ID          @"wxfa636ced93e1d3b9"               //APPID
//#define APP_SECRET      @"bh000111222333444555666777888999" //appsecret
//商户号，填写商户对应参数
#define WX_MCH_ID          @"1328817901"
//商户API密钥，填写相应参数
#define WX_PARTNER_ID      @"6PaMphXAGCRCgcRYIwXBj5NTK2WtGfP6"
//支付结果回调页面
#define WX_NOTIFY_URL      @"http://xss.demo.sainti.net/index.php?r=api/wxpay/notify"
//获取服务器端支付数据地址（商户自定义）
#define WX_SP_URL          @"http://xss.demo.sainti.net/index.php?r=api/wxpay"


#define WX_NOTIFY_URL      @"111"                                  //微信通知



+ (ConfigManager *)shareManager;
- (void)startAVOSCloudAndAVAnalyticsWithOptions:(NSDictionary *)launchOptions;      //开启AVOSCloud和跟踪统计应用的打开情况
- (void)startRongCloudIM;                                                           //开启融云IM
@end
