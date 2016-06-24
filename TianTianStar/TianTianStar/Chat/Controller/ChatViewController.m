//
//  ChatViewController.m
//  TianTianStar
//
//  Created by LuisX on 16/6/6.
//  Copyright © 2016年 LuisX. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatMessageViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = COLOR_ALL_BACKGROUND;
    self.title = @"聊天";
    [self loadChatListData];
    [self createMainView];
}

/**
 *  加载会话列表
 */
- (void)loadChatListData{
    
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)]];
}

- (void)createMainView{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"联系园长" style:UIBarButtonItemStyleDone target:self action:@selector(showChatDetailViewController)];
    
    
    self.conversationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //Cell背景颜色
    //self.cellBackgroundColor = [UIColor redColor];
    
    //列表为空视图
    //self.emptyConversationView.backgroundColor = [UIColor redColor];
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
 *  打开聊天界面
 *
 */
- (void)showChatDetailViewController{
    
    NSLog(@"创建聊天");
    
    //新建一个聊天会话View Controller对象
    ChatMessageViewController *chatMessageVC = [[ChatMessageViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chatMessageVC.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chatMessageVC.targetId = @"123";
    //设置聊天会话界面要显示的标题
    chatMessageVC.title = @"联系园长";
    //显示聊天会话界面
    chatMessageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatMessageVC animated:YES];
    
}






#pragma mark 点击事件的回调
/**
 *  点击会话列表，进入聊天会话界面
 *
 */
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"进入聊天");
    
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = model.targetId;
    conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
    
}

/**
 *  点击头像回调
 *
 */
- (void)didTapCellPortrait:(RCConversationModel *)model{
    NSLog(@"头像: %@", model);
}
@end
