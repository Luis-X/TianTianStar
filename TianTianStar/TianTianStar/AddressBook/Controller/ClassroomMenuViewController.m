//
//  ClassroomMenuViewController.m
//  TianTianStar
//
//  Created by LuisX on 16/6/16.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "ClassroomMenuViewController.h"

@interface ClassroomMenuViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ClassroomMenuViewController{
    
    UITableView *_menuTV;
    NSArray *_allClassroomDataArr;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_ALL_BACKGROUND;
    [self initailData];
    [self createMainView];
    
}

- (void)initailData{
    
    _allClassroomDataArr = [Constant getAllClassroomArray];
    
}

- (void)createMainView{
    
    _menuTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _menuTV.backgroundColor = [UIColor clearColor];
    _menuTV.dataSource = self;
    _menuTV.delegate = self;
    [self.view addSubview:_menuTV];
    [_menuTV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_menuTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.equalTo(self.view);
        
    }];

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

#pragma mark -UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [_allClassroomDataArr objectAtIndex:indexPath.row]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont fontWithName:FONT_LANTING_JIANHEI size:14];
    cell.textLabel.textColor = COLOR_TEXT_GRAY;
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _allClassroomDataArr.count;
}


#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //保存班级
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *chooseClassroom = [NSString stringWithFormat:@"%@", [_allClassroomDataArr objectAtIndex:indexPath.row]];
    [Constant defaultsSaveMyChooseClassroom:chooseClassroom];
    [self.myDelegate completeChooseClassroom];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 35;
    
}


@end
