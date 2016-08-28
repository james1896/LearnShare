//
//  TimeModel.h
//  TimeLine
//
//  Created by oujinlong on 16/6/12.
//  Copyright © 2016年 oujinlong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContentImageModel;
@interface TimeModel : NSObject
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *contentText;
@property (nonatomic, strong) NSArray <ContentImageModel*>* imageArray;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, copy) NSString* time;
@property (nonatomic, assign) NSInteger likeCount;
@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, assign) BOOL isShowAll;
@property (nonatomic, assign) BOOL shouldShowAllButton;
@property (nonatomic, assign) BOOL isLiked;
+(NSArray*)models;


@end
@interface ContentImageModel : NSObject
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@end