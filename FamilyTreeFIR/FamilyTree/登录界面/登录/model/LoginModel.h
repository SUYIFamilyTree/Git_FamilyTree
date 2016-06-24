//
//  LoginModel.h
//  FamilyTree
//
//  Created by 王子豪 on 16/5/30.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LoginModel : NSObject
/** id*/
@property (nonatomic, assign) NSInteger userId;
/** 账户名*/
@property (nonatomic, copy) NSString *account;
/** 授权码*/
@property (nonatomic, copy) NSString *auth;

+(instancetype)sharedLoginMode;

@end


