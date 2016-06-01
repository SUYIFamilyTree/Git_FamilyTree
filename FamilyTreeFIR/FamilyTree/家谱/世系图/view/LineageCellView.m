//
//  LineageCellView.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "LineageCellView.h"
#import "PersonModel.h"
@implementation LineageCellView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.man = YES;
        self.layer.borderColor = (self.isMan?LH_RGBCOLOR(164, 225, 206):LH_RGBCOLOR(230, 182, 142)).CGColor;
        self.layer.borderWidth = 1;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.headIV];
        [self addSubview:self.nameLB];
        [self addSubview:self.relationLB];
    }
    return self;
}

#pragma mark - lazyLoad
-(UIImageView *)headIV{
    if (!_headIV) {
        _headIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectW(self), CGRectH(self)/3*2)];
        _headIV.image = self.isMan?MImage(@"man"):MImage(@"woman");
    }
    return _headIV;
}

-(UILabel *)nameLB{
    if (!_nameLB) {
        _nameLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectH(self)/3*2, CGRectW(self), CGRectH(self)/5)];
        _nameLB.textAlignment = NSTextAlignmentCenter;
        _nameLB.font = MFont(12);
        _nameLB.text = @"姓名";
    }
    return _nameLB;
}

-(UILabel *)relationLB{
    if (!_relationLB) {
        _relationLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectH(self)/15*13, CGRectW(self), CGRectH(self)/15*2)];
        _relationLB.textAlignment = NSTextAlignmentCenter;
        _relationLB.font = MFont(9);
        _relationLB.text = @"(关系)";
    }
    return _relationLB;
}
@end
