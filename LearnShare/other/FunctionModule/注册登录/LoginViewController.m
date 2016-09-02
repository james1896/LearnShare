//
//  LoginViewController.m
//  Login
//
//  Created by James on 16/8/15.
//  Copyright © 2016年 james. All rights reserved.
//

#import "LoginViewController.h"
#import "Masonry.h"
#import "CommonHeader.h"

#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface LoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) UITextField *userField;
@property(nonatomic,strong) UITextField *pwdField;

@end

@implementation LoginViewController


#pragma mark -- left cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    
    [self creatNavigationView];
    [self createLoginView];
    
    //    [self addView];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
      [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:FALSE];
}

- (void)returnButtonPress:(UIButton *)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

#pragma mark-- UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.placeholder = @"";
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if([textField.text isEqualToString:@""]  || textField.text == nil){
        if(textField == self.userField){
            self.userField.placeholder = @"Username";
        }else if (textField == self.pwdField){
            self.pwdField.placeholder = @"Password";
        }
        
    }
}
#pragma mark -- add view
- (void)tapView:(UITapGestureRecognizer *)gesture{
    if(self.userField.isFirstResponder){
        [self.userField resignFirstResponder];
    } else if (self.pwdField.isFirstResponder){
        [self.pwdField resignFirstResponder];
    }
}

- (void)creatNavigationView {
    
    //return button
    UIButton *returnButon = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButon setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [returnButon addTarget:self action:@selector(returnButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnButon];
    
    [returnButon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(10);
        make.width.height.mas_equalTo(25);
    }];
    
    
    //title
    UILabel *titleLab = [UILabel new];
    titleLab.text = @"用户登录";
    titleLab.font = [UIFont fontWithName:THEME_FONT_STRING size:20];
    [self.view addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(returnButon.mas_centerY);
        make.centerX.equalTo(titleLab.superview);
    }];
    
    
    //
    UIButton *loginButton =[UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor = THEME_BACKGROUND_COLOR;
    [loginButton setTitle:@"Get started" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:THEME_FONT_STRING size:22];
    [self.view addSubview:loginButton];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(loginButton.superview);
        make.bottom.equalTo(loginButton.superview.mas_bottom);
        make.height.mas_equalTo(60);
    }];
}

- (void)createLoginView {
    
    UIView *loginGroundView = [UIView new];
    [self.view addSubview:loginGroundView];
    [loginGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(loginGroundView.superview).offset(-80);
        make.centerX.equalTo(loginGroundView.superview);
        
        make.width.mas_equalTo(SCREEN_WIDTH- 30*2);
        make.height.mas_equalTo(120);
    }];
    
    //line
    UIView *lineView_moddle = [UIView new];
    lineView_moddle.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
    [loginGroundView addSubview:lineView_moddle];
    UIView *lineView_bottom = [UIView new];
    lineView_bottom.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
    [loginGroundView addSubview:lineView_bottom];
    
    [lineView_moddle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineView_moddle.superview);
        make.centerY.equalTo(lineView_moddle.superview);
        make.height.mas_equalTo(1);
    }];
    [lineView_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineView_bottom.superview);
        make.bottom.equalTo(lineView_bottom.superview.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    
    //textfield
    self.userField = [UITextField new];
    self.userField.placeholder = @"User name";
    self.userField.delegate = self;
    self.userField.textAlignment = NSTextAlignmentCenter;
    self.userField.font = [UIFont systemFontOfSize:20];
    
    self.pwdField = [UITextField new];
    self.pwdField.placeholder = @"Password";
    self.pwdField.delegate = self;
    self.pwdField.textAlignment = NSTextAlignmentCenter;
    [loginGroundView addSubview:self.userField];
    [loginGroundView addSubview:self.pwdField];
    
    int pace = 20;
    [self.userField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineView_moddle.mas_top);
        make.left.equalTo(self.userField.superview).offset(pace);
        make.right.equalTo(self.userField.superview).offset(-pace);
        make.height.mas_equalTo(30);
    }];
    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pwdField.superview).offset(pace);
        make.right.equalTo(self.pwdField.superview).offset(-pace);
        make.bottom.equalTo(self.pwdField.superview.mas_bottom);
        make.height.mas_equalTo(30);
    }];
}

//- (void)addView{
//
//    UIView *groundView = [UIView new];
//    groundView.layer.cornerRadius = 4;
//    groundView.layer.shadowColor = RGB(11, 1, 1, 1).CGColor;
//    groundView.backgroundColor = RGB(58, 110, 211,1);
//
//    [[groundView layer] setShadowOffset:CGSizeMake(0.3, 0.3)];
//    [[groundView layer] setShadowOpacity:0.7];
//    [[groundView layer] setShadowColor:[UIColor blackColor].CGColor];
//
//    self.userField = [UITextField new];
//    self.pwdField = [UITextField new];
//
//    self.userField.backgroundColor = [UIColor greenColor];
//    self.pwdField.backgroundColor = [UIColor greenColor];
//
//    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [loginBtn setTitle:@"Login" forState:UIControlStateNormal];
//    [loginBtn setBackgroundColor:RGB(36, 167, 219, 1)];
//    [groundView addSubview:loginBtn];
//
//    UIImageView *userImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sms.png"]];
//    UIImageView *pwdImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"safari.png"]];
//    UIView *lineView = [UIView new];
//    lineView.backgroundColor = RGB(87,133,230,1);
//
//    [groundView addSubview:self.userField];
//    [groundView addSubview:self.pwdField];
//    [groundView addSubview:userImg];
//    [groundView addSubview:pwdImg];
//    [groundView addSubview:lineView];
//    [groundView addSubview:loginBtn];
//    [self.view addSubview:groundView];
//
//
//    //
//    [groundView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.left.equalTo(self.view).offset(30);
//        make.right.equalTo(self.view).offset(-30);
//        make.height.mas_equalTo(150);
//    }];
//
//    [userImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.equalTo(groundView).offset(15);
//        make.width.mas_equalTo(25);
//        make.height.mas_equalTo(20);
//    }];
//
//    [self.userField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(userImg.mas_right).offset(20);
//        make.right.equalTo(self.userField.superview).offset(-15);
//        make.centerY.equalTo(userImg.mas_centerY);
//    }];
//
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(1);
//        make.right.left.equalTo(groundView).offset(0);
//        make.top.equalTo(userImg.mas_bottom).offset(20);
//    }];
//
//
//    [pwdImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.equalTo(userImg);
//        make.top.equalTo(lineView.mas_bottom).offset(20);
//        make.left.equalTo(pwdImg.superview).offset(15);
//    }];
//
//    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(pwdImg.mas_right).offset(20);
//        make.right.equalTo(self.pwdField.superview).offset(-15);
//        make.centerY.equalTo(pwdImg);
//
//    }];
//
//    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(loginBtn.superview.mas_bottom).offset(0);
//        make.left.right.equalTo(loginBtn.superview).offset(0);
//        make.height.mas_equalTo(35);
//    }];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
