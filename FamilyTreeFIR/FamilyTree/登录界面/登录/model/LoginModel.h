//
//  LoginModel.h
//  FamilyTree
//
//  Created by 王子豪 on 16/5/30.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

@property (nonatomic, copy) NSString *MeSurname;

@property (nonatomic, copy) NSString *MeAccount;

@property (nonatomic, assign) NSInteger MeLng;

@property (nonatomic, copy) NSString *MeState;

@property (nonatomic, copy) NSString *MeNickname;

@property (nonatomic, copy) NSString *MePassword;

@property (nonatomic, assign) NSInteger MeIntegral;

@property (nonatomic, copy) NSString *MeOperuser;

@property (nonatomic, copy) NSString *MeIsvip;

@property (nonatomic, copy) NSString *MeRegistertime;

@property (nonatomic, copy) NSString *MeCardnum;

@property (nonatomic, copy) NSString *MeExtension;

@property (nonatomic, copy) NSString *MeIsblack;

@property (nonatomic, copy) NSString *MeScbz;

@property (nonatomic, copy) NSString *MeKeepdate;

@property (nonatomic, copy) NSString *MeName;

@property (nonatomic, assign) NSInteger MeBalance;

@property (nonatomic, assign) NSInteger MeLat;

@property (nonatomic, assign) NSInteger MeId;

@property (nonatomic, copy) NSString *MeBirthday;

@property (nonatomic, assign) NSInteger MeKeepnum02;

@property (nonatomic, assign) NSInteger MeKeepnum01;

@property (nonatomic, copy) NSString *MeCertype;

@property (nonatomic, copy) NSString *MeMobile;

@property (nonatomic, assign) NSInteger MeViplevel;

@property (nonatomic, copy) NSString *MeSex;

@property (nonatomic, copy) NSString *MeEmail;

@property (nonatomic, assign) NSInteger MeIsgenealogy;

@property (nonatomic, assign) NSInteger MeAreacodeid;

@property (nonatomic, copy) NSString *MeKeepstr02;

@property (nonatomic, copy) NSString *MeKeepstr01;

+(instancetype)sharedLoginMode;

@end
