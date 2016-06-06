//
//  PersonalCenterNumerologyView.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/4.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "PersonalCenterNumerologyView.h"
#import "CALayer+drawborder.h"

@interface PersonalCenterNumerologyView()
/** 命理说明数组*/
@property (nonatomic, strong) NSArray *numerologyArr;
@end

@implementation PersonalCenterNumerologyView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5];
        //左侧五行图
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0152*CGRectW(self), 0.0886*CGRectH(self), 0.4750*CGRectW(self), 0.7595*CGRectH(self))];
        imageView.image = MImage(@"human_wuxingImg");
        [self addSubview:imageView];
        //阴阳五行命理
        self.numerologyArr = @[@"火命，阴阳五行命理为",@"1金    2木    0水    3火    2土",@"五行缺水，阳气太旺,阳盛阴衰"];
        [self initNumerologyLBs];
        //命理图
        UIImageView *numerologyIV = [[UIImageView alloc]initWithFrame:CGRectMake(0.5030*CGRectW(self), 0.4506*CGRectH(self), 0.3298*CGRectW(self), 0.3873*CGRectH(self))];
        numerologyIV.image = MImage(@"human_xuxian");
        [self addSubview:numerologyIV];
        
        //生辰八字
        UILabel *shengChenBaZiLB = [[UILabel alloc]initWithFrame:CGRectMake(0.8997*CGRectW(self), 0.4304*CGRectH(self), 0.1094*CGRectW(self), 0.3997*CGRectH(self))];
        shengChenBaZiLB.text = @"生\n辰\n八\n字";
        shengChenBaZiLB.font = MFont(15);
        shengChenBaZiLB.numberOfLines = 0;
        [self addSubview:shengChenBaZiLB];
        
    

        
       
    }
    return self;
}


-(void)initNumerologyLBs{
    for (int i = 0; i < 3; i++) {
        CGFloat labelHeight = 0.0845*CGRectH(self);
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0.4867*CGRectW(self), 0.0911*CGRectH(self)+labelHeight*i, 0.4559*CGRectW(self), labelHeight)];
        label.text = self.numerologyArr[i];
        label.font = MFont(10);
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
}


@end
