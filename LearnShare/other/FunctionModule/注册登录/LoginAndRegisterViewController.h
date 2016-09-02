//
//  LoginAndRegisterViewController.h
//  LearnShare
//
//  Created by James on 16/9/2.
//  Copyright © 2016年 james. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "CommonHeader.h"

#import "M80AttributedLabel.h"
@interface LoginAndRegisterViewController : UIViewController

@property(nonatomic,copy) NSString *titleInfo;

@property(nonatomic,copy) NSString *buttonTitle;

@property(nonatomic,strong) MASViewAttribute *bottom_button_top;


- (void)addReturnButtonTarget:(id)target action:(SEL)action;
- (void)addBottomButtonTarget:(id)target action:(SEL)action;
- (UIView *)createFormWithTextField:(UITextField *)textField atIndex:(NSInteger)index;
@end
