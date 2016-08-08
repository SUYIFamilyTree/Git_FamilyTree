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
#import "RootTabBarViewController.h"

#define ReGistView_height 180
#define AnimationsTime 0.4f
@interface LoginViewController ()<LoginViewDelegate,ToRegisViewDelegate>

@property (nonatomic,strong) LoginView *loginView; /*登录界面*/

@property (nonatomic,strong) ToRegistView *regisView; /*注册view*/

@property (nonatomic,strong) RootTabBarViewController *tabBarVc; /*标签控制器*/
/** 验证码*/
@property (nonatomic, assign) NSInteger verificationCode;


@end

@implementation LoginViewController
#pragma mark *** lifeCircle ***
- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self.view addSubview:self.loginView];

    
    
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
    self.verificationCode = arc4random() % 10000 + (arc4random()%9+1)*100000;
    MYLog(@"%ld",(long)self.verificationCode);
    [TCJPHTTPRequestManager POSTWithParameters:@{@"mobile":registView.accountView.inputTextView.text,@"content":[NSString stringWithFormat:@"%ld",(long)self.verificationCode]} requestID:@0 requestcode:@"sendsms" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        MYLog(@"%@", jsonDic[@"message"]);
        if (succe) {
            
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"%@", error.description);
    }];
    
}

//点击立即注册

-(void)ToRegisViewDidSelectedRegistBtn:(ToRegistView *)registView{
    
    
    NSString *accStr = registView.accountView.inputTextView.text;
    NSString *pasStr = registView.passwordView.inputTextView.text;
//    NSNumber *lng = @0;
//    NSNumber *lat = @0;
 
    MYLog(@"acc-%@pas-%@", accStr,pasStr);
    
    if ([pasStr isEqualToString:[NSString stringWithFormat:@"%ld",(long)self.verificationCode]]) {
        NSDictionary *dic = @{@"MeAccount":accStr,@"MePassword":pasStr,@"MeLng":@"0",@"MeLat":@"0"};
        //    NSDictionary *dic = @{@"MeAccount":accStr,@"MePassword":pasStr};
        
        
        [TCJPHTTPRequestManager POSTWithParameters:dic requestID:@0 requestcode:kRequestCodeRegister success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            MYLog(@"%@",jsonDic);
            if ([jsonDic[@"resultcode"] isEqualToString:@"00000003"]) {
               [SXLoadingView showAlertHUD:jsonDic[@"message"] duration:0.5];
            }
            if (succe) {
                if (![jsonDic[@"message"] isEqualToString:@"注册成功"]) {
                    [SXLoadingView showAlertHUD:jsonDic[@"message"] duration:0.5];
                }else{
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册成功" message:[NSString stringWithFormat:@"您的初始密码是%ld", (long)self.verificationCode] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self dismissViewControllerAnimated:NO completion:nil];
                    }];
                    [alert addAction:sureAction];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                }
            }
        } failure:^(NSError *error) {
            NSLog(@"%@", error.description);
        }];
        
        MYLog(@"立即注册");

    }else{
        [SXLoadingView showAlertHUD:@"验证码不正确" duration:0.5];
    }
}

#pragma mark *** LoginViewDelegate ***
//选中上端菜单
-(void)loginView:(LoginView *)loginView didSelectedTopViewBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
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
        case 1:
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
    [SXLoadingView showProgressHUD:@"正在登录"];
    
    MYLog(@"登录");

    NSDictionary *logDic = @{@"user":self.loginView.accountView.inputTextView.text,@"pass":self.loginView.passwordView.inputTextView.text};
    WK(weakSelf)
    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:@0 requestcode:kRequestCodeLogin success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        MYLog(@"登录%@",jsonDic);
        if (succe) {
            //登录成功
            if ([jsonDic[@"message"] isEqualToString:@"登录成功"]) {
                [SXLoadingView showAlertHUD:@"登录成功" duration:0.5];
                LoginModel *loginModel = [LoginModel modelWithJSON:jsonDic[@"data"]];
                
                if ([USERDEFAULT objectForKey:@"userid"]&&[[USERDEFAULT objectForKey:@"userid"] integerValue]!=loginModel.userId) {
                    //登录成功移除userdefault的id
                    if ([USERDEFAULT objectForKey:kNSUserDefaultsMyFamilyID]) {
                        [USERDEFAULT removeObjectForKey:kNSUserDefaultsMyFamilyID];
                        if ([WFamilyModel shareWFamilModel]) {
                            [WFamilyModel  shareWFamilModel].ds = 0;
                            [WFamilyModel  shareWFamilModel].rs = 0;
                            WFamilyModel *model = [[WFamilyModel alloc] init];
                            [WFamilyModel  shareWFamilModel].datalist = model.datalist;
                            
                           
                        }
                    }
                }
                                
                //存储用户信息
                //id
                [USERDEFAULT setObject:@(loginModel.userId) forKey:@"userid"];
                //登录授权认证码
                [USERDEFAULT setObject:loginModel.auth
                                forKey:@"authcode"];
                [USERDEFAULT setObject:self.loginView.accountView.inputTextView.text forKey:UserAccount];
                [USERDEFAULT setObject:self.loginView.passwordView.inputTextView.text forKey:UserPassword];
                
                RootTabBarViewController *rootVC = [[RootTabBarViewController alloc]init];
                [weakSelf presentViewController:rootVC animated:YES completion:nil];
                
            }else{
                [SXLoadingView showAlertHUD:jsonDic[@"message"] duration:0.5];
            }
            
        }else{
            [SXLoadingView showAlertHUD:jsonDic[@"message"] duration:0.5];
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
    NSDictionary *logDic = @{@"user":@"test1234",@"pass":@"111111"};
    
    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:@0 requestcode:kRequestCodeLogin success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            //登录成功
            LoginModel *loginModel = [LoginModel modelWithJSON:jsonDic[@"data"]];
            //存储用户信息
            //id
            [USERDEFAULT setObject:@(loginModel.userId) forKey:@"userid"];
            //登录授权认证码
            [USERDEFAULT setObject:loginModel.auth
                            forKey:@"authcode"];
            
            //[self dismissViewControllerAnimated:NO completion:nil];
            
            
        }
        
    } failure:^(NSError *error) {
        MYLog(@"失败---%@",error.description);
    }];

    
    
    [USERDEFAULT setObject:@1 forKey:@"userid"];
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
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
