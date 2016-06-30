//
//  NSString+getStarDate.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/28.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "NSString+getStarDate.h"

@implementation NSString (getStarDate)
+(NSString *)getStarDateWithStar:(NSString *)starStr{
    if ([starStr isEqualToString:@"白羊座"]) {
        return @"3.21-4.19";
    }
    if ([starStr isEqualToString:@"金牛座"]) {
        return @"4.20-5.20";
    }
    if ([starStr isEqualToString:@"双子座"]) {
        return @"5.21-6.21";
    }
    if ([starStr isEqualToString:@"巨蟹座"]) {
        return @"6.22-7.22";
    }
    if ([starStr isEqualToString:@"狮子座"]) {
        return @"7.23-8.22";
    }
    if ([starStr isEqualToString:@"处女座"]) {
        return @"8.23-9.22";
    }
    if ([starStr isEqualToString:@"天秤座"]) {
        return @"9.23-10.23";
    }
    if ([starStr isEqualToString:@"天蝎座"]) {
        return @"10.24-11.22";
    }
    if ([starStr isEqualToString:@"射手座"]) {
        return @"11.23-12.21";
    }
    if ([starStr isEqualToString:@"摩羯座"]) {
        return @"12.22-1.19";
    }
    if ([starStr isEqualToString:@"水瓶座"]) {
        return @"1.20-2.18";
    }
    if ([starStr isEqualToString:@"双鱼座"]) {
        return @"2.19-3.20";
    }
    else{
        return @"";
    }
}
@end
