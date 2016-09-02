//
//  XNLoopBannerView.m
//  XNLoopBannerView
//
//  Created by XuNing on 15/6/10.
//  Copyright (c) 2015年 XuNing. All rights reserved.
//

#import "XNLoopBannerView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDWebImagePrefetcher.h>

#import "M80AttributedLabel.h"

////////////////////////////////////////////////////////////       XNLoopBannerViewCell         ////////////////////////////////////////////////////////////////////////////////////////////////////

@interface XNLoopBannerViewCell : UICollectionViewCell
@property(nonatomic, strong) UIImageView *imageView;
@end

@implementation XNLoopBannerViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.contentView.frame;
}

@end


////////////////////////////////////////////////////////////       XXNoteView         ////////////////////////////////////////////////////////////////////////////////////////////////////


@interface XXNoteView()

@end

@implementation XXNoteView{
    
    UILabel *titleLab;
     UIButton *readButton;
    M80AttributedLabel *contentView;
    
    
    XNLoopBannerView *superView;
}

- (instancetype)initWithFrame:(CGRect)frame Inview:(XNLoopBannerView *)view
{
    self = [super initWithFrame:frame];
    if (self) {
        
        float width = self.bounds.size.width;
        float height = self.bounds.size.height;
        float pace = 15;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        
        UIView *upLine = [[UIView alloc]initWithFrame:CGRectMake(pace, height/5, width-pace*2, 1)];
        upLine.backgroundColor = [UIColor lightGrayColor];
        UIView *downLine = [[UIView alloc]initWithFrame:CGRectMake(pace, height*4/5, width-pace*2, 1)];
        downLine.backgroundColor = [UIColor lightGrayColor];
        
        //titleLabel
        titleLab = [[UILabel alloc]initWithFrame:CGRectMake(pace, 1, width-pace*2, height/5-3)];
        titleLab.numberOfLines = 2;
        titleLab.text = @"YOU DREAM VACATION";
        titleLab.textColor = [UIColor colorWithRed:253/255.0 green:205/255.0 blue:47/255.0 alpha:1];
         titleLab.textAlignment = NSTextAlignmentCenter;
        [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.5]];
        
        //contentView
        contentView = [[M80AttributedLabel alloc]initWithFrame:CGRectMake(pace+2, upLine.frame.origin.y+upLine.frame.size.height, upLine.frame.size.width-4, height*3/5)];
        contentView.textColor = [UIColor whiteColor];
        contentView.lineSpacing = 0.5;
        contentView.font = [UIFont systemFontOfSize:12.5];
        contentView.paragraphSpacing = 0.0;
//        contentView.textAlignment = NSTextAlignmentCenter;
        contentView.text = @"在iOS7显示的时候会在顶部会出现一条黑线,如下图: 这时候就会影响了我们的界面。 我们可以有两种的解决办法,如果你的";
//        contentView = [[UITextView alloc]initWithFrame:CGRectMake(pace-2, upLine.frame.origin.y+upLine.frame.size.height, upLine.frame.size.width+4, height*3/5)];
//        contentView.backgroundColor = [UIColor clearColor];
//        contentView.textColor = [UIColor whiteColor];
////        [contentView setContentInset:UIEdgeInsetsMake(-5, -8, -5, -8)];
//        contentView.textAlignment = NSTextAlignmentCenter;
//        contentView.editable = NO;
//        contentView.text = @"在iOS7显示的时候会在顶部会出现一条黑线,如下图: 这时候就会影响了我们的界面。 我们可以有两种的解决办法,如果你的";
//            contentView.scrollEnabled = NO;
        //read button
        readButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [readButton setTitle:@"READ MORE" forState:UIControlStateNormal];
        readButton.titleLabel.font = [UIFont systemFontOfSize:12.1];
        readButton.layer.cornerRadius = 2;
        readButton.frame = CGRectMake(pace, height*4/5+10, downLine.bounds.size.width, 20);
        [readButton addTarget:self action:@selector(readButton:) forControlEvents:UIControlEventTouchUpInside];
        [readButton setBackgroundColor:[UIColor colorWithRed:26/255.0 green:152/255.0 blue:249/255.0 alpha:1]];
        
        [self addSubview:upLine];
        [self addSubview:downLine];
        [self addSubview:titleLab];
        [self addSubview:readButton];
        [self addSubview:contentView];
        
        superView = view;
        [view addSubview:self];
    }
    
    return self;
}

