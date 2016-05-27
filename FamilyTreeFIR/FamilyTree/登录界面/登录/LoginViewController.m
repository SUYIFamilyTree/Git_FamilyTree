//
//  LoginViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/25.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RootTabBarViewController.h"
@interface LoginViewController ()<LoginViewDelegate>



@end

@implementation LoginViewController
#pragma mark *** lifeCircle ***
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    LoginView *view = [[LoginView alloc] initWithFrame:self.view.bounds];
    view.delegate = self;
    self.navigationController.navigationBarHidden = YES;
    
    [self.view addSubview:view];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark *** LoginViewDelegate ***
//选中上端菜单
-(void)loginView:(LoginView *)loginView didSelectedTopViewBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
            NSLog(@"返回按钮");
            break;
        case 1:
            NSLog(@"注册");
            break;
        case 2:
            NSLog(@"找回密码");
            break;
        default:
            break;
    }
}
//选中三方登录按钮
-(void)loginView:(LoginView *)loginView didSelectedOtherLoginBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
            NSLog(@"qq");
            break;
        case 1:
            NSLog(@"weixin");
            break;
        case 2:
            NSLog(@"weibo");
            break;
        default:
            break;
    }
}
//登录按钮
-(void)loginView:(LoginView *)loginView didSelectedLoginBtn:(UIButton *)sender{
    NSLog(@"登录！！");
}
//游客按钮
-(void)loginView:(LoginView *)loginView didSelectedTourBtn:(UIButton *)sender{
    NSLog(@"游客请进！");
    RootTabBarViewController *tabBar = [[RootTabBarViewController alloc] init];
    [self.navigationController pushViewController:tabBar animated:YES];
}
@end
