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
#import "LearnShareUserInfo.h"
#import "LoginViewController.h"
@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)  AcountSettingViewController *acountController;
@end

@implementation MeViewController{
    
   
}

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

- (AcountSettingViewController *)acountController{
    if(!_acountController){
        _acountController = [[AcountSettingViewController alloc]init];
    }
    return _acountController;
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
    
    switch (indexPath.row) {
        case 0:{
            [self showUserSettingController];
            break;
        }
        case 1:{
            //当前版本号
            
            //提示 您当前已经是最新版本
            break;
        }
        case 2:{     //关于我们
       
            [self showAboutUsController];
          break;
        }
    }
}

- (void)showUserSettingController{
    if( [LearnShareUserInfo shareInstance].isLogin){
        
        //如果已经登录
        AcountSettingViewController *acountController = [AcountSettingViewController new];
        acountController.hidesBottomBarWhenPushed = YES;
          [self.navigationController pushViewController: acountController animated:YES];
    }else{
        
        //解决弹出速度 非常慢的问题
        
        //推断:      presentViewController这个方法有可能不是在UI线程执行的
        
        //因为present一张界面出来的时候往往会占用较多资源，所以编译器默认放在后台处理。如果直接获取主线程的话，可以减少很多时间。
        dispatch_async(dispatch_get_main_queue(), ^{
            LoginViewController *loginController = [LoginViewController new];
           
//            [self presentViewController:loginController animated:YES completion:nil];
            [self presentViewController:loginController animated:YES completion:nil];
        });
    }
}

- (void)showAboutUsController{
    AboutUsViewController *aboutController = [AboutUsViewController new];
    aboutController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: aboutController animated:YES];
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
