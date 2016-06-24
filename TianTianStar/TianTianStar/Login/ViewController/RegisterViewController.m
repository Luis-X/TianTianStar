//
//  RegisterViewController.m
//  TianTianStar
//
//  Created by LuisX on 16/6/12.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#define TITLE_FONT_SIZE 16

#import "RegisterViewController.h"
#import "RegisterModel.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_ALL_BACKGROUND;
    self.navigationItem.titleView = [Constant changeNavigationBarTitleStyleWithTitle:@"注册"];
    /**
     *  自定义左侧返回按钮
     */
    UIImage *leftImage = [UIImage imageNamed:@"header_back_icon"];
    leftImage = [leftImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(goLastViewController)];
    
    [self createMainView];
    
}

- (void)createMainView{

    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    form = [XLFormDescriptor formDescriptor];
//分区1
    section = [XLFormSectionDescriptor formSectionWithTitle:@"账号信息"];
    [form addFormSection:section];
    
    //账号
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"mobilePhoneNumber" rowType:XLFormRowDescriptorTypeText title:@"手机号:"];
    [row.cellConfig setObject:[UIFont fontWithName:FONT_LANTING_JIANHEI size:TITLE_FONT_SIZE] forKey:@"textLabel.font"];
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [section addFormRow:row];
    
    //密码
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"password" rowType:XLFormRowDescriptorTypePassword title:@"密码:"];
    [row.cellConfig setObject:[UIFont fontWithName:FONT_LANTING_JIANHEI size:TITLE_FONT_SIZE] forKey:@"textLabel.font"];
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [section addFormRow:row];
    
    //确认密码
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"surePassword" rowType:XLFormRowDescriptorTypePassword title:@"确认密码:"];
    [row.cellConfig setObject:[UIFont fontWithName:FONT_LANTING_JIANHEI size:TITLE_FONT_SIZE] forKey:@"textLabel.font"];
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [section addFormRow:row];
    
    //账号类型
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"type" rowType:XLFormRowDescriptorTypeSelectorPickerView title:@"账号类型:"];
    [row.cellConfig setObject:[UIFont fontWithName:FONT_LANTING_JIANHEI size:TITLE_FONT_SIZE] forKey:@"textLabel.font"];
    row.selectorOptions = @[TYPE_STUDENT, TYPE_TEACHER, TYPE_MASTER];
    [section addFormRow:row];
    
//分区2
    section = [XLFormSectionDescriptor formSectionWithTitle:@"个人信息"];
    [form addFormSection:section];
    
    //姓名
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"username" rowType:XLFormRowDescriptorTypeName title:@"姓名:"];
    [row.cellConfig setObject:[UIFont fontWithName:FONT_LANTING_JIANHEI size:TITLE_FONT_SIZE] forKey:@"textLabel.font"];
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [section addFormRow:row];
    
    //性别
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"sex" rowType:XLFormRowDescriptorTypeSelectorPickerView title:@"性别:"];
    [row.cellConfig setObject:[UIFont fontWithName:FONT_LANTING_JIANHEI size:TITLE_FONT_SIZE] forKey:@"textLabel.font"];
    row.selectorOptions = @[SEX_GG, SEX_MM];
    [section addFormRow:row];
    
    //班级
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"classroom" rowType:XLFormRowDescriptorTypeSelectorPickerView title:@"班级:"];
    [row.cellConfig setObject:[UIFont fontWithName:FONT_LANTING_JIANHEI size:TITLE_FONT_SIZE] forKey:@"textLabel.font"];
    row.selectorOptions = [Constant getAllClassroomArray];
    [section addFormRow:row];
    
    //入学时间
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"admissionDate" rowType:XLFormRowDescriptorTypeDate title:@"入学时间:"];
    [row.cellConfig setObject:[UIFont fontWithName:FONT_LANTING_JIANHEI size:TITLE_FONT_SIZE] forKey:@"textLabel.font"];
    row.value = [NSDate date];
    [section addFormRow:row];
    
//分区3
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"save" rowType:XLFormRowDescriptorTypeButton title:@"保存"];
    [row.cellConfig setObject:[UIFont fontWithName:FONT_LANTING_JIANHEI size:20] forKey:@"textLabel.font"];
    [row.cellConfig setObject:COLOR_RED_BACKGROUND forKey:@"textLabel.textColor"];
    row.action.formSelector = @selector(didTouchButton:);
    [section addFormRow:row];
    self.form = form;
}

- (void)injected{
    [self viewDidLoad];
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

/**
 *  返回上级视图
 */
- (void)goLastViewController{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)didTouchButton:(XLFormRowDescriptor *)sender{
    [self deselectFormRow:sender];
    
    NSDictionary *resultDic = self.form.formValues;
    RegisterModel *model = [RegisterModel new];
    [model setValuesForKeysWithDictionary:resultDic];

    if (model.mobilePhoneNumber.length <= 0) {
        [Constant showHUDProgressTitleWithMessage:@"手机号不能为空" AddView:self.view];
        return;
    }
    if (model.password.length <= 0) {
        [Constant showHUDProgressTitleWithMessage:@"密码不能为空" AddView:self.view];
        return;
    }
    if (model.surePassword.length <= 0) {
        [Constant showHUDProgressTitleWithMessage:@"确认密码不能为空" AddView:self.view];
        return;
    }
    if (![model.password isEqualToString:model.surePassword]) {
        [Constant showHUDProgressTitleWithMessage:@"两次输入密码不一致" AddView:self.view];
        return;
    }
    if (model.type.length <= 0) {
        [Constant showHUDProgressTitleWithMessage:@"账号类型不能为空" AddView:self.view];
        return;
    }
    if (model.username.length <= 0) {
        [Constant showHUDProgressTitleWithMessage:@"姓名不能为空" AddView:self.view];
        return;
    }
    if (model.sex.length <= 0) {
        [Constant showHUDProgressTitleWithMessage:@"性别不能为空" AddView:self.view];
        return;
    }
    if (model.classroom.length <= 0) {
        [Constant showHUDProgressTitleWithMessage:@"班级不能为空" AddView:self.view];
        return;
    }

    [self networkSaveWithRegisterModel:model];
}

/**
 *  网络注册
 *
 */
- (void)networkSaveWithRegisterModel:(RegisterModel *)registerModel{
    
    AVUser *user = [AVUser user];
    [user setUsername:registerModel.username];                              //姓名(用户名)
    [user setMobilePhoneNumber:registerModel.mobilePhoneNumber];            //手机号
    [user setPassword:registerModel.password];                              //密码
    [user setObject:registerModel.type forKey:@"type"];                     //账号类型
    [user setObject:registerModel.sex forKey:@"sex"];                       //性别
    [user setObject:registerModel.classroom forKey:@"classroom"];           //班级
    [user setObject:registerModel.admissionDate forKey:@"admissionDate"];   //入学时间
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            // 注册成功
            __weak typeof(self) weakSelf = self;
            [Constant showSIAlertViewWithTitle:HUAER_NAME Message:@"恭喜您注册成功!" OKHandler:^(SIAlertView *alertView) {
                [weakSelf goLastViewController];
            }];
            
        } else {
            
            [Constant showHUDProgressTitleWithMessage:@"注册失败!" AddView:self.view];
            NSLog(@"%@", error);
        }
        
    }];
    
}
@end
