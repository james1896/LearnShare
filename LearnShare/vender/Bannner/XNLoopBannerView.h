//
//  XNLoopBannerView.h
//  XNLoopBannerView
//
//  Created by XuNing on 15/6/10.
//  Copyright (c) 2015年 XuNing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SMPageControl/SMPageControl.h>

@class XNLoopBannerView;
@protocol XNLoopBannerViewDelegate <NSObject>
@optional

- (void)bannerViewReadButtonPress:(UIButton *)sender;
- (void)bannerView:(XNLoopBannerView *)bannerView didSelectAtIndex:(NSInteger)index;

@end


////////////////////////////////////////////////////////////       XXNoteView         ////////////////////////////////////////////////////////////////////////////////////////////////////


@interface XXNoteView : UIView
@property(nonatomic,copy) NSString *titleString;
@property(nonatomic,copy) NSString *contentString;

- (instancetype)initWithFrame:(CGRect)frame Inview:(XNLoopBannerView *)view;
@end

////////////////////////////////////////////////////////////       XNLoopBannerView         ////////////////////////////////////////////////////////////////////////////////////////////////////
@interface XNLoopBannerView : UIView

@property(nonatomic, weak) id<XNLoopBannerViewDelegate> bannerDelegate;
@property(nonatomic, strong, readonly) SMPageControl *pageControl;
@property(nonatomic) NSInteger currentPage; //default is 0.
@property(nonatomic) BOOL autoScroll; //default is YES.
@property(nonatomic) BOOL showNoteView;

@property(nonatomic) NSTimeInterval animationDuration; //default is 3s.
@property(nonatomic, strong) UIImage *placeholderImage;

/**
 *  do NOT use ".pageControl.frame = " to change frame of pageControl. Default is CGRectMake(0,
 *  self.frame.size.height - 22, self.frame.size.width, 22).
 */
@property(nonatomic) CGRect pageControlFrame;
@property(nonatomic) float pageControlPace; //default is 5
//  object in "imageUrls" must be kind of NSString or NSURL class"


@property(nonatomic,strong) NSArray *imageUrls;

- (instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray *)imageUrls;
- (void)reloadWithImageUrls:(NSArray *)imageUrls;

- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated;

@end
