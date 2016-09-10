//
//  ChatToolBarView.h
//  ChatToolBarView
//
//  Created by James on 16/9/9.
//  Copyright © 2016年 james. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChatToolBarViewDelegate <NSObject>

- (void)sendTextMessage;

- (void)sendGifMessage;

@end
@interface ChatToolBarView : UIView


NS_ASSUME_NONNULL_BEGIN

+ (instancetype)createChatToolBarViewWithDelegate:(UIViewController< ChatToolBarViewDelegate> *) delegate;

NS_ASSUME_NONNULL_END

- (void)addChatToolBarViewNotifications;

- (void)removeChatToolBarVIewnotifications;


//隐藏
- (void)hiddenChatToolBarView;
@end
