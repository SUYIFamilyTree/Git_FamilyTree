//
//  NSString+WJudgeStringlegal.m
//  FamilyTree
//
//  Created by 王子豪 on 16/7/15.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "NSString+WJudgeStringlegal.h"

@implementation NSString (WJudgeStringlegal)
+(BOOL)judgeWithString:(NSString *)string{
    if (!string) {
        return false;
    }
    
    NSInteger continuousCount = 0;
    NSInteger letterCount = 0;
    for(int i=0; i< [string length];i++){
        int a = [string characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            if (letterCount==1) {
                letterCount-=1;
            }
            continuousCount+=1;
        }else{
            letterCount+=1;
            if (continuousCount==1) {
                 continuousCount-=1;
            }
        }
        if (continuousCount==2) {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"字辈只能为一个字" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
            continuousCount = 0;
            return false;
        }
        if (letterCount==2) {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"输入格式有误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
            letterCount = 0;
            return false;
        }
        
        if (i>2&&i<string.length-2) {
            if ([string characterAtIndex:i]==[string characterAtIndex:i+2]) {
                UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"重复的字辈" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alertView show];
                return false;
            }
        }
        
        
    }
    return YES;
    
}
@end
