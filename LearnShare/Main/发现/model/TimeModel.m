//
//  TimeModel.m
//  TimeLine
//
//  Created by oujinlong on 16/6/12.
//  Copyright © 2016年 oujinlong. All rights reserved.
//

#import "TimeModel.h"
extern CGFloat max_content_height;
@implementation TimeModel
+(NSArray*)models{
    
    NSArray* nameArray = @[@"Nick",@"Guardian",@"Mac",@"Alex",@"剑圣",@"Roushan",@"一个开发者",@"这就是个名字",@"呵呵",@"Start iOS"];
    
    NSArray* contentArray = @[@"iOS是由苹果公司开发的移动操作系统",
                              @"苹果公司最早于2007年1月9日的Macworld大会上公布这个系统，最初是设计给iPhone使用的，后来陆续套用到iPod touch、iPad以及Apple TV等产品上",
                              @"iOS与苹果的Mac OS X操作系统一样，属于类Unix的商业操作系统。原本这个系统名为iPhone OS，因为iPad，iPhone，iPod touch都使用iPhone OS，所以2010WWDC大会上宣布改名为iOS（iOS为美国Cisco公司网络设备操作系统注册商标，苹果改名已获得Cisco公司授权）",
                              @"2016年1月，随着9.2.1版本的发布，苹果修复了一个存在了3年的漏洞",
                              @"该漏洞在iPhone或iPad用户在酒店或者机场等访问带强制门户的网络时，登录页面会通过未加密的HTTP连接显示网络使用条款.苹果公司最早于2007年1月9日的Macworld大会上公布这个系统，最初是设计给iPhone使用的，后来陆续套用到iPod touch、iPad以及Apple TV等产品上",
                              @"在用户接受条款后，即可正常上网，但嵌入浏览器会将未加密的Cookie分享给Safari浏览器",
                              @"利用这种分享的资源，黑客可以创建自主的虚假强制门户，并将其关联至WiFi网络，从而窃取设备上保存的任何未加密Cookie"];
    
    NSArray <ContentImageModel*>* contentImageArray = [self getContentImageArray];
    
    NSArray* distanceArray = @[@123.5,@22.1,@666.6,@111.1,@653.2,@90.9,@110,@11,@80.80,@88.88];
    
    NSArray* timeArray = @[@"08:00",@"12:31",@"12:00",@"00:09",@"13:22",@"22:22",@"09:19",@"20:10"];
    
    NSArray* likeCountArray = @[@20,@10,@0,@100,@22,@33,@8];
    NSArray* commmentCountArray = @[@20,@10,@0,@100,@22,@33,@8];
    NSMutableArray* array = [NSMutableArray array];
    for (NSInteger i = 0 ; i < 10; i ++) {
        TimeModel* m1 = [[TimeModel alloc] init];
        m1.name = nameArray[arc4random_uniform(10)];
//        m1.icon = [NSString stringWithFormat:@"%zd.jpg",arc4random_uniform(23)];
         m1.icon = [NSString stringWithFormat:@"16.jpg"];
        m1.contentText = contentArray[arc4random_uniform(7)];
    
        NSInteger imageCount = arc4random_uniform(8);
        NSMutableArray* images = [NSMutableArray array];
        for (NSInteger i = 0;  i < imageCount; i++) {
            ContentImageModel* image = contentImageArray[arc4random_uniform(8)];
            [images addObject:image];
        }
        m1.imageArray = images;
        m1.distance = [distanceArray[arc4random_uniform(10)] floatValue];
        m1.time = timeArray[arc4random_uniform(8)];
        m1.isShowAll = NO;
        m1.likeCount = [likeCountArray[arc4random_uniform(7)] integerValue];
        m1.commentCount = [commmentCountArray[arc4random_uniform(7)] integerValue];
        [array addObject:m1];
    }
    
    return array;
}
+(NSArray <ContentImageModel*>*)getContentImageArray{
    ContentImageModel* m1 = [[ContentImageModel alloc] init];
    m1.imageUrl = @"http://ci.xiaohongshu.com/5ced9b2f-add3-415d-aefb-69f934cd5064@r_1280w_1280h.jpg";
    m1.width = 530;
    m1.height = 400;
    
    ContentImageModel* m2 = [[ContentImageModel alloc] init];
    m2.imageUrl = @"http://ci.xiaohongshu.com/71fd26cf-a1a9-46e4-8304-d5f35b8f8275@r_1280w_1280h.jpg";
    m2.width = 275;
    m2.height = 365;
    
    ContentImageModel* m3 = [[ContentImageModel alloc] init];
    m3.imageUrl = @"http://ci.xiaohongshu.com/dc32de1c-a3e9-4fa0-8eb1-fe9a996c3f03@r_1280w_1280h.jpg";
    m3.width = 530;
    m3.height = 530;
    
    ContentImageModel* m4 = [[ContentImageModel alloc] init];
    m4.imageUrl = @"http://ci.xiaohongshu.com/3e6f605a-4646-4998-ad8b-4ea1967ef0ef@r_1280w_1280h.jpg";
    m4.width = 270;
    m4.height = 360;
    
    ContentImageModel* m5 = [[ContentImageModel alloc] init];
    m5.imageUrl = @"http://ci.xiaohongshu.com/c808ecf0-b17b-4ee7-b46b-ba74b607e253@r_1280w_1280h.jpg";
    m5.width = 272;
    m5.height = 364;
    
    ContentImageModel* m6 = [[ContentImageModel alloc] init];
    m6.imageUrl = @"http://ci.xiaohongshu.com/e9a37097-13b0-4a72-9bb0-095aa46aa508@r_1280w_1280h.jpg";
    m6.width = 535;
    m6.height = 400;
    
    ContentImageModel* m7 = [[ContentImageModel alloc] init];
    m7.imageUrl = @"http://ci.xiaohongshu.com/ada719aa-8fc6-44c3-a010-3f1f7a155e23@r_1280w_1280h.jpg";
    m7.width = 533;
    m7.height = 533;
    
    ContentImageModel* m8 = [[ContentImageModel alloc] init];
    m8.imageUrl = @"http://ci.xiaohongshu.com/98d5d7f2-5035-4743-b900-b612e749d28b@r_1280w_1280h.jpg";
    m8.width = 526;
    m8.height = 687;
    return @[m1,m2,m3,m4,m5,m6,m7,m8];
}
-(BOOL)shouldShowAllButton{
    NSString* content = self.contentText;
    CGRect rect = [content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
    CGFloat textHeight = rect.size.height;
    BOOL isShow = (max_content_height > textHeight);
    return  isShow;
}
@end
@implementation ContentImageModel



@end