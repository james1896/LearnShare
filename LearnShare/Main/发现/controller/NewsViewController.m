//
//  NewsViewController.m
//  LearnShare
//
//  Created by James on 16/8/31.
//  Copyright © 2016年 james. All rights reserved.
//

#import "NewsViewController.h"
#import "M80AttributedLabel.h"


@interface NewsViewController ()<M80AttributedLabelDelegate>

@end

@implementation NewsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark -- M80AttributedLabelDelegate
- (void)m80AttributedLabel:(M80AttributedLabel *)label
             clickedOnLink:(id)linkData
{
    NSString *message = [NSString stringWithFormat:@"LinkData is %@:%@",[[linkData class] description],linkData];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"U click a link"
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
    [alert show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    //设置 title 居中    主标题和副标题之间用  ｜  分开
    NSString *titleStr =@"这是一个标题\n|文章转载自www.baidu.com";
    NSArray *components = [titleStr componentsSeparatedByString:@"|"];
    M80AttributedLabel *titleLab = [[M80AttributedLabel alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, 65)];
    titleLab.delegate = self;
    titleLab.lineSpacing = 3;
    
    //主标题
    NSMutableAttributedString *mainText = [[NSMutableAttributedString alloc]initWithString:[components objectAtIndex:0]];
    [mainText m80_setFont:[UIFont systemFontOfSize:22]];
    
    titleLab.textAlignment = kCTTextAlignmentCenter;
    [titleLab appendAttributedText:mainText];
    
    //副标题
    NSString *subText =[components objectAtIndex:1];
   NSMutableAttributedString *att_subText = [[NSMutableAttributedString alloc]initWithString:subText];
    [att_subText m80_setFont:[UIFont systemFontOfSize:14]];
    titleLab.textAlignment = kCTTextAlignmentCenter;
    [titleLab appendAttributedText:att_subText];
  
    //添加 url链接
    NSRange range = [titleStr rangeOfString:@"www.baidu.com"];
    //如果前面加了一张图片 所有 range距离往后移动 1
    //如果  主副标题中间加了  ｜   range距离往后移动 1
    [titleLab addCustomLink:[NSValue valueWithRange:range] forRange:NSMakeRange(range.location-1, 13)];
    
    
    //文章内容
    M80AttributedLabel *label = [[M80AttributedLabel alloc]initWithFrame:CGRectZero];
    label.lineSpacing = 5.0;
    [label appendImage:[UIImage imageNamed:@"img1.jpg"
                        ] maxSize:CGSizeMake(SCREEN_WIDTH, 240)
                margin:UIEdgeInsetsZero
             alignment:M80ImageAlignmentCenter];
    
    NSString *text  = @"\nsay:有人问一位登山家为什么要去登山——谁都知道登山这件事既危险，又没什么实际的好处。[haha][haha][haha][haha]他回答道：“因为那座山峰在那里。”我喜欢这个答案，因为里面包含着幽默感——明明是自己想要登山，偏说是山在那里使他心里痒痒。除此之外，我还喜欢这位登山家干的事，没来由地往悬崖上爬。[haha][haha][haha]它会导致肌肉疼痛，还要冒摔出脑子的危险，所以一般人尽量避免爬山。[haha][haha][haha]用热力学的角度来看，这是个反熵的现象，所发趋害避利肯定反熵。去登山——谁都知道登山这件事既危险，又没什么实际的好处。[haha][haha][haha][haha]他回答道：“因为那座山峰在那里。”我喜欢这个答案，因为里面包含着幽默感——明明是自己想要登山，偏说是山在那里使他心里痒痒。除此之外，我还喜欢这位登山家干的事，没来由地往悬崖上爬。[haha][haha][haha]它会导致肌肉疼痛，还要冒摔出脑子的危险，所以一般人尽量避免爬山。[haha][haha][haha]用热力学的角度来看，这是个反熵的现象";
    
    
    
    //    NSArray *components = [text componentsSeparatedByString:@"[haha]"];
    //    NSUInteger count = [components count];
    //    for (NSUInteger i = 0; i < count; i++)
    //    {
    //        [label appendText:[components objectAtIndex:i]];
    //        if (i != count - 1)
    //        {
    //            [label appendImage:[UIImage imageNamed:@"haha"]
    //                       maxSize:CGSizeMake(15, 15)
    //                        margin:UIEdgeInsetsZero
    //                     alignment:M80ImageAlignmentCenter];
    //        }
    //    }
    
    
    [label appendText:text];
    
    //scroll
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [scrollView addSubview:label];
    [scrollView addSubview:titleLab];
    [self.view addSubview:scrollView];
    
    CGSize labelSize = [label sizeThatFits:CGSizeMake(CGRectGetWidth(self.view.bounds) - 40, CGFLOAT_MAX)];
    [label setFrame:CGRectMake(20, titleLab.xx_bottom, labelSize.width, labelSize.height)];
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), labelSize.height + titleLab.xx_bottom);
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
