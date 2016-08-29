//
//  XXCollectionViewCell.m
//  Login
//
//  Created by James on 16/8/16.
//  Copyright © 2016年 james. All rights reserved.
//

#import "XXCollectionViewCell.h"

@interface XXCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@end
@implementation XXCollectionViewCell

- (void)setBottomLineColor:(UIColor *)bottomLineColor{
    _bottomLineColor = bottomLineColor;
    self.bottomLine.backgroundColor = bottomLineColor;
}
@end
