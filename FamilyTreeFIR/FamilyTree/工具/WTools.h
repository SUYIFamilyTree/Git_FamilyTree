//
//  WTools.h
//  FamilyTree
//
//  Created by 王子豪 on 16/6/25.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreateFamModel.h"
#import "WIDModel.h"
@interface WTools : NSObject

UIKIT_EXTERN NSString * _Nonnull const kRequestCodecreategen;
UIKIT_EXTERN NSString * _Nonnull const kRequestCodequerygenlist;
UIKIT_EXTERN NSString * _Nonnull const kRequestCodequerymygen;
UIKIT_EXTERN NSString * _Nonnull const kRequestCodequerygendeta;

UIKIT_EXTERN NSString * _Nonnull const kRequestCodeuploadgenan;
UIKIT_EXTERN NSString * _Nonnull const kRequestCodeuploadgentt;

//家谱
//查询家谱字辈成员列表
UIKIT_EXTERN NSString * _Nonnull const kRequestCodequeryzbgemelist;
//查询家谱字辈成员详情
UIKIT_EXTERN NSString * _Nonnull const kRequestCodequerygemedetailbyid;
//修改家谱
UIKIT_EXTERN NSString * _Nonnull const kRequestCodeeditgen;
//修改家谱大数据字段
UIKIT_EXTERN NSString * _Nonnull const kRequestCodeeditgenbigdata;
//申请加入家谱
UIKIT_EXTERN NSString * _Nonnull const kRequestCodeapplyjoingen;
//获取家谱字辈
UIKIT_EXTERN NSString * _Nonnull const kRequestCodequerygeneration;
//添加家谱成员
UIKIT_EXTERN NSString * _Nonnull const kRequestCodeaddgeme;
//加入家谱
UIKIT_EXTERN NSString * _Nonnull const kRequestCodejoingen;
//查询家谱树
UIKIT_EXTERN NSString * _Nonnull const kRequestCodequerytreebygenid;
//查询待修改家谱成员详情
UIKIT_EXTERN NSString * _Nonnull const kRequestCodequerygemedetailbyidforupdate;
//修改家谱成员详情
UIKIT_EXTERN NSString * _Nonnull const kRequestCodeeditgemedetail;

//查询家谱所有成员
UIKIT_EXTERN NSString * _Nonnull const kRequestCodequerygemelist;

//进入家谱首页的接口
UIKIT_EXTERN NSString * _Nonnull const kRequestCodegetintogen;

#pragma mark *** 未通接口 ***
//查询宗亲信息
UIKIT_EXTERN NSString * _Nonnull const kRequestCodequeryclan;


//墓园
UIKIT_EXTERN NSString * _Nonnull const kRequestCodeeditcemetery;
UIKIT_EXTERN NSString * _Nonnull const kRequestCodecemeterdetail;
UIKIT_EXTERN NSString * _Nonnull const kRequestCodecemeterylist;
UIKIT_EXTERN NSString * _Nonnull const kRequestCodecreatecemetery;

//通知字段
UIKIT_EXTERN NSString * _Nonnull const kNotificationCodeManagerFam;


//UIKIT_EXTERN NSString * _Nonnull const kRequestCode<#uploadgentt#>;
//UIKIT_EXTERN NSString * _Nonnull const kRequestCode<#uploadgentt#>;
//UIKIT_EXTERN NSString * _Nonnull const kRequestCode<#uploadgentt#>;
//UIKIT_EXTERN NSString * _Nonnull const kRequestCode<#uploadgentt#>;
//UIKIT_EXTERN NSString * _Nonnull const kRequestCode<#uploadgentt#>;
//UIKIT_EXTERN NSString * _Nonnull const kRequestCode<#uploadgentt#>;

@end
