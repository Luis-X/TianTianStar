//
//  Constant.m
//  TianTianStar
//
//  Created by LuisX on 16/5/26.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "Constant.h"
//支付宝支付
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"

//微信支付
#import "payRequsestHandler.h"
#import "WXApi.h"

@implementation Constant

#pragma mark -导航栏定制
/**
 *  修改Navigationbar标题
 *
 *  @param titleStr 标题文字
 *
 *  @return 返回Label控件
 */
+ (UILabel *)changeNavigationBarTitleStyleWithTitle:(NSString *)titleStr{
    
    UIFont *titleFont = [UIFont fontWithName:FONT_LANTING_JIANHEI size:18];
    CGSize labelSize = [titleStr sizeWithAttributes:@{NSFontAttributeName : titleFont}];
    CGFloat titleViewWidth = MIN(labelSize.width,181);
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 0.f, titleViewWidth, 44.f)];
    titleLabel.font = titleFont;
    titleLabel.textColor = COLOR_TEXT_BLACK28;
    titleLabel.text = titleStr;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //titleLabel.backgroundColor = [UIColor orangeColor];
    return titleLabel;
    
    /*
     //是否开启屏幕FPS调试(需要将上面return 注掉)
     YYFPSLabel *fps = [[YYFPSLabel alloc] initWithFrame:CGRectMake(0.f, 0.f, titleViewWidth, 44.f)];
     return fps;
     */
}


//显示所有字体
+ (void)showAllFontBank{
    
    NSArray *familyNames =[[NSArray alloc]initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    NSLog(@"[familyNames count]===%lu",(unsigned long)[familyNames count]);
    
    for(indFamily = 0;indFamily<[familyNames count];++indFamily){
        
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames =[[NSArray alloc]initWithArray:[UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indFamily]]];
        
        for(indFont=0; indFont<[fontNames count]; ++indFont){
            
            NSLog(@"Font name: %@",[fontNames objectAtIndex:indFont]);
            
        }
        
    }
    
}

/**
 *  弹出视图选择(双按钮)
 */
+ (void)showSIAlertViewWithTitle:(NSString *)title Message:(NSString *)message OK:(NSString *)ok OKHandler:(SuccessHandler)OKHandler{
    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:title andMessage:message];
    [alertView addButtonWithTitle:ok type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alert) {
                            
    OKHandler(alert);
        
    }];
    
    [alertView addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeCancel handler:nil];
    //弹出方式
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    [alertView show];
    
}

/**
 *  弹出视图(单按钮)
 *
 */
+ (void)showSIAlertViewWithTitle:(NSString *)title Message:(NSString *)message OKHandler:(SuccessHandler)OKHandler{
    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:title andMessage:message];
    alertView.titleFont = [UIFont fontWithName:FONT_LANTING_JIANHEI size:16];
    alertView.messageFont = [UIFont fontWithName:FONT_LANTING_JIANHEI size:20];
    //弹出方式
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    
    [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alert) {
        
        OKHandler(alert);
        
    }];
    
    [alertView show];
    
}



/**
 *  文本格式
 *
 *  @param lineSpacing         行间距
 *  @param firstLineHeadIndent 首行缩进
 *  @param font                字体
 *  @param textColor           字体颜色
 *
 *  @return 字符串属性
 */
+ (NSDictionary *)settingAttributesWithLineSpacing:(CGFloat)lineSpacing FirstLineHeadIndent:(CGFloat)firstLineHeadIndent Font:(UIFont *)font TextColor:(UIColor *)textColor{
    //分段样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //行间距
    paragraphStyle.lineSpacing = lineSpacing;
    //首行缩进
    paragraphStyle.firstLineHeadIndent = firstLineHeadIndent;
    
    
    //富文本样式
    NSDictionary *attributeDic = @{
                                   NSFontAttributeName : font,
                                   NSParagraphStyleAttributeName : paragraphStyle,
                                   NSForegroundColorAttributeName : textColor
                                   };
    return attributeDic;
}

/**
 *  弹出视图
 *
 *  @param message 文本
 *  @param view    要添加的视图
 */
