//
//  NewTemplate_One.h
//  LearnShare
//
//  Created by James on 16/9/1.
//  Copyright © 2016年 james. All rights reserved.
//

#import <UIKit/UIKit.h>

//一张图片、  一个主标题 、 一个副标题
@interface NewTemplate_One : UIView

@property(nonatomic,copy) NSString *text;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *subTitle;

- (instancetype)initWithFrame:(CGRect)frame AndData:(id)data;

- (instancetype)initWithFrame:(CGRect)frame AndTitle:(NSString *)title AndSubtitle:(NSString *)subTitle AndText:(NSString *)text;
@end
