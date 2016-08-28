//
//  LearnViewController.m
//  LearnShare
//
//  Created by James on 16/8/28.
//  Copyright © 2016年 james. All rights reserved.
//

#import "LearnViewController.h"
#import "XNLoopBannerView.h"
//29 169 252
@interface LearnViewController ()<XNLoopBannerViewDelegate>

@end

@implementation LearnViewController


- (void)addBannerView{
    NSArray *imageUrlArray = @[@"http://www.feizl.com/upload2007/2012_04/120414144943121.jpg",
                               @"http://img2.3lian.com/2014/f2/124/d/53.jpg",
                               @"http://img.bimg.126.net/photo/vTj1tKBi8UViyJye0EyMYw==/5785155196335487580.jpg",
                               @"http://cnm.szdwyy.com/uploads/allimg/140107/24-14010G63AX29.png"];
    
    XNLoopBannerView *bannerView = [[XNLoopBannerView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 175) imageUrls:imageUrlArray];
    bannerView.animationDuration = 5;
    bannerView.bannerDelegate = self;
    //    bannerView.placeholderImage
    
    [self.view addSubview:bannerView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
     [self addBannerView];
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
