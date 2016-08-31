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

 NSString *identifierCell = @"discoverCell";

@interface DiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) TimeLineViewController *timeLineController;
@end

@implementation DiscoverViewController{
    

}

#pragma mark --懒加载

- (TimeLineViewController *)timeLineController{
    if(!_timeLineController){
        _timeLineController = [[TimeLineViewController alloc]init];
        _timeLineController.hidesBottomBarWhenPushed = YES;
    }
    return _timeLineController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor =  [UIColor colorWithRed:244/255.0 green:244/255.0 blue:245/255.0 alpha:1];
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    
    if(!cell){
        cell = [[DiscoverTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER];
    }
   cell.title = @"学友圈";
     cell.promptTitle = @"Share The Happiness Of Learning";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    [self.navigationController pushViewController:self.timeLineController animated:YES];
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
