//
//  TCJPHTTPRequestManager.m
//  测试接口
//
//  Created by 姚珉 on 16/5/25.
//  Copyright © 2016年 yaomin. All rights reserved.
//

#import "TCJPHTTPRequestManager.h"

//字典包括参数：requestuserid类型int32,requestcode类型字符串,requestdata字典
@implementation TCJPHTTPRequestManager
+ (void)POSTWithParameters:(NSDictionary*)customParams requestID:(NSNumber *)requestID requestcode:(NSString *)requestcode success:(SuccessCallBack)success failure:(FailureCallBack)fail
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    //请求超时时间
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置请求body为json格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //加密
    //MD5(requestdata+SecretKey+requestuserid+requestcode+timestamp)，SecretKey由双方约定，为可配置参数，测试环境的SecretKey暂定为：abc123。
    NSString *requestData = [NSString stringWithDic:customParams];
    NSString *timeStamp = [NSString getCurrentTimeAddNumber];
    NSString *requestUserId = [NSString stringWithFormat:@"%@",requestID];
    NSString *md5checkStr = [[[[requestData stringByAppendingString:SecretKeySend]stringByAppendingString:requestUserId] stringByAppendingString:requestcode] stringByAppendingString:timeStamp];
//    MYLog(@"requestData:%@",requestData);
//    NSLog(@"md5beforeStr--%@", md5checkStr);
    NSString *md5checkStr1 = [md5checkStr stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    NSString *md5check = [NSString md5Str:md5checkStr1];
    
//    NSLog(@"md5afterStr--%@", md5check);
    
    //NSMutableString  *autocode = [NSMutableString string];
    NSString *authcode;
        if ([requestcode isEqualToString:@"login"]||[requestcode isEqualToString:@"register"]||[requestcode isEqualToString:@"sendsms"]) {
            authcode = @"";
        }else{
            authcode = [USERDEFAULT valueForKey:@"authcode"];
        }
    //MYLog(@"授权验证码%@",authcode);
    
    NSDictionary *params = @{
                             @"requestuserid":requestID,
                             @"timestamp":timeStamp,
                             @"requestcode":requestcode,
                             @"requestdata":customParams,
                             @"md5check":md5check,
                             @"authcode":authcode,
                             @"reserved":@""
                             };
    
    NSLog(@"请求的参数----:%@", params);
    
    [manager POST:RootURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSUTF8StringEncoding error:&error];
        NSLog(@"得到的返回---%@",jsonDic);
        
        NSString *jsonStr = [NSString stringWithFormat:@"%@",jsonDic];
        NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        //MYLog(@"转成ios的返回--%@", dic);
        BOOL succe = NO;
        //判断md5是不是为约定的来验证返回数据的完整性和有效性
        //MD5(data+SecretKey+result+resultcode+timestamp)，SecretKey由双方约定，为可配置参数，测试环境的SecretKey暂定为：123abc。
        //NSString *dataStr = [NSString stringWithDic:dic[@"data"]];
        
        if (!error) {
            NSString *md5Receive = [[[[dic[@"data"] stringByAppendingString:SecretKeyReiceive] stringByAppendingString:[dic[@"result"] boolValue]?@"true":@"false"] stringByAppendingString:dic[@"resultcode"]] stringByAppendingString:dic[@"timestamp"]];
            //NSLog(@"返回数据拼接的字符串--%@", md5Receive);
            NSString *md5ReceiveStr = [NSString md5Str:md5Receive];
            //NSLog(@"返回数据的md5check---%@", md5ReceiveStr);
            
//                    NSLog(@"Data:%@,SecretKeyReceive:%@,result:%@,resultcode:%@,timestamp:%@",dic[@"data"],SecretKeyReiceive,dic[@"result"]?@"true":@"false",dic[@"resultcode"],dic[@"timestamp"]);
//                    NSLog(@"我加密的%@",md5ReceiveStr);
//                    NSLog(@"返回的%@",dic[@"md5check"]);
            if ([dic[@"md5check"]isEqualToString:md5ReceiveStr]) {
                succe = YES;
            }else{
                
            }
            success(responseObject,succe,dic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
        
    }];

    
    
}

@end
