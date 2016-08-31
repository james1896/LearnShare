//
//  CommonHeader.h
//  LearnShare
//
//  Created by James on 16/8/26.
//  Copyright © 2016年 james. All rights reserved.
//

#ifndef CommonHeader_h
#define CommonHeader_h


#include "LearnShareUserInfo.h"
#import "UIView+Attribute.h"

#pragma mark -- 获取设备大小

#define NAVBAR_HEIGHT                                                                           44

#define TABBAR_HEIGHT                                                                            49

#define STATUSBAR_HEIGHT                                                                    20

#define SCREEN_WIDTH                                                                                ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT                                                                               ([UIScreen mainScreen].bounds.size.height)


#pragma mark -- 获取系统版本

#define IOS_VERSION                                                                                     ［[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion                                                                        [UIDevice currentDevice] systemVersion]

#pragma mark -- 颜色类

// rgb颜色转换（16进制->10进制）
#define COLOR_TO_RGB(rgbValue)                                                              [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))     /255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A)                                                                               [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define THEME_BACKGROUND_COLOR                                                   [UIColor colorWithRed:29/255.0 green:169/255.0 blue:252/255.0 alpha:1]
#define THEME_FONT_COLOR                                                                    [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1]
#define THEME_PLACEHOLDER_FONT_COLOR                                    [UIColor colorWithRed:233/255.0 green:234/255.0 blue:235/255.0 alpha:1]













#endif /* CommonHeader_h */
