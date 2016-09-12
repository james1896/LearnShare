//
//  LoginAndRegisterViewController.h
//  LearnShare
//
//  Created by James on 16/9/2.
//  Copyright © 2016年 james. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "M80AttributedLabel.h"
@interface LoginAndRegisterViewController : UIViewController

//  在掉用createFormWithTextField:(UITextField *)textField atIndex:(NSInteger)index    方法时候
//  第一个试图位于当前主视图Y中心轴 向上偏移的位置
@property(nonatomic) int draw_offset_y;

//title
@property(nonatomic,copy) NSString *titleInfo;

@property(nonatomic,copy) NSString *buttonTitle;

@property(nonatomic,strong) MASViewAttribute *bottom_button_top;


- (void)addReturnButtonTarget:(id)target action:(SEL)action;
- (void)addBottomButtonTarget:(id)target action:(SEL)action;
- (UIView *)createFormWithTextField:(UITextField *)textField atIndex:(NSInteger)index;
@end
