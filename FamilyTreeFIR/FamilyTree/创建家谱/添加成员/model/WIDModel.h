//
//  WIDModel.h
//  FamilyTree
//
//  Created by 王子豪 on 16/7/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <Foundation/Foundation.h>
//身份id，每个身份有唯一id


@interface WIDModel :NSObject

@property (nonatomic, copy) NSString *syntype;

@property (nonatomic, copy) NSString *syntypeval;

@property (nonatomic,strong) NSDictionary *idDic; /*身份dic*/

@property (nonatomic,strong) NSDictionary *fatherDic; /*父亲dic*/


+(instancetype)sharedWIDModel;

@end



