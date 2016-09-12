//
//  ChatToolBarView.m
//  ChatToolBarView
//
//  Created by James on 16/9/9.
//  Copyright © 2016年 james. All rights reserved.
//

#import "ChatToolBarView.h"

//屏幕尺寸


#define emotionDownFrame CGRectMake(0, screenH, screenW, 0)
#define emotionUpFrame CGRectMake(0, screenH - (EMOJI_KEYBOARD_HEIGHT), screenW, EMOJI_KEYBOARD_HEIGHT)

@interface ChatToolBarView()<LiuqsEmotionViewdelegate,UITextViewDelegate>{
    CGFloat toolbar_height;
    BOOL is_keyboard_show;
    CGFloat height;
}

@property(nonatomic) BOOL isEmotionViewShow;

//
@property(nonatomic,strong) UIView *toolBarView;

//toolbar上的 输入框
@property(nonatomic,strong) UITextView *toolBarTextView;


//toolbar上的 表情和键盘切换按钮
@property(nonatomic,strong) UIButton *toolBarEmotionBtn;


//表情键盘
@property(nonatomic,strong)LiuqsEmotionView *emotionView;

//delegate
@property(nonatomic,weak) UIViewController<ChatToolBarViewDelegate> *delegate;

@end

@implementation ChatToolBarView


#pragma mark-- textViewDelegate

#warning 需要修改
//解决textView 输入文字过多  换行  问题
-(void)textViewDidChange:(UITextView *)textView
{
    //
    if (self.toolBarTextView.contentSize.height <= TextViewH) {
        self.toolBarTextView.height = TextViewH;
    }else if (self.toolBarTextView.contentSize.height >= 90)
    {
        self.toolBarTextView.height = 90;
    }else
    {
        self.toolBarTextView.height = self.toolBarTextView.contentSize.height;
    }
    
    self.toolBarView.height = screenW * 10 / 320 + self.toolBarTextView.height;
    
    
//    if (self.keyBoardH < self.emotionview.height) {
//        
//        self.toolBarView.y = screenH - self.toolBarView.height - self.emotionview.height;
//    }else
//    {
//        self.toolBarView.y = screenH - self.toolBarView.height - self.keyBoardH;
//    }
//    if (textView.text.length > 0) {
//        self.emotionview.sendBtn.selected = YES;
//    }else
//    {
//        self.emotionview.sendBtn.selected = NO;
//    }
}
//如果不需要使用回车键，可以用这个方法掉用 发送button
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    //storage  用于textView的富文本显示
    NSLog(@"input text is :%@",text);
    if ([text isEqualToString:@"\n"]) {
        NSString *messageText = [[textView.textStorage getPlainString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [self sendMessageWithText:messageText];
        return NO;
    }
    return YES;
}

#pragma mark -- LiuqsEmotionViewdelegate
///发送文本消息
-(void)sendMessageWithText:(NSString *)text
{
    //text为空时
    if (text.length == 0) {
        
        //了解一下编码格式
        text = @"[吐舌]  彩笔，怎么可以输入空格呢？[抓狂]";
    }
    NSLog(@"sendMessageWithText:%@",text);
//    LiuqsCellFrame *model = [self creatNormalMessageWithText:text];
//    [self.dataSourceArray addObject:model];
    self.toolBarTextView.text = nil;
    [self textViewDidChange:self.toolBarTextView];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSourceArray.count - 1 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void)emotionView_sBtnDidClick:(UIButton *)btn{
    //3456 是 发送按钮 ，否则是直接点表情
    if (btn.tag == 3456) {
        //解析处理
        NSString *messageText = [[self.toolBarTextView.textStorage getPlainString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        //发送按钮事件
        [self sendMessageWithText:messageText];
    }else{
        
    
//        [self textViewDidChange:self.toolBarTextView];
        //判断输入框有内容让发送按钮变颜色
        if (self.emotionView.IputView.text.length > 0) {
            self.emotionView.sendBtn.selected = YES;
        }else
        {
            self.emotionView.sendBtn.selected = NO;
        }
    }

}

-(void)gifBtnClick:(UIButton *)btn{
    
}

#pragma mark -- 懒加载


//懒加载创建表情键盘
-(LiuqsEmotionView *)emotionView
{
    if (!_emotionView) {
        _emotionView = [[LiuqsEmotionView alloc]initWithFrame:emotionDownFrame];
        _emotionView.IputView = self.toolBarTextView;
        _emotionView.delegate = self;
        //把表情键盘添加在 delegate 的View上
        if(self.delegate){
            [self.delegate.view addSubview:_emotionView];
        }
        
    }
    return _emotionView;
}

- (UIView *)toolBarView{
    if(!_toolBarView){
        _toolBarView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-STATUSBAR_HEIGHT-NAVBAR_HEIGHT-50, self.bounds.size.width, 50)];
        _toolBarView.backgroundColor = [UIColor yellowColor];
        
        //textView
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 5, TextViewW, TextViewH)];
        self.toolBarTextView = textView;
        textView.backgroundColor = [UIColor whiteColor];
        textView.returnKeyType = UIReturnKeySend;
        textView.layer.cornerRadius = 8;
        textView.font = [UIFont systemFontOfSize:15];
        textView.layer.borderWidth = 0.5f;
        textView.scrollEnabled = YES;
        textView.delegate = self;
        [self.toolBarTextView scrollRangeToVisible:NSMakeRange(self.toolBarTextView.text.length, 1)];
        textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [_toolBarView addSubview:textView];
        
        UIButton *emotionBtn = [[UIButton alloc]initWithFrame:CGRectMake(emotionBtnX, 5, emotionBtnW, emotionBtnH)];
        self.toolBarEmotionBtn = emotionBtn;
        [emotionBtn setImage:[UIImage imageNamed:@"emotionBtn_no"] forState:UIControlStateNormal];
        [emotionBtn setImage:[UIImage imageNamed:@"emotionBtn_se"] forState:UIControlStateSelected];
        [emotionBtn addTarget:self action:@selector(emotionBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_toolBarView addSubview:emotionBtn];
        
        //

    }
    return _toolBarView;
}

