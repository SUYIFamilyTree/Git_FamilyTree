//
//  LoginViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/25.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "LoginViewController.h"

#import "ToRegistView.h"
#import "LoginModel.h"

#define ReGistView_height 180
#define AnimationsTime 0.4f
@interface LoginViewController ()<LoginViewDelegate,ToRegisViewDelegate>

@property (nonatomic,strong) LoginView *loginView; /*登录界面*/

@property (nonatomic,strong) ToRegistView *regisView; /*注册view*/


@end

@implementation LoginViewController
#pragma mark *** lifeCircle ***
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self.view addSubview:self.loginView];
    //如果登录
    if ([[USERDEFAULT objectForKey:LoginStates] isEqual:@true]) {
//        [self loginView:nil didSelectedTourBtn:nil];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark *** ToRegisterViewDelegate ***
//点击获取验证码
-(void)ToRegisViewDidSelectedVerfication:(ToRegistView *)registView{
    MYLog(@"获取验证码");
}

//点击立即注册

-(void)ToRegisViewDidSelectedRegistBtn:(ToRegistView *)registView{
    MYLog(@"立即注册");
}

#pragma mark *** LoginViewDelegate ***
//选中上端菜单
-(void)loginView:(LoginView *)loginView didSelectedTopViewBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
            //返回按钮
            NSLog(@"返回按钮");
            break;
        case 1:
        {
            //注册（待用方法）
//            RegisViewController *regisVc = [RegisViewController new];
//            [self.navigationController pushViewController:regisVc animated:YES];
            
            [self.loginView.topView.regisBtn.titleLabel.text isEqualToString:@"注册"]?[self.loginView.topView.regisBtn setTitle:@"登录" forState:0]:[self.loginView.topView.regisBtn setTitle:@"注册" forState:0];
           
            
            [self.view addSubview:self.regisView];
            
            
            [UIView animateWithDuration:AnimationsTime animations:^{
                
                if (IsEquallString(self.loginView.topView.regisBtn.titleLabel.text, @"登录")) {
                    //移到屏幕外
                    self.loginView.accountView.center = CGPointMake(-250, self.loginView.accountView.center.y);
                    self.loginView.passwordView.center = CGPointMake(-250, self.loginView.passwordView.center.y);
                    self.loginView.accountView.alpha = 0;
                    self.loginView.passwordView.alpha = 0;
                    
                    //移到屏幕内
                    self.regisView.frame = CGRectMake(self.view.center.x-_regisView.bounds.size.width/2, CGRectGetMinY(self.loginView.accountView.frame), 0.8*Screen_width,ReGistView_height);
                    self.regisView.alpha = 1.0;
                    
                }else{
                    
                //移到屏幕内
                self.loginView.accountView.center = CGPointMake(self.view.center.x, self.loginView.accountView.center.y);
                self.loginView.passwordView.center = CGPointMake(self.view.center.x, self.loginView.passwordView.center.y);
                self.loginView.accountView.alpha = 1;
                self.loginView.passwordView.alpha = 1;
                //移到屏幕外
                self.regisView.frame = CGRectMake(700, CGRectGetMinY(self.loginView.accountView.frame), 0.8*Screen_width, ReGistView_height);
                self.regisView.alpha = 0;
                    
                }
            } completion:^(BOOL finished) {
                
                //移除之前的按钮
//                [self.loginView.accountView removeFromSuperview];
//                [self.loginView.passwordView removeFromSuperview];
                

            }];
            
        }
            
            break;
        case 2:
        {
            //找回密码
            FindPassViewController *finPassVc = [FindPassViewController new];
            [self.navigationController pushViewController:finPassVc animated:YES];
            
        }
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
    MYLog(@"登录");
    
    NSDictionary *logDic = @{@"user":self.loginView.accountView.inputTextView.text,@"pass":self.loginView.passwordView.inputTextView.text};
    
    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:@0 requestcode:@"login" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            //登录成功
            NSDictionary *dic = [NSDictionary DicWithString:jsonDic[@"data"]];
            NSLog(@"%@", dic);
            
            [LoginModel sharedLoginMode].MeAreacodeid = dic[@"MeAreacodeid"];
            //存储用户信息
            [USERDEFAULT setObject:@true forKey:LoginStates];
            [USERDEFAULT setObject:self.loginView.accountView.inputTextView.text forKey:UserId];
            [USERDEFAULT setObject:self.loginView.passwordView.inputTextView.text forKey:Password];
            
            [self loginView:nil didSelectedTourBtn:nil];
            
        }
        
    } failure:^(NSError *error) {
        MYLog(@"失败");
    }];
    
    
}
//游客按钮
-(void)loginView:(LoginView *)loginView didSelectedTourBtn:(UIButton *)sender{
    NSLog(@"游客请进！");
    RootTabBarViewController *tabBar = [[RootTabBarViewController alloc] init];
    [self.navigationController pushViewController:tabBar animated:YES];
}

#pragma mark *** touch ***
//收起键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark *** getters ***
-(LoginView *)loginView{
    if (!_loginView) {
        _loginView = [[LoginView alloc] initWithFrame:self.view.bounds];
        _loginView.delegate = self;
        
        _loginView.accountView.placeholder.text = @"用   户   名";
        _loginView.passwordView.placeholder.text = @"";
        
        if ([USERDEFAULT objectForKey:UserId]&&[USERDEFAULT objectForKey:Password]) {
            _loginView.accountView.inputTextView.text = [USERDEFAULT objectForKey:UserId];
            _loginView.passwordView.inputTextView.text = [USERDEFAULT objectForKey:Password];
            _loginView.accountView.placeholder.hidden = YES;
        }
        
    }
    return _loginView;
}
-(ToRegistView *)regisView{
    if (!_regisView) {
        _regisView = [[ToRegistView  alloc] initWithFrame:CGRectMake(0, 0, 0.8*Screen_width, ReGistView_height)];
//        _regisView.bounds = CGRectMake(0, 0, 0.8*Screen_width, 150);
        _regisView.center = CGPointMake(700, CGRectGetMinY(self.loginView.accountView.frame)+ReGistView_height/2);
        _regisView.alpha = 0;
        _regisView.delegate = self;
        
    }
    return _regisView;
}
@end
