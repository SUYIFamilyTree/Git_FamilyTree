//
//  RollDetailView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/15.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "RollDetailView.h"
@interface RollDetailView()
{
    NSArray *_leftArr;
    NSArray *_rightArr;
}
@end

@implementation RollDetailView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
#pragma mark *** 初始化数据 ***
-(void)initData{
    _leftArr = @[@"姓名：",@"名族：",@"出生地：",@"妻子：",@"养子："];
    _rightArr = @[@"段正淳",@"白族",@"大理",@"刀白凤",@"段誉"];
}
#pragma mark *** 初始化界面 ***
-(void)initUI{
    //左边信息
    for (int idx = 0; idx<_leftArr.count; idx++) {
        NSInteger length = ((NSString *)_leftArr[idx]).length;
        UILabel *leftLB = [[UILabel alloc] initWithFrame:AdaptationFrame(16, 16, length*50, 30+idx*60)];
        leftLB.font = MFont(22*AdaptationWidth());
        leftLB.text = _leftArr[idx];
        
        
        NSInteger length2 = ((NSString *)_rightArr[idx]).length;
        UILabel *rightLb = [[UILabel alloc] initWithFrame:AdaptationFrame(CGRectXW(leftLB), 16, length2*50, 30+idx*60)];
        rightLb.text = _rightArr[idx];
        rightLb.font = leftLB.font;
        
        [self addSubview:leftLB];
        [self addSubview:rightLb];
        
    }
    
    //右边头像和代数
    UIImageView *headView = [[UIImageView alloc] initWithFrame:AdaptationFrame(272, 15, 134, 149)];
    headView.image = MImage(@"news_touxiang");
    [self addSubview:headView];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(headView.frame.origin.x, CGRectYH(headView), headView.bounds.size.width, 30*AdaptationWidth())];
    nameLabel.textAlignment = 1;
    nameLabel.font = MFont(25*AdaptationWidth());
    nameLabel.text = @"段正淳";
    [self addSubview:nameLabel];
    
    UILabel *genLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectXW(headView)+15*AdaptationWidth(), headView.frame.origin.y, 36*AdaptationWidth(), headView.bounds.size.height)];
    genLabel.font = MFont(25*AdaptationWidth());
    genLabel.textAlignment = 1;
    genLabel.text = [NSString verticalStringWith:@"第一代"];
    genLabel.layer.cornerRadius = 18*AdaptationWidth();
    genLabel.clipsToBounds = YES;
    genLabel.numberOfLines = 0;
    genLabel.textColor = [UIColor whiteColor];
    genLabel.backgroundColor = LH_RGBCOLOR(59, 59, 59);
    [self addSubview:genLabel];
    
}
@end
