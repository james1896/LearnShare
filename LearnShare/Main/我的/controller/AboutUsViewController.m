//
//  AboutUsViewController.m
//  LearnShare
//
//  Created by James on 16/8/31.
//  Copyright © 2016年 james. All rights reserved.
//

#import "AboutUsViewController.h"
#import "M80AttributedLabel.h"
@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //每一个段落用  ｜ 分开
    //每一段的抬头有  :区分
    
    NSString *text = @"我们团队:\n    这是一个崭新的团队\n|三方支持:\n    本项目在开发过程中使用到了以下开源库，在此特别感谢这些开源库的维护者,向你们致敬.(无先后顺序)\n[Masonry\nAFNetworking\nSDWebImage\nReachability\nSMPageControl\nM80AttributedLabel\nSDPhotoBrowser\nMJRefresh\nSDAutoLayout\n]";

    M80AttributedLabel *label = [[M80AttributedLabel alloc]initWithFrame:CGRectZero];
    label.lineSpacing = 6.0;
//    label.paragraphSpacing = 0.0;
    
        //处理文字
    NSArray *components = [text componentsSeparatedByString:@"|"];
    for(NSString *tmp in components){
        NSArray *tmpComponents = [tmp componentsSeparatedByString:@":"];
        NSString *tmpTitle = tmpComponents[0];
        NSString *tmpContent = tmpComponents[1];
        
        //处理每一段的 title
        NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@:",tmpTitle]];
        [attributedTitle m80_setTextColor:[UIColor blackColor]];
        [attributedTitle m80_setFont:[UIFont systemFontOfSize:18]];
        [label appendAttributedText:attributedTitle];
        
        //处理每一段的内容
        
         NSMutableAttributedString *attributedContent = [[NSMutableAttributedString alloc]initWithString:tmpContent];
        [attributedContent m80_setTextColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1]];
        [attributedContent m80_setFont:[UIFont systemFontOfSize:16]];
        [label appendAttributedText:attributedContent];
    }
    
    //scroll
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [scrollView addSubview:label];
    [self.view addSubview:scrollView];
    
    CGSize labelSize = [label sizeThatFits:CGSizeMake(CGRectGetWidth(self.view.bounds) - 40, CGFLOAT_MAX)];
    [label setFrame:CGRectMake(20, 10, labelSize.width, labelSize.height)];
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), labelSize.height + 20);
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
