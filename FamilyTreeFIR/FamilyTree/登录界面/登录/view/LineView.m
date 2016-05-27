//
//  LineView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/27.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "LineView.h"

@implementation LineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

//画底部线
- (void)drawRect:(CGRect)rect {
    //1.获取画板（上下文）
    CGContextRef context = UIGraphicsGetCurrentContext();
    //2.设置画笔颜色
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    //3.设置画笔宽度
    CGContextSetLineWidth(context, 1.5f);
    
#pragma mark *** 绘制一条直线 ***
    
    //4.设置起点
    CGContextMoveToPoint(context, 0, 0);
    //5.设置终点
    CGContextAddLineToPoint(context, 0, 3);
    
    CGContextAddLineToPoint(context, SelfView_width-5, 3);
    
    CGContextAddLineToPoint(context, SelfView_width-5, 0);
    
    CGContextStrokePath(context);
}

@end
