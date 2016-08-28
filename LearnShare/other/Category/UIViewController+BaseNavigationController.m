//
//  UIViewController+BaseNavigationController.m
//  LearnShare
//
//  Created by James on 16/8/28.
//  Copyright © 2016年 james. All rights reserved.
//

#import "UIViewController+BaseNavigationController.h"

@implementation UIViewController (BaseNavigationController)

-(BaseNavigationController *)navController
{
    if ([self.navigationController isMemberOfClass:[BaseNavigationController class]]) {
        return (BaseNavigationController*)self.navigationController;
    }
    return nil;
}
@end
