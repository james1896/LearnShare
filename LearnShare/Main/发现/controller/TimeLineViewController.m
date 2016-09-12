//
//  ViewController.m
//  TimeLine
//
//  Created by oujinlong on 16/6/12.
//  Copyright © 2016年 oujinlong. All rights reserved.
//

#import "TimeLineViewController.h"
#import "TimeLineTableViewCell.h"
#import "TimeModel.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "MJRefresh.h"

#import "ChatToolBarView.h"


#define color(r,g,b)     [UIColor colorWithRed:(r/255.0) green:g/255.0 blue:b/255.0 alpha:1]

@interface  TimeLineViewController() <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,ChatToolBarViewDelegate>
@property (nonatomic, strong) NSMutableArray* modleArray;

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, weak) UIScrollView* scrollView;

@property (nonatomic,strong) ChatToolBarView *chatToolVarView;

@end

@implementation TimeLineViewController

- (NSMutableArray *)modleArray
{
    if (!_modleArray) {
        _modleArray = [NSMutableArray new];
    }
    return _modleArray;
}

- (UITableView *)tableView{
    if(!_tableView){
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-44-20) style:UITableViewStyleGrouped];
        _tableView = tab;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self setupRefresh:_tableView];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.view.backgroundColor = [UIColor whiteColor];

//    self.automaticallyAdjustsScrollViewInsets = NO;
    //需要修改
//    [self.navController addThemeNavigationBackItemWithTitle:@"学友圈"];
//    self.title = @"圈";
    
     [self.view addSubview:self.tableView];
    
   self.chatToolVarView = [ChatToolBarView createChatToolBarViewWithDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.chatToolVarView addChatToolBarViewNotifications];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self.chatToolVarView removeChatToolBarVIewnotifications];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.modleArray addObjectsFromArray:[TimeModel models]];
    [self.tableView reloadData];
}
-(void)setupRefresh:(UITableView*)tableView{
        tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewLeft)];
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreLeft)];
}

#pragma mark -- 刷新
-(void)loadNewLeft{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.modleArray removeAllObjects];
        [self.modleArray addObjectsFromArray:[TimeModel models]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    });
    
}
-(void)loadMoreLeft{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.modleArray addObjectsFromArray:[TimeModel models]];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    });
    
}
#pragma mark -- UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return self.modleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeLineTableViewCell* cell = [TimeLineTableViewCell dequeueReusableCellWithTableView:tableView];
        cell.model = self.modleArray[indexPath.section];
    
    cell.sd_indexPath = indexPath;
    
    
    [cell setShowallClickBlock:^(NSIndexPath* indexPath){
        //点击    全文／收起  按钮
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        [tableView reloadData];
    }];
    
    [cell setCommentClickBlock:^(NSIndexPath *indexPath) {
        NSLog(@"comment Click block");
        
        //得到 cell所在某个view的 rect
        CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
        //在这里 如果使用  [tableView superview]  y的0点在nav下面
        CGRect rect = [tableView convertRect:rectInTableView toView:[[tableView superview] superview]];
        NSLog(@"x:%f     y:%f",rect.origin.x,rect.origin.y);
        
        [self.chatToolVarView showChatToolBarView];
        
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return [tableView cellHeightForIndexPath:indexPath model:self.modleArray[indexPath.section] keyPath:@"model" cellClass:[TimeLineTableViewCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 4;
}

@end
