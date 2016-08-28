//
//  BaseNavgationController.m
//  LearnShare
//
//  Created by James on 16/8/28.
//  Copyright © 2016年 james. All rights reserved.
//

#import "BaseNavgationController.h"

@interface BaseNavgationController ()

@end

@implementation BaseNavgationController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置nav颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:29/255.0 green:169/255.0 blue:252/255.0 alpha:1]];
  
    //去掉nav下面的黑线
       self.navigationBar.translucent = NO;
}

- (void)cancelNavigationBarTranslucentAndBottomBlackLine {
    //去掉nav默认的透明效果 这个属性会导致代码编写的view的y值 差64
    self.navigationBar.translucent = NO;
    //修改navBar底部的黑线
    if ([self.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
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

@implementation UIViewController (MyNavigationController)

-(BaseNavgationController *)MyNavigationController
{
    if ([self.navigationController isMemberOfClass:[BaseNavigationController class]]) {
        return (BasicNavigationController*)self.navigationController;
    }
    return nil;
}
