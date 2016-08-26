//
//  LoginViewController.m
//  Login
//
//  Created by James on 16/8/15.
//  Copyright © 2016年 james. All rights reserved.
//

#import "LoginViewController.h"
#import "Masonry.h"

#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface LoginViewController ()
@property(nonatomic,strong) UITextField *userField;
@property(nonatomic,strong) UITextField *pwdField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addView];
    // Do any additional setup after loading the view from its nib.
}


- (void)addView{
    
    UIView *groundView = [UIView new];
    groundView.layer.cornerRadius = 4;
    groundView.layer.shadowColor = RGB(11, 1, 1, 1).CGColor;
    groundView.backgroundColor = RGB(58, 110, 211,1);

    [[groundView layer] setShadowOffset:CGSizeMake(0.3, 0.3)];
    [[groundView layer] setShadowOpacity:0.7];
    [[groundView layer] setShadowColor:[UIColor blackColor].CGColor];
    
    self.userField = [UITextField new];
    self.pwdField = [UITextField new];
    
    self.userField.backgroundColor = [UIColor greenColor];
     self.pwdField.backgroundColor = [UIColor greenColor];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"Login" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:RGB(36, 167, 219, 1)];
    [groundView addSubview:loginBtn];
    
    UIImageView *userImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sms.png"]];
    UIImageView *pwdImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"safari.png"]];
    UIView *lineView = [UIView new];
    lineView.backgroundColor = RGB(87,133,230,1);
    
    [groundView addSubview:self.userField];
    [groundView addSubview:self.pwdField];
    [groundView addSubview:userImg];
    [groundView addSubview:pwdImg];
    [groundView addSubview:lineView];
    [groundView addSubview:loginBtn];
    [self.view addSubview:groundView];
    
    
    //
    [groundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.equalTo(self.view).offset(30);
         make.right.equalTo(self.view).offset(-30);
        make.height.mas_equalTo(150);
    }];
    
    [userImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(groundView).offset(15);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(20);
    }];
    
    [self.userField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userImg.mas_right).offset(20);
        make.right.equalTo(self.userField.superview).offset(-15);
        make.centerY.equalTo(userImg.mas_centerY);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.right.left.equalTo(groundView).offset(0);
        make.top.equalTo(userImg.mas_bottom).offset(20);
    }];
    
    
    [pwdImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(userImg);
        make.top.equalTo(lineView.mas_bottom).offset(20);
        make.left.equalTo(pwdImg.superview).offset(15);
    }];

    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pwdImg.mas_right).offset(20);
        make.right.equalTo(self.pwdField.superview).offset(-15);
        make.centerY.equalTo(pwdImg);
       
    }];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(loginBtn.superview.mas_bottom).offset(0);
        make.left.right.equalTo(loginBtn.superview).offset(0);
        make.height.mas_equalTo(35);
    }];
}

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
