//
//  DrawStarsView.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/6.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "DrawStarsView.h"

@implementation DrawStarsView
-(instancetype)initWithFrame:(CGRect)frame redStars:(int)redNumber{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //画星星
        for (int i = 0; i < redNumber; i++) {
            UIImageView *RedStarIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectW(self)/5*i, 0, CGRectW(self)/5,CGRectH(self))];
            RedStarIV.image = MImage(@"human_xing_red");
            [self addSubview:RedStarIV];
        }
        for (int i = redNumber ; i < 5; i++) {
            UIImageView *starIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectW(self)/5*redNumber+CGRectW(self)/5*(i-redNumber), 0, CGRectW(self)/5, CGRectH(self))];
            starIV.image = MImage(@"human_xing");
            [self addSubview:starIV];
        }
    }
    return  self;
}
@end
