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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
      self.bottomLineColor = [UIColor colorWithRed:0.3+arc4random()%7/10.00 green:0.3+arc4random()%7/10.00 blue:0.3+arc4random()%7/10.00 alpha:0.6+arc4random()%4/10.0];
    
    [[self layer] setShadowColor:[UIColor blackColor].CGColor];
    [[self layer] setShadowOffset:CGSizeMake(-0.3, -0.3)];
    [[self layer] setShadowOpacity:0.7];
    [[self layer] setShadowColor:[UIColor blackColor].CGColor];
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor{
    _bottomLineColor = bottomLineColor;
    self.bottomLine.backgroundColor = bottomLineColor;
}
@end
