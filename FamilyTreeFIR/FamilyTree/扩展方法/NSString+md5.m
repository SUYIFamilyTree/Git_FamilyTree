//
//  NSString+md5.m
//  测试接口
//
//  Created by 姚珉 on 16/5/23.
//  Copyright © 2016年 yaomin. All rights reserved.
//

#import "NSString+md5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (md5)
+(NSString *)md5Str:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char md5c[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), md5c);
    NSMutableString *md5Str = [NSMutableString string];
    for (int i = 0; i < 16; i++) {
        [md5Str appendFormat:@"%02x",md5c[i]];
    }
    return  md5Str;
    
}

+(NSString *)stringWithDic:(NSDictionary *)dic{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *jsonStrn = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *jsonStrnSpace = [jsonStrn stringByReplacingOccurrencesOfString:@" " withString:@""];
    return jsonStrnSpace;
}


+(NSString *)getCurrentTimeAddNumber{
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    
    NSString *currentDate = [formatter stringFromDate:date];
    
    
    
    NSInteger randomFour = 1000+random()%(9000);
    
    NSString *currentKey = [NSString stringWithFormat:@"%@%ld",currentDate,randomFour];
    
    
    return currentKey;
    
    
}

@end