- (void)setTitleString:(NSString *)titleString{
    titleLab.text = titleString;
}

- (void)setContentString:(NSString *)contentString{
    contentView.text = contentString;
}

- (void)readButton:(UIButton *)sender{
    
    if([superView.bannerDelegate respondsToSelector:@selector(bannerViewReadButtonPress:)]){
          [superView.bannerDelegate bannerViewReadButtonPress:sender];
    }
}

@end


////////////////////////////////////////////////////////////       XNLoopBannerView         ////////////////////////////////////////////////////////////////////////////////////////////////////


static NSString *CellIdentifier = @"XNLoopBannerViewCell";

@interface XNLoopBannerView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, copy) NSArray *urls;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic) BOOL useCustomPageControlFrame;

@property(nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property(nonatomic, strong) UICollectionView *collectionView;


//noteView
@property(nonatomic,strong) XXNoteView *noteView;
@end


@implementation XNLoopBannerView

@synthesize pageControl = _pageControl;

- (void)setImageUrls:(NSArray *)imageUrls{
    [self reloadWithImageUrls:imageUrls];
}

#pragma mark - Life Cycle
- (void)dealloc {
    self.collectionView.dataSource = nil;
    self.collectionView.delegate = nil;
    [self invalidateTimer];
}

- (instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray *)imageUrls {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.urls = [self convertToNSURLArrayFrom:imageUrls];
        
        [self prefetchImages];
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
        [self addSubview:self.noteView];
        [self setup];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
    self.flowLayout.itemSize = self.frame.size;
    self.collectionView.collectionViewLayout = self.flowLayout;
    
    if (self.useCustomPageControlFrame) {
        self.pageControl.frame = self.pageControlFrame;
    } else {
        self.pageControl.frame = CGRectMake(self.bounds.size.width*4/5, self.frame.size.height - 35, self.frame.size.width/5, 22);
    }
    
    [self setCurrentPage:self.currentPage ? self.currentPage : 0 animated:NO];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.urls.count <= 1) {
        return self.urls.count;
    }
    return self.urls.count + 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XNLoopBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (0 == indexPath.item) {
        [cell.imageView sd_setImageWithURL:[self.urls lastObject]
                          placeholderImage:self.placeholderImage];
    } else if (self.urls.count + 1 == indexPath.item) {
        [cell.imageView sd_setImageWithURL:[self.urls firstObject]
                          placeholderImage:self.placeholderImage];
    } else {
        [cell.imageView sd_setImageWithURL:self.urls[indexPath.item - 1]
                          placeholderImage:self.placeholderImage];
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if ([self.bannerDelegate respondsToSelector:@selector(bannerView:didSelectAtIndex:)]) {
        [self.bannerDelegate bannerView:self didSelectAtIndex:self.currentPage];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (0 >= scrollView.contentOffset.x) {
        [self collectionViewScrollToRealPage:self.urls.count];
    } else if ((self.urls.count + 1) * scrollView.frame.size.width <= scrollView.contentOffset.x) {
        [self collectionViewScrollToRealPage:1];
    } else {
        _currentPage = scrollView.contentOffset.x / scrollView.frame.size.width - 1;
    }
    
    self.pageControl.currentPage = self.currentPage;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self continueTimerLater];
}

#pragma mark - Event Response
- (void)scrollToNext {
    if (self.currentPage > self.urls.count) {
        _currentPage %= self.urls.count;
    }
    self.currentPage++;
}

#pragma mark - Private Method
- (void)setup {
    self.pageControl.numberOfPages = self.urls.count;
    self.animationDuration = 3;
    self.autoScroll = YES;
}

- (void)collectionViewScrollToRealPage:(NSInteger)page {
    [self setCurrentPage:page - 1 animated:NO];
}

- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated {
    _currentPage = currentPage;
    
    if (self.urls.count > 1) {
        [self.collectionView setContentOffset:CGPointMake((currentPage + 1) * self.collectionView.frame.size.width, 0) animated:animated];
    }
}

- (void)pauseTimer {
    self.timer.fireDate = [NSDate distantFuture];
}

- (void)continueTimerLater {
    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:self.animationDuration];
}

