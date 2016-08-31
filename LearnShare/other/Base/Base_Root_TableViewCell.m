//
//  Base_Root_TableViewCell.m
//  LearnShare
//
//  Created by James on 16/8/30.
//  Copyright © 2016年 james. All rights reserved.
//

#import "Base_Root_TableViewCell.h"
#import "Masonry.h"
#import "CommonHeader.h"

@implementation Base_Root_TableViewCell{
    UILabel *titleLabel;
    UILabel *prompTtitleLabel;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        //取消点击颜色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        int pace = 24;
        //init   titlelabel
        titleLabel = [UILabel new];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(pace);
            make.top.equalTo(self).offset(13);
//            make.bottom.equalTo(self).offset(-10);
        }];
        
        NSString *fonts =@"PingFangTC-Light";
        fonts =@"Courier New";
        fonts = @"GillSans-LightItalic";
        //    fonts = @"Chivo-Italic";
        titleLabel.textColor = THEME_FONT_COLOR;
        titleLabel.font =[UIFont fontWithName: fonts size:18];
        
        //        Share the happiness of his learning
        //init PromptTitleLabel
    
        prompTtitleLabel = [UILabel new];
        prompTtitleLabel.textColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1];
        prompTtitleLabel.font = [UIFont fontWithName:fonts size:12];
        [self addSubview:prompTtitleLabel];
        
        [prompTtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(pace);
            make.top.equalTo(titleLabel.mas_bottom).offset(3);
        }];
        
        //  init   --
        //        int width = 6;
        //        int pace = 10;
        //        for(int i=0;i<(SCREEN_WIDTH-pace*2)/width;i++){
        //            if(i%2){
        //                UIView *line = [UIView new];
        //                line.backgroundColor = THEME_PLACEHOLDER_FONT_COLOR;
        //                [self addSubview:line];
        //
        //                [line mas_makeConstraints:^(MASConstraintMaker *make) {
        //                    make.left.equalTo(self).offset(pace+width*i);
        //                    make.bottom.equalTo(self).offset(-1);
        //                    make.height.mas_equalTo(1);
        //                    make.width.mas_equalTo(width);
        //                }];
        //            }
        //        }
        UIView *line = [UIView new];
        line.backgroundColor = THEME_PLACEHOLDER_FONT_COLOR;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(pace);
            make.right.equalTo(self).offset(-pace);
            make.bottom.equalTo(self).offset(-1);
            make.height.mas_equalTo(1);
            
        }];
        
    }
    return self;
}


#pragma mark -- SET  GET方法

- (void)setPromptTitle:(NSString *)promptTitle{
    prompTtitleLabel.text = promptTitle;
}

- (void)setTitle:(NSString *)title{
    
    titleLabel.text = title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
