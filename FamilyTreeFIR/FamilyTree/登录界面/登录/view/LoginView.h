//
//  LoginView.h
//  FamilyTree
//
//  Created by 王子豪 on 16/5/25.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginView;

@protocol LoginViewDelegate <NSObject>

-(void)loginView:(LoginView *)loginView didSelectedTopViewBtn:(UIButton *)sender;
-(void)loginView:(LoginView *)loginView didSelectedOtherLoginBtn:(UIButton *)sender;
-(void)loginView:(LoginView *)loginView didSelectedLoginBtn:(UIButton *)sender;
-(void)loginView:(LoginView *)loginView didSelectedTourBtn:(UIButton *)sender;



@end

@interface LoginView : UIView
@property (nonatomic,weak)   id<LoginViewDelegate> delegate; /*代理人*/

@end
