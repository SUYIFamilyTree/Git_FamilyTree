//
//  WTools.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/25.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "WTools.h"

@implementation WTools

//创建家谱
NSString * _Nonnull const kRequestCodecreategen = @"creategen";

//查询家谱列表
NSString * _Nonnull const kRequestCodequerygenlist = @"querygenlist";
//查询我的家谱
NSString * _Nonnull const kRequestCodequerymygen = @"querymygen";
//查询家谱详情
NSString * _Nonnull const kRequestCodequerygendeta = @"querygendeta";

#pragma mark *** 未测试接口 ***

//查询家谱字辈成员列表
NSString * _Nonnull const kRequestCodequeryzbgemelist = @"queryzbgemelist";
//查询家谱字辈成员详情
NSString * _Nonnull const kRequestCodequerygemedetailbyid = @"querygemedetailbyid";
//修改家谱
NSString * _Nonnull const kRequestCodeeditgen = @"editgen";
//修改家谱大数据字段
NSString * _Nonnull const kRequestCodeeditgenbigdata = @"editgenbigdata";
//申请加入家谱
NSString * _Nonnull const kRequestCodeapplyjoingen = @"applyjoingen";
//获取家谱字辈
NSString * _Nonnull const kRequestCodequerygeneration = @"querygeneration";
//添加家谱成员
NSString * _Nonnull const kRequestCodeaddgeme = @"addgeme";
//加入家谱
NSString * _Nonnull const kRequestCodejoingen = @"joingen";
//查询家谱树
NSString * _Nonnull const kRequestCodequerytreebygenid = @"querytreebygenid";
//查询待修改家谱成员详情
NSString * _Nonnull const kRequestCodequerygemedetailbyidforupdate = @"querygemedetailbyidforupdate";
//修改家谱成员详情
NSString * _Nonnull const kRequestCodeeditgemedetail = @"editgemedetail";

//查询所有成员列表
NSString * _Nonnull const kRequestCodequerygemelist = @"querygemelist";


#pragma mark *** 未通接口 ***
//查询宗亲信息--只有接口没数据，传了参数就失败。
NSString * _Nonnull const kRequestCodequeryclan = @"queryclan";

//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";

//上传祖先头像
NSString * _Nonnull const kRequestCodeuploadgenan = @"uploadgenan";
//上传家谱图腾头像
NSString * _Nonnull const kRequestCodeuploadgentt = @"uploadgentt";
//上传家谱共享图片
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//上传家谱共享视频
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";


//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";

//添加墓园
NSString * _Nonnull const kRequestCodecreatecemetery = @"createcemetery";
//编辑墓园
NSString * _Nonnull const kRequestCodeeditcemetery = @"editcemetery";
//墓园详情
NSString * _Nonnull const kRequestCodecemeterdetail = @"cemeterdetail";
//墓园列表
NSString * _Nonnull const kRequestCodecemeterylist = @"cemeterylist";

//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";
//NSString * _Nonnull const kRequestCode<#querymygen#> = @"<#querymygen#>";

//管理家谱通知字段

NSString * _Nonnull const kNotificationCodeManagerFam = @"managerFame";




@end
