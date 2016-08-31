//
//  LearnViewController.m
//  LearnShare
//
//  Created by James on 16/8/28.
//  Copyright © 2016年 james. All rights reserved.
//

#import "LearnViewController.h"

#import "XNLoopBannerView.h"
#import "XXCollectionViewCell.h"
#import "LearnCollectionReusableView.h"

//29 169 252
@interface LearnViewController ()<XNLoopBannerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)  XNLoopBannerView *bannerView;

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@end

@implementation LearnViewController

#pragma mark -- lift cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CAGradientLayer *)shadowAsInverse
{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    CGRect newShadowFrame = CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height);
    newShadow.frame = newShadowFrame;
    //添加渐变的颜色组合（颜色透明度的改变）
    newShadow.colors = [NSArray arrayWithObjects:
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:0] CGColor] ,
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor],
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor],
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor],
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:0.4] CGColor],
                        (id)[[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor],
                        nil];
    
    newShadow.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.3],
                           [NSNumber numberWithFloat:0.8],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    newShadow.startPoint = CGPointMake(1, 0);
    newShadow.endPoint = CGPointMake(0, 1);
    return newShadow;
}

#pragma mark -- XNLoopBannerViewDelegate

- (void)bannerViewReadButtonPress:(UIButton *)sender{
    NSLog(@"read more");
}

- (void)bannerView:(XNLoopBannerView *)bannerView didSelectAtIndex:(NSInteger)index{
    NSLog(@"index:%d",index);
}
#pragma mark -- http

- (void)updateViewData{
    self.bannerView.imageUrls = @[@"http://www.feizl.com/upload2007/2012_04/120414144943121.jpg",
                                 @"http://img2.3lian.com/2014/f2/124/d/53.jpg",
                                 @"http://img.bimg.126.net/photo/vTj1tKBi8UViyJye0EyMYw==/5785155196335487580.jpg",
                                 @"http://cnm.szdwyy.com/uploads/allimg/140107/24-14010G63AX29.png"];
}
#pragma mark -- collectionVeiw

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return self.bannerView.bounds.size;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    //从缓存中获取 Headercell
    LearnCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"bannnerView" forIndexPath:indexPath];
    [headerView addSubview:self.bannerView];
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark -- 懒加载
-(UICollectionViewLayout *)flowLayout{
    
    int linePace = 20;
    int sectionPace = 16;
    if(!_flowLayout){
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.minimumInteritemSpacing = 10;
        _flowLayout.minimumLineSpacing = linePace;
        
        _flowLayout.sectionInset = UIEdgeInsetsMake(sectionPace, sectionPace, sectionPace, sectionPace); //设置section的边距
        _flowLayout.itemSize = CGSizeMake(self.collectionView.bounds.size.width/2-sectionPace-linePace/2, 180);
    }
    return _flowLayout;
}

-(UICollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT-NAVBAR_HEIGHT-STATUSBAR_HEIGHT) collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"XXCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CELL_IDENTIFIER];
        [_collectionView registerClass:[LearnCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"bannnerView"];
        
        //设置背景logo
//        _collectionView.backgroundView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tab_icon_learn_pressed.png"]];
    }
    return _collectionView;
}

- (XNLoopBannerView *)bannerView{
    if(!_bannerView){
        _bannerView = [[XNLoopBannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180) imageUrls:
                                                                                                                        @[@"http://www.feizl.com/upload2007/2012_04/120414144943121.jpg",
                                                                                                                            @"http://img2.3lian.com/2014/f2/124/d/53.jpg",
                                                                                                                            @"http://img.bimg.126.net/photo/vTj1tKBi8UViyJye0EyMYw==/5785155196335487580.jpg",
                                                                                                                            @"http://cnm.szdwyy.com/uploads/allimg/140107/24-14010G63AX29.png"]];
        _bannerView.animationDuration = 5;
        _bannerView.bannerDelegate = self;
          //    bannerView.placeholderImage
    }
    return _bannerView;
}

@end
