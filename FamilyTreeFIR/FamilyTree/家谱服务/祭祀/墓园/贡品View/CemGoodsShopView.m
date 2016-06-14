//
//  CemGoodsShopView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/13.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "CemGoodsShopView.h"
#import "AllGoodsView.h"
@interface CemGoodsShopView()

@end
@implementation CemGoodsShopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initUI];
    }
    return self;
}

#pragma mark *** 初始化数据 ***
-(void)initData{
    
}
#pragma mark *** 初始化界面 ***
-(void)initUI{
    //背景
    
    UIView *halfBlackView = [[UIView alloc] initWithFrame:self.bounds];
    halfBlackView.backgroundColor = [UIColor blackColor];
    halfBlackView.alpha = 0.75;
    [self addSubview:halfBlackView];
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 72*AdaptationWidth(), Screen_width-40, 842*AdaptationWidth())];
    backImage.image = MImage(@"ghg_bg");
    backImage.userInteractionEnabled = YES;
    [self addSubview:backImage];
    //确定和返回按钮
    NSArray *name = @[@"确定",@"返回"];
    for (int idx = 0; idx<name.count; idx++) {
        UIButton *clicBtn = [UIButton new];
        [clicBtn setBackgroundColor:[UIColor redColor]];
        if (idx==1) {
            [clicBtn setBackgroundColor:LH_RGBCOLOR(74, 88, 94)];
        }
        [clicBtn setTitle:name[idx] forState:0];
        clicBtn.layer.cornerRadius = 2;
        clicBtn.tag = idx;
        clicBtn.titleLabel.font = MFont(30*AdaptationWidth());
        [clicBtn addTarget:self action:@selector(respondsTogoodsBtn:) forControlEvents:UIControlEventTouchUpInside];
        [backImage addSubview:clicBtn];
        clicBtn.sd_layout.leftSpaceToView(backImage,130*AdaptationWidth()+idx*232*AdaptationWidth()).bottomSpaceToView(backImage,70*AdaptationWidth()).widthIs(160*AdaptationWidth()).heightIs(61*AdaptationWidth());
    }
    
    //贡品
    
   
    
    AllGoodsView *singleGoods = [[AllGoodsView alloc ] initWithFrame:AdaptationFrame(60, 60, 520, 618)];
    [backImage addSubview:singleGoods];
    
}

-(void)respondsTogoodsBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
        {
            [self removeFromSuperview];
        }
            break;
        case 1:
        {
            [self removeFromSuperview];
        }
            break;
        default:
            break;
    }
}


@end
