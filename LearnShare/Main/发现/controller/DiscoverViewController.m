//
//  DiscoverViewController.m
//  LearnShare
//
//  Created by James on 16/8/28.
//  Copyright © 2016年 james. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverTableViewCell.h"
#import "TimeLineViewController.h"
#import "NewsViewController.h"

 NSString *identifierCell = @"discoverCell";

@interface DiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) TimeLineViewController *timeLineController;
@property(nonatomic,strong) NewsViewController *newsController;
@property(nonatomic,strong) NSArray *dataArray;

@end

@implementation DiscoverViewController{


}

#pragma mark --懒加载

- (NSArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSArray alloc]initWithObjects:
                      @{@"title":@"学友圈",                @"prompt":@"Share The Happiness Of Learning"},
                      @{@"title":@"扫一扫",                @"prompt":@"Scanning"},
                      @{@"title":@"教育｜资讯",         @"prompt":@"Education   News"},
                      nil];
    }
    return _dataArray;
}

- (NewsViewController *)newsController{
    if(!_newsController){
        _newsController = [NewsViewController new];
        _newsController.hidesBottomBarWhenPushed = YES;
    }
    return _newsController;
}

- (TimeLineViewController *)timeLineController{
    if(!_timeLineController){
        _timeLineController = [[TimeLineViewController alloc]init];
        _timeLineController.hidesBottomBarWhenPushed = YES;
    }
    return _timeLineController;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    UITableView *tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tab.delegate = self;
    tab.dataSource = self;
    tab.bounces = NO;
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    tab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tab];
}

#pragma mark -- tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    
    if(!cell){
        cell = [[DiscoverTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER];
    }
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.title = [dict objectForKey:@"title"];
    cell.promptTitle = [dict objectForKey:@"prompt"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    switch (indexPath.row) {
     
        case 0:{
             [self.navigationController pushViewController:self.timeLineController animated:YES];
            break;
        }
        case 2:{
            [self.navigationController pushViewController:self.newsController animated:YES];
            break;
        }
            
    }
   
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

@end
