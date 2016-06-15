//
//  HeadImageView.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/14.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "HeadImageView.h"

@implementation HeadImageView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.headInsideIV = [[UIImageView alloc]initWithFrame:CGRectMake(0.137*CGRectW(self), 0.0667*CGRectH(self), 0.7100*CGRectW(self), 0.7867*CGRectH(self))];
        if (self.headInsideIV.image == nil) {
            self.image = MImage(@"xiuGaitouxiang_tx");
//            self.headInsideIV.image = MImage(@"xiuGaitouxiang_sel1");
        }
        self.headInsideIV.layer.cornerRadius = 0.7100*CGRectW(self)/2;
        self.headInsideIV.layer.masksToBounds = YES;
        [self addSubview:self.headInsideIV];
        
    }
    return self;
}
@end
