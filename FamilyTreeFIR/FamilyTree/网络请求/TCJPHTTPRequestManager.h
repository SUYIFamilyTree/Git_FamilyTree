//
//  TCJPHTTPRequestManager.h
//  测试接口
//
//  Created by 姚珉 on 16/5/25.
//  Copyright © 2016年 yaomin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void(^SuccessCallBack)(id responseObject,BOOL succe,NSDictionary *jsonDic);
typedef  void (^FailureCallBack)(NSError *error);
@interface TCJPHTTPRequestManager : NSObject
//字典包括参数：requestuserid类型:int32,requestcode类型:字符串,requestdata类型:字典
//单纯的获取数据
+ (void)POSTWithParameters:(NSDictionary *)customParams requestID:(NSNumber *)requestID requestcode:(NSString *)requestcode success:(SuccessCallBack)success failure:(FailureCallBack)fail;

+ (void)POSTWithParametersContainArr:(NSDictionary *)customParams requestID:(NSNumber *)requestID requestcode:(NSString *)requestcode success:(SuccessCallBack)success failure:(FailureCallBack)fail;

@end
