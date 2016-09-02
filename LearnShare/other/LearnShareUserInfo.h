//
//  LearnShareUserInfo.h
//  LearnShare
//
//  Created by James on 16/8/26.
//  Copyright © 2016年 james. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LearnShareUserInfo : NSObject

@property(nonatomic,strong) NSString *userName;

@property(nonatomic) BOOL isLogin;

+(LearnShareUserInfo *)shareInstance;
@end
