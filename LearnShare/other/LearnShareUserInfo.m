//
//  LearnShareUserInfo.m
//  LearnShare
//
//  Created by James on 16/8/26.
//  Copyright © 2016年 james. All rights reserved.
//

#import "LearnShareUserInfo.h"

static LearnShareUserInfo *instance = nil;

@implementation LearnShareUserInfo{

    bool isCallInit;
}



+(LearnShareUserInfo *)shareInstance{
    
    if(!instance){
        instance = [[LearnShareUserInfo alloc]init];
        
    }
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end