- (void)invalidateTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setupTimer {
    if (self.urls.count > 1) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.animationDuration
                                                      target:self
                                                    selector:@selector(scrollToNext)
                                                    userInfo:nil
                                                     repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (NSArray *)convertToNSURLArrayFrom:(NSArray *)urlArray {
    NSMutableArray *convertedArray = [NSMutableArray array];
    for (id url in urlArray) {
        NSAssert([url isKindOfClass:[NSURL class]] || [url isKindOfClass:[NSString class]],
                 @"*** object in array \"imageUrls\" must be kind of NSString or NSURL class");
        if ([url isKindOfClass:[NSURL class]]) {
            [convertedArray addObject:url];
        } else if ([url isKindOfClass:[NSString class]]) {
            [convertedArray addObject:[NSURL URLWithString:url]];
        }
    }
    return [convertedArray copy];
}

- (void)prefetchImages {
    if (self.urls.count > 1) {
        NSMutableArray *urlsExceptFirst = [self.urls mutableCopy];
        [urlsExceptFirst removeObjectAtIndex:0];
        [[SDWebImagePrefetcher sharedImagePrefetcher] prefetchURLs:urlsExceptFirst];
    }
}

- (void)reloadWithImageUrls:(NSArray *)imageUrls {
    NSArray *array = [self convertToNSURLArrayFrom:imageUrls];
    if (![self.urls isEqualToArray:array]) {
        self.urls = [array copy];
        
        [self prefetchImages];
        self.pageControl.numberOfPages = self.urls.count;
        self.pageControl.currentPage = 0;
        [self setCurrentPage:0 animated:NO];
        [self.collectionView reloadData];
        
        if (self.autoScroll) {
            [self invalidateTimer];
            [self setupTimer];
        }
    }
}

#pragma mark - Getters && Setters
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[XNLoopBannerViewCell class]
            forCellWithReuseIdentifier:CellIdentifier];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = 0;
    }
    return _flowLayout;
}

- (XXNoteView *)noteView{
    if(!_noteView){
        _noteView = [[XXNoteView alloc]initWithFrame:CGRectMake(20, 0, self.bounds.size.width/3, self.bounds.size.height) Inview:self];
    }
    return _noteView;
}

- (SMPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[SMPageControl alloc] init];
        _pageControl.hidesForSinglePage = YES;
        self.pageControlPace = 2;
        _pageControl.minHeight = 22;
    }
    return _pageControl;
}

- (void)setCurrentPage:(NSInteger)currentPage {
    [self setCurrentPage:currentPage animated:YES];
}

- (void)setShowNoteView:(BOOL)showNoteView{
    _showNoteView = showNoteView;
        self.noteView.hidden = !showNoteView;
}
- (void)setAutoScroll:(BOOL)autoScroll {
    _autoScroll = autoScroll;
    
    if (autoScroll) {
        [self invalidateTimer];
        [self setupTimer];
    } else {
        [self invalidateTimer];
    }
}

- (void)setAnimationDuration:(NSTimeInterval)animationDuration {
    _animationDuration = animationDuration;
    
    if (self.timer.timeInterval != animationDuration) {
        [self invalidateTimer];
        [self setupTimer];
    }
}

- (void)setPageControlPace:(float)pageControlPace{
    _pageControl.indicatorMargin = pageControlPace;
}

- (void)setPageControlFrame:(CGRect)pageControlFrame {
    _pageControlFrame = pageControlFrame;
    
    self.useCustomPageControlFrame = YES;
}

@end
