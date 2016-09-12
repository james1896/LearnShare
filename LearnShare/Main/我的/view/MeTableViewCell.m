//
//  MeTableViewCell.m
//  LearnShare
//
//  Created by James on 16/8/30.
//  Copyright © 2016年 james. All rights reserved.
//

#import "MeTableViewCell.h"
@implementation MeTableViewCell{
    UILabel *rightLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
     
    }
    
    return self;
}

- (void)setRightText:(NSString *)rightText{
    if(!rightLabel){
        rightLabel = [UILabel new];
        rightLabel.font = [UIFont systemFontOfSize:13.5];
        rightLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:0.8];
        [self addSubview:rightLabel];
        
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-40);
        }];
    }
    rightLabel.text = rightText;
}
@end
