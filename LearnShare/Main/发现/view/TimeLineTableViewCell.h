//
//  TimeLineTableViewCell.h
//  TimeLine
//
//  Created by oujinlong on 16/6/12.
//  Copyright © 2016年 oujinlong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeModel.h"
#import "UIView+SDAutoLayout.h"
@interface TimeLineTableViewCell : UITableViewCell

@property (nonatomic, strong) TimeModel* model;

//  全文/收起 按钮
@property (nonatomic, copy) void(^showallClickBlock)(NSIndexPath* indexPath);

//  评论按钮
@property(nonatomic,copy) void(^commentClickBlock)(NSIndexPath* indexPath);

//cell重用
+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView;

@end
