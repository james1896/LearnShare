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
#import "AcountSettingViewController.h"
@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MeViewController

#pragma mark -- lift cycle
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
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
            cell.title = @"账户设置";
            cell.promptTitle = @"Acount Setting";
            
            cell.rightText = @"(未登录)";
            break;
        }
        case 1:{
        cell.title = @"当前版本";
            cell.rightText = @"1.0.0";
            break;
        }
            
        case 2:{
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
            controller = [AcountSettingViewController new];
            break;
        }
        case 1:{
            
            break;
        }
        case 2:{
            //关于我们
            controller = [AboutUsViewController new];
            controller.hidesBottomBarWhenPushed = YES;
          break;
        }
    }
    if(controller)
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
