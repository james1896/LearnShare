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
    [[self layer] setShadowColor:[UIColor blackColor].CGColor];
    [[self layer] setShadowOffset:CGSizeMake(-0.3, -0.3)];
    [[self layer] setShadowOpacity:0.7];
    [[self layer] setShadowColor:[UIColor blackColor].CGColor];
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor{
    _bottomLineColor = bottomLineColor;
    self.bottomLine.backgroundColor = bottomLineColor;
}

- (void)updateBottomLineColor{
    [self.bottomLine.layer addSublayer:[self shadowAsInverse:CGRectMake(0, 0, self.bottomLine.bounds.size.width,self.bottomLine.bounds.size.height)]];
    self.bottomLine.layer.masksToBounds = YES;
}

- (CAGradientLayer *)shadowAsInverse:(CGRect)rect
{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
//    CGRect newShadowFrame = CGRectMake(0, 0, self.bottomLine.bounds.size.width,self.bottomLine.bounds.size.height);
    newShadow.frame = rect;
    //添加渐变的颜色组合（颜色透明度的改变）
    newShadow.colors = [NSArray arrayWithObjects:
                        (id)[[[UIColor colorWithRed:0.3+arc4random()%7/10.00 green:0.3+arc4random()%7/10.00 blue:0.3+arc4random()%7/10.00 alpha:0.6+arc4random()%4/10.0] colorWithAlphaComponent:0.4] CGColor],
                        
                        (id)[[[UIColor colorWithRed:0.3+arc4random()%7/10.00 green:0.3+arc4random()%7/10.00 blue:0.3+arc4random()%7/10.00 alpha:0.6+arc4random()%4/10.0] colorWithAlphaComponent:0.4] CGColor],
                        
                      (id)[[[UIColor colorWithRed:0.3+arc4random()%7/10.00 green:0.3+arc4random()%7/10.00 blue:0.3+arc4random()%7/10.00 alpha:0.6+arc4random()%4/10.0] colorWithAlphaComponent:0.6] CGColor],
                        nil];
    
    newShadow.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.3],
                           [NSNumber numberWithFloat:0.8],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    newShadow.startPoint = CGPointMake(0, 0);
    newShadow.endPoint = CGPointMake(1, 0);
    return newShadow;
}
@end
