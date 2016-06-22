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

#import "RechargeViewController.h"

#define ReGistView_height 180
#define AnimationsTime 0.4f
@interface LoginViewController ()<LoginViewDelegate,ToRegisViewDelegate>

@property (nonatomic,strong) LoginView *loginView; /*登录界面*/

@property (nonatomic,strong) ToRegistView *regisView; /*注册view*/

@property (nonatomic,strong) RootTabBarViewController *tabBarVc; /*标签控制器*/



@end

@implementation LoginViewController
#pragma mark *** lifeCircle ***
- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self.view addSubview:self.loginView];
    //如果登录
    if ([[USERDEFAULT objectForKey:LoginStates] isEqual:@true]) {
        
        [self.navigationController popViewControllerAnimated:false];
        
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    self.tabBarController.tabBar.hidden = false;
    //通知改变登录状态，切换账号/登录
    [[NSNotificationCenter defaultCenter] postNotificationName:LogStatusNotifacation object:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark *** ToRegisterViewDelegate ***
//点击获取验证码
-(void)ToRegisViewDidSelectedVerfication:(ToRegistView *)registView{
    MYLog(@"获取验证码");
     NSLog(@"%@", registView.accountView.inputTextView.text);
    
    [TCJPHTTPRequestManager POSTWithParameters:@{@"mobile":registView.accountView.inputTextView.text,@"content":@"123456"} requestID:@0 requestcode:@"sendsms" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSLog(@"%@", responseObject);
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error.description);
    }];
    
}

//点击立即注册

-(void)ToRegisViewDidSelectedRegistBtn:(ToRegistView *)registView{
    
    
    NSString *accStr = registView.accountView.inputTextView.text;
    NSString *pasStr = registView.passwordView.inputTextView.text;
//    NSNumber *lng = @0;
//    NSNumber *lat = @0;
 
    NSLog(@"acc-%@pas-%@", accStr,pasStr);
    
    NSDictionary *dic = @{@"MeAccount":accStr,@"MePassword":pasStr,@"MeLng":@"0",@"MeLat":@"0"};
//    NSDictionary *dic = @{@"MeAccount":accStr,@"MePassword":pasStr};

    
    [TCJPHTTPRequestManager POSTWithParameters:dic requestID:@0 requestcode:kRequestCodeRegister success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            
            NSDictionary *dic = [NSDictionary DicWithString:jsonDic[@"data"]];
            NSLog(@"%@", dic);

            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error.description);
    }];
    
    MYLog(@"立即注册");
}

#pragma mark *** LoginViewDelegate ***
//选中上端菜单
-(void)loginView:(LoginView *)loginView didSelectedTopViewBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
            //返回按钮
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
        {
     
            //注册和登录动态切换
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
        {
            NSLog(@"qq");
        }
            break;
        case 1:
        {
            NSLog(@"weixin");
            AddMemberViewController *addM = [[AddMemberViewController alloc] initWithTitle:@"添加成员" image:nil];
            [self.navigationController pushViewController:addM animated:YES];
        }
            break;
        
        case 2:
        {
            NSLog(@"weibo");
           
        }
            break;
        default:
            break;
    }
}

//登录按钮
-(void)loginView:(LoginView *)loginView didSelectedLoginBtn:(UIButton *)sender{
    
    MYLog(@"登录");

    NSDictionary *logDic = @{@"user":self.loginView.accountView.inputTextView.text,@"pass":self.loginView.passwordView.inputTextView.text};
    
    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:@0 requestcode:kRequestCodeLogin success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            //登录成功
            LoginModel *loginModel = [LoginModel modelWithJSON:jsonDic[@"data"]];
            
            
            //存储用户信息
            //id
            [USERDEFAULT setObject:@(loginModel.MeId) forKey:@"userid"];
            [USERDEFAULT setObject:@true forKey:LoginStates];
            //余额
            [USERDEFAULT setObject:@(loginModel.MeBalance) forKey:@"MeBalance"];
            //同城币
            [USERDEFAULT setObject:@(loginModel.MeIntegral) forKey:@"MeIntegral"];
            //昵称
            [USERDEFAULT setObject:loginModel.MeNickname forKey:@"MeNickname"];
            //vip等级
            [USERDEFAULT setObject:@(loginModel.MeViplevel) forKey:@"MeViplevel"];
            //头像路径
            [USERDEFAULT setObject:loginModel.MeExtension forKey:@"MeExtension"];
            [USERDEFAULT setObject:self.loginView.accountView.inputTextView.text forKey:UserAccount];
            [USERDEFAULT setObject:self.loginView.passwordView.inputTextView.text forKey:UserPassword];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
            
        }
        
    } failure:^(NSError *error) {
        MYLog(@"失败---%@",error.description);
    }];
}
//游客按钮
-(void)loginView:(LoginView *)loginView didSelectedTourBtn:(UIButton *)sender{
    
    NSLog(@"游客请进！");
    [USERDEFAULT setObject:@false forKey:LoginStates];
    //游客进入id为1的测试账号
    [USERDEFAULT setObject:@1 forKey:@"userid"];
    [self.navigationController popViewControllerAnimated:YES];
    
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
        _loginView.accountView.inputTextView.placeholder = @"用户名/手机号";
        [_loginView.accountView setAccPlaceholder];
        
        if ([USERDEFAULT objectForKey:UserAccount]&&[USERDEFAULT objectForKey:UserPassword]) {
            _loginView.accountView.inputTextView.text = [USERDEFAULT objectForKey:UserAccount];
            _loginView.passwordView.inputTextView.text = [USERDEFAULT objectForKey:UserPassword];
        }
        
    }
    return _loginView;
}

-(ToRegistView *)regisView{
    if (!_regisView) {
        _regisView = [[ToRegistView  alloc] initWithFrame:CGRectMake(0, 0, 0.8*Screen_width, ReGistView_height)];
        _regisView.center = CGPointMake(700, CGRectGetMinY(self.loginView.accountView.frame)+ReGistView_height/2);
        _regisView.alpha = 0;
        _regisView.delegate = self;
        
    }
    return _regisView;
}


@end
