//
//  PersonModel.h
//  FamilyTree
//
//  Created by 姚珉 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject
/** 姓名*/
@property (nonatomic, strong) NSString *name;
/** 关系*/
@property (nonatomic, strong) NSString *relation;
/** 性别*/
@property (nonatomic, getter=isMan) BOOL man;

@end
