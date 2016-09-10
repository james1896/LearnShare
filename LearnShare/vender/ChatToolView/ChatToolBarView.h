//
//  ChatToolBarView.h
//  ChatToolBarView
//
//  Created by James on 16/9/9.
//  Copyright © 2016年 james. All rights reserved.
//

#import <UIKit/UIKit.h>

//支持表情键盘 和 gif
@protocol ChatToolBarViewDelegate <NSObject>

@required
- (void)sendTextMessage;


@optional
- (void)sendGifMessage;

@end
@interface ChatToolBarView : UIView

//掉用此方法
//不需要 addsubview
NS_ASSUME_NONNULL_BEGIN

+ (instancetype)createChatToolBarViewWithDelegate:(UIViewController< ChatToolBarViewDelegate> *) delegate;

NS_ASSUME_NONNULL_END

//chatToolBarView 相关的通知
- (void)addChatToolBarViewNotifications;

- (void)removeChatToolBarVIewnotifications;

//显示
- (void)showChatToolBarView;
//隐藏
- (void)hiddenChatToolBarView;
@end