#pragma mark -- button action

- (void)emotionBtnDidClicked:(UIButton *)sender {
    
    
    if(sender.selected){
        [self.toolBarTextView becomeFirstResponder];
        is_keyboard_show = YES;
    }else{
        [UIView animateWithDuration:emotionTipTime animations:^{
            if(is_keyboard_show){
                is_keyboard_show = NO;
                [self hiddenKeyboard];
                [self showEmotionView];
            }else{
                [self showEmotionView];
            }
            self.toolBarView.frame = CGRectMake(0, toolbar_height, screenW, 50);
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

#pragma mark -- lift cycle
+(instancetype)createChatToolBarViewWithDelegate:(UIViewController<ChatToolBarViewDelegate> *)delegate{
    
    ChatToolBarView *chatToolVarView =[[ChatToolBarView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    chatToolVarView.delegate = delegate;
    return chatToolVarView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        
          [self addSubview:self.toolBarView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapChatToolView:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapChatToolView:(UITapGestureRecognizer *)gesture{

    [self hiddenChatToolBarView];
}

#pragma mark -- textView代理方法
-(void)textViewDidBeginEditing:(UITextView *)textView{
    //    [UIView animateWithDuration:emotionTipTime animations:^{
    //        [self showEmotionView];
    //        self.toolBarEmotionBtn.selected = NO;
    //        self.toolBarView.frame = CGRectMake(0, toolbar_height, screenW, 50);
    //    } completion:^(BOOL finished) {
    //
    //    }];
    
}

#pragma mark -- notifications
- (void)addChatToolBarViewNotifications{
    
    // 键盘frame将要改变就会接受到通知
    //    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //键盘出现时掉用
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    // 键盘将要收起时候发出通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeChatToolBarVIewnotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)noti{
    CGRect keyBoardFrame = [[(NSDictionary *)noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    toolbar_height = screenH-50- keyBoardFrame.size.height;
    is_keyboard_show = YES;
    self.toolBarEmotionBtn.selected = NO;
    
    [UIView animateWithDuration:emotionTipTime animations:^{
        self.toolBarView.frame = CGRectMake(0, toolbar_height, screenW, 50);
    } completion:^(BOOL finished) {
        
    }];
    
}

//键盘弹回
-(void)keyboardWillHide:(NSNotification *)noti
{
    [UIView animateWithDuration:emotionTipTime animations:^{
        [self hiddenKeyboard];
        self.toolBarView.frame = CGRectMake(0, toolbar_height, screenW, 50);
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)hiddenEmotionView{
    self.toolBarEmotionBtn.selected = NO;
    self.emotionView.frame = emotionDownFrame;
    toolbar_height = screenH-50;
    is_keyboard_show = NO;
}

- (void)showEmotionView{
    self.toolBarEmotionBtn.selected = YES;
    is_keyboard_show = NO;
    self.emotionView.frame = emotionUpFrame;
    toolbar_height = screenH-50-emotionUpFrame.size.height;
}

- (void)hiddenKeyboard{
    [self.toolBarTextView resignFirstResponder];
    toolbar_height = screenH-50;
}

//
- (void)showChatToolBarView{
    self.hidden = NO;
    [self.delegate.view addSubview:self];
    [self.delegate.view bringSubviewToFront:self];
    
    [self.toolBarTextView becomeFirstResponder];
}

-(void)hiddenChatToolBarView{
    
    is_keyboard_show = NO;
    [UIView animateWithDuration:emotionTipTime animations:^{
        [self hiddenEmotionView];
        [self hiddenKeyboard];
        self.toolBarView.frame = CGRectMake(0, toolbar_height, screenW, 50);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
}


@end