+ (void)showHUDProgressTitleWithMessage:(NSString *)message AddView:(UIView *)view{
   
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelFont = [UIFont fontWithName:FONT_LANTING_JIANHEI size:14];
    hud.detailsLabelText = message;
    hud.cornerRadius = 5;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:view animated:YES];
    });
    
}

/**
 *  汉字转拼音
 *
 *  @param chinese 汉字
 *
 *  @return 大写首字母拼音
 */
+ (NSString *)transformToBigPinYinFirst:(NSString *)chinese{
    
    if (chinese.length >= 1) {
        
        NSMutableString *pinyin = [chinese mutableCopy];
        CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
        return [[pinyin uppercaseString] substringToIndex:1];
        
    }
    
    return 0;
}

/**
 *  用户登录状态
 */
+ (BOOL)checkUserLoginStatus{
    
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        
        NSLog(@"登录中");
        return YES;
        
    } else {
        
        //缓存用户对象为空
        NSLog(@"未登录");
        return NO;
        
    }
    
}

/**
 *  检查用户权限
 */
+ (NSString *)checkCurrentUserType{
    
    AVUser *currentUser = [AVUser currentUser];
    NSString *type = [currentUser objectForKey:@"type"];
    return type;
    
}

/**
 *  所有班级数组
 *
 */
+ (NSArray *)getAllClassroomArray{
    
    return @[CLASS_L_1, CLASS_L_2, CLASS_L_3, CLASS_L_4, CLASS_L_5, CLASS_L_6,
             CLASS_M_1, CLASS_M_2, CLASS_M_3, CLASS_M_4, CLASS_M_5, CLASS_M_6,
             CLASS_S_1, CLASS_S_2, CLASS_S_3, CLASS_S_4, CLASS_S_5, CLASS_S_6,
             CLASS_T_1, CLASS_T_2, CLASS_T_3, CLASS_T_4, CLASS_T_5, CLASS_T_6,];
}


/**
 *  持久(保存选择班级)
 */
+ (void)defaultsSaveMyChooseClassroom:(NSString *)chooseClassroom{
    
    [[NSUserDefaults standardUserDefaults] setObject:chooseClassroom forKey:@"chooseClassroom"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

/**
 *  持久(获取选择班级)
 *
 */
+ (NSString *)defaultsGetMyChooseClassroom{
    
    NSString *chooseClassroom = [[NSUserDefaults standardUserDefaults] objectForKey:@"chooseClassroom"];
    return chooseClassroom;
    
}






//------------------------------------------支付----------------------------------------------------
+ (void)zhifubaoOrderNO:(NSString *)tradeNO productName:(NSString *)productName productDescription:(NSString *)productDescription amount:(CGFloat)amount notifyURL:(NSString *)notifyURL returnURL:(NSString *)returnURL SuccessBlock:(AllPaySuccessBlock)success{
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = PartnerID;
    NSString *seller = SellerID;
    NSString *privateKey = PartnerPrivateKey;
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = tradeNO; //订单ID（由商家自行制定）
    order.productName = productName; //商品标题
    order.productDescription = productDescription; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",amount]; //商品价格
    order.notifyURL =  notifyURL; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"fule";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"支付宝支付参数:orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        //支付并回调返回结果
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            //NSLog(@"支付宝结果: %@",resultDic);
            success(resultDic);
        }];
    }
}

+ (void)weixinOrderName:(NSString *)orderName amount:(NSInteger)amount orderNO:(NSString *)orderno notifyURL:(NSString *)notify_url returnURL:(NSString *)returnURL{
    
    //self.wxPayUrl = returnURL;
    //本实例只是演示签名过程， 请将该过程在商户服务器上实现
    
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc];
    //初始化支付签名对象
    [req init:WX_APP_ID mch_id:WX_MCH_ID];
    //设置密钥
    [req setKey:WX_PARTNER_ID];
    
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay:orderName price:amount orderno:orderno notify_url:notify_url];
    //NSLog(@"%@", notify_url);
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        
        NSLog(@"%@\n\n",debug);
    }else{
        NSLog(@"%@\n\n",[req getDebugifo]);
        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        [WXApi sendReq:req];
    }
    
}

@end
