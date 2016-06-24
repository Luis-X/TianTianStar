//
//  LoginViewController.m
//  TianTianGarden
//
//  Created by Mr.Feng on 20/3/1.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#define LOGIN_TEXTBACKGROUND_HEIGHT 90      //输入框背景高度
#define LOGIN_IMAGE_TOP_BOTTOM_SPACE 12     //图片上下间距

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController{
    UITextField *_phoneTF;
    UITextField *_passwordTF;
    FUIButton *_loginButton;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self checkTextFiledTextIsEmpty];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = COLOR_ALL_BACKGROUND;
    //self.navigationItem.titleView = [Constant changeNavigationBarTitleStyleWithTitle:@"登录"];
    [self createSubViews];
    
}

- (void)createSubViews{
    //背景图片
    UIImageView *picBackgroundView = [UIImageView new];
    [picBackgroundView setImage:[UIImage imageNamed:@"home_bg@2x.png"]];
    picBackgroundView.clipsToBounds = YES;
    picBackgroundView.contentMode = 2;
    picBackgroundView.userInteractionEnabled = YES;
    //picBackgroundView.backgroundColor = COLOR_BLUE_BACKGROUND;
    [self.view addSubview:picBackgroundView];
    [picBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    
    //返回按钮
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //goBackBtn.backgroundColor = [UIColor cyanColor];
    [goBackBtn setImage:[UIImage imageNamed:@"login_close.png"] forState:UIControlStateNormal];
    [goBackBtn addTarget:self action:@selector(goBackViewController) forControlEvents:UIControlEventTouchUpInside];
    [picBackgroundView addSubview:goBackBtn];
    [goBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(picBackgroundView.mas_top).offset(25);
        make.left.equalTo(picBackgroundView.mas_left).offset(10);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    //LOGO
    UIImageView *logoIV = [UIImageView new];
    //logoIV.backgroundColor = [UIColor redColor];
    [logoIV setImage:[UIImage imageNamed:@"1.jpg"]];
    logoIV.contentMode = 2;
    logoIV.clipsToBounds = YES;
    [self.view addSubview:logoIV];
    [logoIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_centerY).offset(-200);
        make.width.and.height.mas_equalTo(88);
    }];
    
    //输入框背景
    UIView *textBackground = [UIView new];
    textBackground.backgroundColor = [UIColor whiteColor];
    textBackground.layer.masksToBounds = YES;
    textBackground.layer.cornerRadius = 3;
    [self.view addSubview:textBackground];
    [textBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoIV.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(LOGIN_TEXTBACKGROUND_HEIGHT);
    }];
    
    //手机号图片
    UIImageView *phoneIV = [UIImageView new];
    //phoneIV.backgroundColor = [UIColor redColor];
    [phoneIV setImage:[UIImage imageNamed:@"login_phone.png"]];
    phoneIV.contentMode = 1;
    phoneIV.clipsToBounds = YES;
    [self.view addSubview:phoneIV];
    [phoneIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textBackground.mas_top).offset(LOGIN_IMAGE_TOP_BOTTOM_SPACE);
        make.left.equalTo(textBackground.mas_left).offset(5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo((LOGIN_TEXTBACKGROUND_HEIGHT - 4 * LOGIN_IMAGE_TOP_BOTTOM_SPACE) / 2);
    }];
    
    //手机号输入
    _phoneTF = [UITextField new];
    //_phoneTF.backgroundColor = [UIColor greenColor];
    _phoneTF.placeholder = @"请输入手机号码,暂时只支持中国大陆";
    _phoneTF.font = [UIFont systemFontOfSize:14];
    _phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTF.delegate = self;
    [self.view addSubview:_phoneTF];
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textBackground.mas_top).offset(5);
        make.left.equalTo(phoneIV.mas_right).offset(5);
        make.bottom.equalTo(phoneIV.mas_bottom).offset(LOGIN_IMAGE_TOP_BOTTOM_SPACE - 5);
        make.right.equalTo(textBackground.mas_right).offset(-5);
    }];
    
    //黑线
    UIView *blackLine = [UIView new];
    blackLine.backgroundColor = COLOR_LINE_GRAY;
    [self.view addSubview:blackLine];
    [blackLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textBackground.mas_top).offset(LOGIN_TEXTBACKGROUND_HEIGHT / 2);
        make.left.equalTo(textBackground.mas_left).offset(15);
        make.right.equalTo(textBackground.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    
    //密码图片
    UIImageView *passwordIV = [UIImageView new];
    //passwordIV.backgroundColor = [UIColor orangeColor];
    [passwordIV setImage:[UIImage imageNamed:@"login_password.png"]];
    passwordIV.contentMode = 1;
    passwordIV.clipsToBounds = YES;
    [self.view addSubview:passwordIV];
    [passwordIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(blackLine.mas_bottom).offset(LOGIN_IMAGE_TOP_BOTTOM_SPACE);
        make.left.equalTo(phoneIV.mas_left);
        make.bottom.equalTo(textBackground.mas_bottom).offset(-LOGIN_IMAGE_TOP_BOTTOM_SPACE);
        make.right.equalTo(phoneIV.mas_right);
    }];
    
    //密码输入
    _passwordTF = [UITextField new];
    //_passwordTF.backgroundColor = [UIColor pinkColor];
    _passwordTF.placeholder = @"请输入密码(6-20位数字或英文)";
    _passwordTF.font = [UIFont systemFontOfSize:14];
    _passwordTF.delegate = self;
    _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTF.secureTextEntry = YES;
    [self.view addSubview:_passwordTF];
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(blackLine.mas_top).offset(5);
        make.left.equalTo(_phoneTF.mas_left);
        make.bottom.equalTo(textBackground.mas_bottom).offset(-5);
        make.right.equalTo(_phoneTF.mas_right);
    }];
    
    //登录
    _loginButton = [FUIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.buttonColor = [UIColor tangerineColor];
    _loginButton.shadowColor = [UIColor sunflowerColor];
    _loginButton.shadowHeight = 8.0f;
    _loginButton.cornerRadius = 5.0f;
    _loginButton.titleLabel.font = [UIFont boldFlatFontOfSize:20];
    [_loginButton setTitle:@"登 录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [self.view addSubview:_loginButton];
    [_loginButton addTarget:self action:@selector(loginButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textBackground.mas_bottom).offset(30);
        make.left.equalTo(textBackground.mas_left);
        make.right.equalTo(textBackground.mas_right);
        make.height.mas_equalTo(50);
    }];
    
    //忘记密码
    UIButton *forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //forgetPasswordBtn.backgroundColor = [UIColor redColor];
    [forgetPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPasswordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    forgetPasswordBtn.titleLabel.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:14];
    [forgetPasswordBtn addTarget:self action:@selector(forgetPasswordButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPasswordBtn];
    [forgetPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginButton.mas_bottom).offset(10);
        make.left.equalTo(_loginButton.mas_left);
    }];
    
    //立即注册
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //registerBtn.backgroundColor = [UIColor orangeColor];
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:14];
    [registerBtn addTarget:self action:@selector(registerButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(forgetPasswordBtn.mas_top);
        make.right.equalTo(_loginButton.mas_right);
    }];
    
    //轻拍背景手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHidden)];
    [self.view addGestureRecognizer:tap];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//返回上级界面
