//
//  ViewController.m
//  TimeLine
//
//  Created by oujinlong on 16/6/12.
//  Copyright © 2016年 oujinlong. All rights reserved.
//

#import "TimeLineViewController.h"
#import "Masonry.h"
#import "TimeLineTableViewCell.h"
#import "TimeModel.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "MJRefresh.h"

#define color(r,g,b)     [UIColor colorWithRed:(r/255.0) green:g/255.0 blue:b/255.0 alpha:1]

@interface  TimeLineViewController() <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray* leftModleArray;
@property (nonatomic, strong) NSMutableArray* rightModelArray;
@property (nonatomic, weak) UITableView* leftTableView;
@property (nonatomic, weak) UITableView* rightTableView;
@property (nonatomic, weak) UIScrollView* scrollView;
@property (nonatomic, assign) NSInteger currentPageIndex;
//@property (nonatomic, weak) TimeLineSegmentView* segmentView;
@end

@implementation TimeLineViewController
- (NSMutableArray *)leftModleArray
{
    if (!_leftModleArray) {
        _leftModleArray = [NSMutableArray new];
    }
    return _leftModleArray;
}
- (NSMutableArray *)rightModelArray
{
    if (!_rightModelArray) {
        _rightModelArray = [NSMutableArray new];
    }
    return _rightModelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.title = @"圈";
    
    //    TimeLineSegmentView* segmentView = [[TimeLineSegmentView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 40)];
    //    self.segmentView = segmentView;
    //    segmentView.delegate = self;
    //    [self.view addSubview:segmentView];
    //    self.currentPageIndex = 0;
    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height )];
    self.scrollView = scrollView;
    //    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, scrollView.bounds.size.height);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    UITableView* leftTableView = [[UITableView alloc] initWithFrame:scrollView.bounds style:UITableViewStyleGrouped];
    self.leftTableView = leftTableView;
    leftTableView.dataSource = self;
    leftTableView.delegate = self;
    leftTableView.backgroundColor = [UIColor blackColor];
    leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupRefresh:leftTableView];
    [self.view addSubview:leftTableView];
    
    
    //    UITableView* rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height) style:UITableViewStyleGrouped];
    //    self.rightTableView = rightTableView;
    //    rightTableView.dataSource = self;
    //    rightTableView.delegate = self;
    //    rightTableView.backgroundColor = [UIColor blackColor];
    //    rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    [self setupRefresh:rightTableView];
    //    [scrollView addSubview:rightTableView];
    
    [self.leftModleArray addObjectsFromArray:[TimeModel models]];
    //    [self.rightModelArray addObjectsFromArray:[TimeModel models]];
}
-(void)setupRefresh:(UITableView*)tableView{
    if (tableView == self.leftTableView) {
        tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewLeft)];
        
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreLeft)];
    }
}
#pragma mark 刷新
-(void)loadNewLeft{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.leftModleArray removeAllObjects];
        
        
        [self.leftModleArray addObjectsFromArray:[TimeModel models]];
        
        [self.leftTableView reloadData];
        
        [self.leftTableView.mj_header endRefreshing];
    });
    
}
-(void)loadMoreLeft{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.leftModleArray addObjectsFromArray:[TimeModel models]];
        [self.leftTableView reloadData];
        [self.leftTableView.mj_footer endRefreshing];
    });
    
}
#pragma mark UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.leftTableView) {
        return self.leftModleArray.count;
        
    }else{
        return self.rightModelArray.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeLineTableViewCell* cell = [TimeLineTableViewCell cellWithTableView:tableView];
    
    if (tableView == self.leftTableView) {
        cell.model = self.leftModleArray[indexPath.section];
    }else{
        cell.model = self.rightModelArray[indexPath.section];
    }
    
    cell.sd_indexPath = indexPath;
    
    
    
    [cell setShowallClickBlock:^(NSIndexPath* indexPath){
        [tableView reloadData];
    }];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        return [tableView cellHeightForIndexPath:indexPath model:self.leftModleArray[indexPath.section] keyPath:@"model" cellClass:[TimeLineTableViewCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    }else{
        return [tableView cellHeightForIndexPath:indexPath model:self.rightModelArray[indexPath.section] keyPath:@"model" cellClass:[TimeLineTableViewCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 4;
}
//#pragma mark TimeLineSegmentViewDelegate
//-(void)TimeLineSegmentViewDidClickButtonWithIndex:(NSInteger)index{
//    NSLog(@"%zd",index);
//    [self.scrollView setContentOffset:CGPointMake(index * self.scrollView.bounds.size.width, 0) animated:YES];
//}
#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView != self.scrollView) {
        return;
    }
    
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    if (self.currentPageIndex != index) {
        self.currentPageIndex = index;
        //        [self.segmentView setCurrentPageIndex:self.currentPageIndex];
    }
    
    
}
@end
