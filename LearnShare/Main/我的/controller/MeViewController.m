//
//  MeViewController.m
//  LearnShare
//
//  Created by James on 16/8/30.
//  Copyright © 2016年 james. All rights reserved.
//

#import "MeViewController.h"

#import "MeTableViewCell.h"
#import "AboutUsViewController.h"
@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MeViewController

#pragma mark -- lift cycle
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aa"];
    
    if(!cell){
        cell = [[MeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aa"];
    }
    
    switch (indexPath.row) {
        case 0:{
            cell.title = @"关于我们";
            cell.promptTitle = @"About Us";
            break;
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    UIViewController *controller = nil;
    switch (indexPath.row) {
        case 0:{
            //关于我们
            controller = [AboutUsViewController new];
            controller.hidesBottomBarWhenPushed = YES;
          break;
        }
    }
    [self.navigationController pushViewController:controller animated:YES];
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
