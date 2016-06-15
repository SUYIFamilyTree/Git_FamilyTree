//
//  ToRegistView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/27.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "ToRegistView.h"
#import "AccountView.h"
@interface ToRegistView()

@property (nonatomic,strong) UIButton *verificationBtn; /*验证码按钮*/
@property (nonatomic,strong) UIButton *registButton; /*注册按钮*/



@end
@implementation ToRegistView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.accountView];
        [self.passwordView addSubview:self.verificationBtn];
        [self addSubview:self.passwordView];
        [self addSubview:self.registButton];
    }
    return self;
}

#pragma mark *** Events ***
//点击验证码
-(void)respondsToVerficationBtn:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(ToRegisViewDidSelectedVerfication:)]) {
        [_delegate ToRegisViewDidSelectedVerfication:self];
    }
}
//点击注册
-(void)respondsToRegistBtn:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(ToRegisViewDidSelectedRegistBtn:)]) {
        [_delegate ToRegisViewDidSelectedRegistBtn:self];
    }
}

#pragma mark *** getters ***

-(AccountView *)accountView{
    if (!_accountView) {
        _accountView = [[AccountView alloc] initWithFrame:CGRectMake(0, 0,  0.8*Screen_width, 50) headImage:[UIImage imageNamed:@"newUser_tel"] isSafe:NO hasArrows:NO];
        
        _accountView.bounds = CGRectMake(0, 0, 0.8*Screen_width, 50);
        _accountView.center = CGPointMake(self.center.x, 30);
        _accountView.inputTextView.placeholder = @"手   机   号";
        [_accountView setAccPlaceholder];
        
    }
    return _accountView;
}
-(UIButton *)verificationBtn{
    if (!_verificationBtn) {
        _verificationBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame)-self.bounds.size.width/4, -5, self.bounds.size.width/4, 30)];
        _verificationBtn.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        [_verificationBtn setTitle:@"获取验证码" forState:0];
        [_verificationBtn setTitleColor:LH_RGBCOLOR(95, 95, 95) forState:0];
        _verificationBtn.titleLabel.font = MFont(12);
        
        [_verificationBtn addTarget:self action:@selector(respondsToVerficationBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _verificationBtn;
}
-(AccountView *)passwordView{
    if (!_passwordView) {
        _passwordView = [[AccountView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.accountView.frame), CGRectGetMaxY(self.accountView.frame)+10, self.accountView.bounds.size.width, 50) headImage:[UIImage imageNamed:@"newUser_yanzheng"] isSafe:NO hasArrows:NO];
        _passwordView.inputTextView.placeholder = @"验   证   码";
        [_passwordView setAccPlaceholder];
        
    }
    return _passwordView;
}

-(UIButton *)registButton{
    if (!_registButton) {
        _registButton = [[UIButton alloc] init];
        _registButton.bounds = CGRectMake(0, 0, self.passwordView.bounds.size.width, 40);
        _registButton.center = CGPointMake(self.center.x, CGRectGetMaxY(self.passwordView.frame)+_registButton.bounds.size.height);
        _registButton.backgroundColor = self.verificationBtn.backgroundColor;
        [_registButton setTitle:@"立即注册" forState:0];
        [_registButton setTitleColor:LH_RGBCOLOR(95, 95, 95) forState:0];
        _registButton.titleLabel.font = MFont(18);
        
        [_registButton addTarget:self action:@selector(respondsToRegistBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _registButton;
}


@end
