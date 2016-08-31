//
//  UIViewController+BaseNavigationController.h
//  LearnShare
//
//  Created by James on 16/8/28.
//  Copyright © 2016年 james. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"
@interface UIViewController (BaseNavigationController)

@property (readonly,nonatomic)BaseNavigationController *navController;
@end
