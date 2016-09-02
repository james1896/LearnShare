//
//  LoginViewController.m
//  Login
//
//  Created by James on 16/8/15.
//  Copyright © 2016年 james. All rights reserved.
//

#import "LoginViewController.h"
#import "M80AttributedLabel.h"
#import "RegisterViewController.h"

#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface LoginViewController ()<M80AttributedLabelDelegate>
@property(nonatomic,strong) UITextField *userField;
@property(nonatomic,strong) UITextField *pwdField;

@end

@implementation LoginViewController{
    M80AttributedLabel *promptLab;
}

#pragma mark -- left cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleInfo = @"用户登录";
    
    //textfield
    self.userField = [UITextField new];
    self.userField.placeholder = @"User name";
//    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:@"User name"];
//    [placeholder addAttribute:NSForegroundColorAttributeName
//                       value:[UIColor redColor]
//                       range:NSMakeRange(0, @"User name".length)];
//    [placeholder addAttribute:NSFontAttributeName
//                       value:[UIFont fontNamesForFamilyName:THEME_FONT_STRING]
//                       range:NSMakeRange(0, @"User name".length)];
//    self.userField.attributedPlaceholder = placeholder;
    
   
    self.userField.textAlignment = NSTextAlignmentCenter;
 
    
    self.pwdField = [UITextField new];
    self.pwdField.placeholder = @"Password";
  
    [self.pwdField setSecureTextEntry:YES];
    self.pwdField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: [self createFormWithTextField:self.userField atIndex:0]];
    [self.view addSubview: [self createFormWithTextField:self.pwdField atIndex:1]];
    
    
    //important
    NSString *text =@"1.Click the icon to fire event\n2.Click the icon to fire event\n3.您还没有账号?   请注册\n";
    promptLab = [M80AttributedLabel new];
    promptLab.textColor = THEME_PLACEHOLDER_FONT_COLOR;
    promptLab.lineSpacing = 5;
    promptLab.textAlignment = kCTTextAlignmentCenter;
    promptLab.font = [UIFont fontWithName:THEME_FONT_STRING size:13];
    promptLab.text = text;
    
    NSRange range   = [text rangeOfString:@"请注册"];
    [promptLab addCustomLink:[NSValue valueWithRange:range]
                    forRange:range];
    promptLab.delegate = self;
    [self.view addSubview:promptLab];
    
    [promptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdField.mas_bottom).offset(80);
        make.left.equalTo(self.pwdField.mas_left);
        make.width.mas_equalTo(self.pwdField.mas_width);
        
        make.bottom.equalTo(self.bottom_button_top);
    }];
    
    [self addBottomButtonTarget:self action:@selector(loginButtonPress:)];
}

- (void)loginButtonPress:(UIButton *)sender {

}

#pragma mark -- M80AttributedLabelDelegate
- (void)m80AttributedLabel:(M80AttributedLabel *)label
             clickedOnLink:(id)linkData
{
    RegisterViewController *registerController  = [[RegisterViewController alloc]init];
    registerController.dismissController = self;
    [self presentViewController:registerController animated:YES completion:nil];

}

//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    
//    if([textField.text isEqualToString:@""]  || textField.text == nil){
//        if(textField == self.userField){
//            self.userField.placeholder = @"user name";
//        }else if (textField == self.pwdField){
//            self.pwdField.placeholder = @"Password";
//        }
//        
//    }
//}


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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