- (void)goBackViewController{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

//键盘回收
- (void)keyBoardHidden{
    [_phoneTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
}


/**
 *  登录
 *
 */
- (void)loginButtonEvent:(UIButton *)button{
    [self keyBoardHidden];
    [self networkVerifyPhone:_phoneTF.text Password:_passwordTF.text];
}

/**
 *  忘记密码
 *
 */
- (void)forgetPasswordButtonEvent:(UIButton *)button{
    
    NSLog(@"忘记密码");
    [self keyBoardHidden];
    
}

/**
 *  注册
 *
 */
- (void)registerButtonEvent:(UIButton *)button{
    
    //NSLog(@"注册");
    [self keyBoardHidden];
    RegisterViewController *registerVC = [RegisterViewController new];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}


/**
 *  验证是否输入正确格式的账号密码
 */
- (void)checkTextFiledTextIsEmpty{
    
    _loginButton.enabled = NO;
    
    if (_phoneTF.text.length < 11) {
        //NSLog(@"手机长度未通过 %@", _phoneTF.text);
        return;
    }
    if (_passwordTF.text.length < 6) {
        //NSLog(@"密码长度未通过 %@", _passwordTF.text);
        return;
    }
    
    _loginButton.enabled = YES;
}

#pragma mark -UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *phoneStr = _phoneTF.text;
    NSString *passwordStr = _passwordTF.text;
    if (textField == _phoneTF) {
        phoneStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
       //手机号长度限制11位
        if (phoneStr.length > 11) {
            _phoneTF.text = [phoneStr substringToIndex:11];
            return NO;
        }
    }
    
    if (textField == _passwordTF) {
       passwordStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        //密码长度限制20字符
        if (passwordStr.length > 20) {
            _passwordTF.text = [passwordStr substringToIndex:20];
            return NO;
        }
    }
    
    [self checkTextFiledTextIsEmpty];
    return YES;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{
  
    [self checkTextFiledTextIsEmpty];
    return YES;
    
}

//网络验证账号密码
- (void)networkVerifyPhone:(NSString *)phone Password:(NSString *)password{
    
    //NSLog(@"账号: %@, 密码: %@", phone, password);
    [AVUser logInWithMobilePhoneNumberInBackground:phone password:password block:^(AVUser *user, NSError *error) {
        
        if (user != nil) {//登录成功
            
            [self goBackViewController];
            [self.myDelegate userLoginSystemSuccess];
            
            
        } else {//登录失败
            
            [Constant showHUDProgressTitleWithMessage:@"用户名或密码错误!" AddView:self.view];
            
        }
        
    }];
    
}
@end
