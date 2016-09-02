//
//  LoginAndRegisterViewController.m
//  LearnShare
//
//  Created by James on 16/9/2.
//  Copyright © 2016年 james. All rights reserved.
//

#import "LoginAndRegisterViewController.h"

@interface LoginAndRegisterViewController ()

@end

@implementation LoginAndRegisterViewController{
    UILabel *titleLab;
    UIButton *button;
    UIButton *returnButon;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.draw_offset_y = 120;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textfieldsDidChangeEditing:) name:UITextFieldTextDidChangeNotification object:nil];
    
    
    [self creatTopAndBottmView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:FALSE];
}

- (void)setTitleInfo:(NSString *)titleInfo{
    titleLab.text = titleInfo;
}

- (void)setButtonTitle:(NSString *)buttonTitle{
    [button setTitle:buttonTitle forState:UIControlStateNormal];
}

#pragma mark-- button Action
- (void)returnButtonPress:(UIButton *)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark-- notification
- (void)textfieldsDidChangeEditing:(NSNotification*)notification{
    UITextField *textField = notification.object;
    
    //有空格
    //如果用户输入空格 自动屏蔽掉
    //这里可以提示用户
    NSRange range = [textField.text rangeOfString:@" "];
    if(range.location !=NSNotFound){
        
        textField.text = [textField.text substringToIndex:range.location];
    }
    
    //如果用户输入字数超限
    if(textField.text.length >15){
        NSLog(@"您输入的字数超出限制");
        textField.text = [textField.text substringToIndex:textField.text.length-1];
    }
}

#pragma mark-- UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.placeholder = @"";
    
}

#pragma mark -- add view
- (void)tapView:(UITapGestureRecognizer *)gesture{
//    if(self.userField.isFirstResponder){
//        [self.userField resignFirstResponder];
//    } else if (self.pwdField.isFirstResponder){
//        [self.pwdField resignFirstResponder];
//    }
    [self.view endEditing:YES];
}

- (void)creatTopAndBottmView {
    
    //return button
    returnButon = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButon setImage:[UIImage imageNamed:@"return_left_black"] forState:UIControlStateNormal];
    [returnButon addTarget:self action:@selector(returnButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnButon];
    
    [returnButon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(10);
        make.width.height.mas_equalTo(25);
    }];
    
    
    //title
    titleLab = [UILabel new];
    titleLab.text = @"User Info";
    titleLab.font = [UIFont fontWithName:THEME_FONT_STRING size:21];
    [self.view addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(returnButon.mas_centerY);
        make.centerX.equalTo(titleLab.superview);
    }];
    
    
    //
    button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = THEME_BACKGROUND_COLOR;
    [button setTitle:@"Get started" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:THEME_FONT_STRING size:22];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(button.superview);
        make.bottom.equalTo(button.superview.mas_bottom);
        make.height.mas_equalTo(60);
    
        //对外公开
        self.bottom_button_top = button.mas_top;
    }];
}

- (void)addBottomButtonTarget:(id)target action:(SEL)action{

    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)addReturnButtonTarget:(id)target action:(SEL)action{
    [returnButon addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}


- (UIView *)createFormWithTextField:(UITextField *)textField atIndex:(NSInteger)index{
    
    //添加 背景view
    UIView *groundView = [UIView new];
    int form = 60;
    [self.view addSubview:groundView];
    [groundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(groundView.superview).offset(-self.draw_offset_y + index*form);
        make.centerX.equalTo(groundView.superview);
        
        make.width.mas_equalTo(SCREEN_WIDTH- 30*2);
        make.height.mas_equalTo(form);
    }];
    
    
    //添加底线
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
    [groundView addSubview:lineView];
//
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineView.superview);
        make.bottom.equalTo(lineView.superview.mas_bottom);
        make.height.mas_equalTo(1);
    }];
//
//
    //添加textfield
     textField.tintColor= [UIColor lightGrayColor];//设置光标颜色
    [groundView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineView.mas_top);
        make.left.equalTo(textField.superview).offset(20);
        make.right.equalTo(textField.superview).offset(-20);
        make.height.mas_equalTo(30);
    }];
    return groundView;
}

@end
