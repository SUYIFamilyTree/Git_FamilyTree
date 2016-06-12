//
//  NSString+md5.h
//  测试接口
//
//  Created by 姚珉 on 16/5/23.
//  Copyright © 2016年 yaomin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (md5)
+(NSString *) md5Str:(NSString *)str;
//字典装字符串
+(NSString *) stringWithDic:(NSDictionary *)dic;
+(NSString *)getCurrentTimeAddNumber;
//横向转竖向字符串
+(NSString *)verticalStringWith:(NSString *)string;
@end
