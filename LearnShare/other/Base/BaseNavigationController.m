//
//  BaseNavgationController.m
//  LearnShare
//
//  Created by James on 16/8/28.
//  Copyright © 2016年 james. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

#pragma mark -- add buttonItem

- (void)addThemeNavigationBackItemWithTitle:(NSString *)itemTitle{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backBtn setTitle:(itemTitle == nil?@"返回":itemTitle) forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 60, 35);
    backBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [backBtn addTarget:self action:@selector(popBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.topViewController.navigationItem.leftBarButtonItem = item;
    
    //解决自定义nav按钮后  返回手势消失问题
    self.interactivePopGestureRecognizer.delegate=(id)self.topViewController;
}

- (void)popBack:(UIBarButtonItem *)item {
    [self popViewControllerAnimated:YES];
}

#pragma mark --
//设置nav的背景色为透明
- (void)setNavBackgroundClear{
    self.navigationController.navigationBar.translucent = YES;
    UIColor *color = [UIColor clearColor];
    CGRect rect = CGRectMake(0, 0, 320, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
}

- (void)cancelNavigationBarTranslucentAndBottomBlackLine {
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

#pragma mark -- lift cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //去掉nav默认的透明效果 这个属性会导致代码编写的view的y值 差64
    self.navigationBar.translucent = NO;
    
    //修改navBar底部的黑线
    [self cancelNavigationBarTranslucentAndBottomBlackLine];
    
    //设置title为白色  字体大小
    [self.navigationBar setTitleTextAttributes:@{
                                                 NSForegroundColorAttributeName:[UIColor whiteColor],
                                                 NSFontAttributeName:[UIFont fontWithName:@"Chivo-Italic" size:20] }];
    
    
    //设置nav颜色
    [[UINavigationBar appearance] setBarTintColor:THEME_BACKGROUND_COLOR];
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

//@implementation UIViewController (MyNavigationController)
//
//
//
//@end
