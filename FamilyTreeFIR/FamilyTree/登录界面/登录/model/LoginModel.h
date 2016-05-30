//
//  LoginModel.h
//  FamilyTree
//
//  Created by 王子豪 on 16/5/30.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

@property (nonatomic,copy) NSString *MeAreacodeid; /*账号id*/


+(instancetype)sharedLoginMode;
@end
