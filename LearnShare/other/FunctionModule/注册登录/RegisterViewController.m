//
//  RegisterViewController.m
//  LearnShare
//
//  Created by James on 16/9/2.
//  Copyright © 2016年 james. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property(nonatomic,strong) UITextField *userField;
@property(nonatomic,strong) UITextField *emailField;
@property(nonatomic,strong) UITextField *pwdField;
@property(nonatomic,strong) UITextField *confirmPwdField;
@end

@implementation RegisterViewController{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleInfo = @"用户注册";
    
    self.userField = [self createTextField];
    self.userField.placeholder = @"User name";
    self.emailField = [self createTextField];
    self.emailField.placeholder = @"Your name@Gmail.com";
    self.pwdField = [self createTextField];
    self.pwdField.placeholder = @"Password";
    self.confirmPwdField = [self createTextField];
    self.confirmPwdField.placeholder = @"Password Again";
    
    
    self.draw_offset_y = 150;
   [self.view addSubview: [self createFormWithTextField:self.userField atIndex:0]];
    [self.view addSubview:[self createFormWithTextField:self.emailField atIndex:1]];
    [self.view addSubview:[self createFormWithTextField:self.pwdField atIndex:2]];
    [self.view addSubview:[self createFormWithTextField:self.confirmPwdField atIndex:3]];
    
    
    [self addReturnButtonTarget:self action:@selector(returnButtonPress:)];
    [self addBottomButtonTarget:self action:@selector(registerButtonPress:)];

}

- (UITextField *)createTextField{
    UITextField *field = [UITextField new];
    field.textAlignment = NSTextAlignmentCenter;
    return field;
}
- (void)registerButtonPress:(UIButton *)sender {
    
//    self.dismissController.view.hidden = YES;
    
    
#warning 模态呈现方式
    // A呈现B    B呈现C   C直接返回到A
    //但是感觉这样做还是不好  应该还有更好的方法实现
    [self.dismissController dismissViewControllerAnimated:NO completion:nil];
    
    [self returnButtonPress:sender];
}

- (void)returnButtonPress:(UIButton *)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
