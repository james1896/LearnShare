//
//  UIView+Attribute.m
//  LearnShare
//
//  Created by James on 16/8/30.
//  Copyright © 2016年 james. All rights reserved.
//

#import "UIView+Attribute.h"

@implementation UIView (Attribute)


- (CGFloat)xx_height{
    return self.bounds.size.height;
}
- (CGFloat)xx_bottom{
    return self.frame.origin.y+self.frame.size.height;
}
@end
