//
//  EditHeadView.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/13.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "EditHeadView.h"
#import "HeadImageView.h"

@interface EditHeadView()
/** 中间背景框*/
@property (nonatomic, strong) UIImageView *bgIV;
/** 头像预览*/
@property (nonatomic, strong) HeadImageView *headIV;
/** 头像数组*/
@property (nonatomic, strong) NSMutableArray<NSString *> *headStrArr;
@end


@implementation EditHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        //设置背景图
        self.bgIV = [[UIImageView alloc]initWithFrame:CGRectMake(0.04375*CGRectW(self), 0.2989*CGRectH(self), 0.9125*CGRectW(self), 0.5692*CGRectH(self))];
        self.bgIV.image = MImage(@"xiuGaitouxiang_bg");
        self.bgIV.userInteractionEnabled = YES;
        [self addSubview:self.bgIV];
        //返回按钮
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0.9*CGRectW(self.bgIV), 0, 0.1*CGRectW(self.bgIV), 0.1*CGRectH(self.bgIV))];
        backBtn.backgroundColor = [UIColor redColor];
        [backBtn addTarget:self action:@selector(clickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgIV addSubview:backBtn];
        
        //头像预览
        [self initHeadIV];
        
        //选择头像
        self.headStrArr = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            [self.headStrArr addObject:@"xiuGaitouxiang_sel1"];
            [self.headStrArr addObject:@"xiuGaitouxiang_sel2"];
            [self.headStrArr addObject:@"xiuGaitouxiang_sel3"];
            [self.headStrArr addObject:@"xiuGaitouxiang_sel4"];
        }
        [self initChooseHead];
        
        //自定义与相框选择按钮
        [self initCustomAndChooseBorderBtn];
        
        //vip解锁进度
        [self initVipUnlockProgressView];

    }
    return self;
}

-(void)initHeadIV{
    self.headIV = [[HeadImageView alloc]initWithFrame:CGRectMake(0.0616*CGRectW(self.bgIV), 0.0772*CGRectH(self.bgIV), 0.2397*CGRectW(self.bgIV), 0.2703*CGRectH(self.bgIV))];
    [self.bgIV addSubview:self.headIV];
}

-(void)initChooseHead{
    for (int i = 0; i < 12; i++) {
        UIButton *headBtn = [[UIButton alloc]initWithFrame:CGRectMake(0.3630*CGRectW(self.bgIV)+0.1473*CGRectW(self.bgIV)*(i-4*[@[@0,@1,@2][i/4] intValue]), 0.0927*CGRectH(self.bgIV)+0.1506*CGRectH(self.bgIV)*[@[@0,@1,@2][i/4] intValue], 0.1164*CGRectW(self.bgIV), 0.1158*CGRectH(self.bgIV))];
        [headBtn setBackgroundImage:MImage(self.headStrArr[i]) forState:UIControlStateNormal];
        headBtn.tag = 555+i;
        [headBtn addTarget:self action:@selector(chooseHeadBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgIV addSubview:headBtn];
    }
    
    
}

-(void)initCustomAndChooseBorderBtn{
    UIButton *customBtn = [[UIButton alloc]initWithFrame:CGRectMake(0.0890*CGRectW(self.bgIV), 0.3840*CGRectH(self.bgIV), 0.1713*CGRectW(self.bgIV), 0.0772*CGRectH(self.bgIV))];
    [customBtn setTitle:@"自定义" forState:UIControlStateNormal];
    [customBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    customBtn.titleLabel.font = MFont(11);
    customBtn.backgroundColor = LH_RGBCOLOR(219, 222, 220);
    customBtn.layer.cornerRadius = 3.0;
    [customBtn addTarget:self action:@selector(clickCustomBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgIV addSubview:customBtn];
    
    UIButton *ChooseBorderBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectX(customBtn), 0.4981*CGRectH(self.bgIV), CGRectW(customBtn), CGRectH(customBtn))];
    [ChooseBorderBtn setTitle:@"相框选择" forState:UIControlStateNormal];
    [ChooseBorderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ChooseBorderBtn.titleLabel.font = MFont(11);
    ChooseBorderBtn.backgroundColor = LH_RGBCOLOR(219, 222, 220);
    ChooseBorderBtn.layer.cornerRadius = 3.0;
    [ChooseBorderBtn addTarget:self action:@selector(clickChooseBorderBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgIV addSubview:ChooseBorderBtn];
}

-(void)initVipUnlockProgressView{
    //图
    UIImageView *unlockIV = [[UIImageView alloc]initWithFrame:CGRectMake(0.0822*CGRectW(self.bgIV), 0.6178*CGRectH(self.bgIV), 0.8288*CGRectW(self.bgIV), 0.1506*CGRectH(self.bgIV))];
    unlockIV.image = MImage(@"xiuGaitouxiang_ji");
    [self.bgIV addSubview:unlockIV];
    //文字描述
    NSArray *detailArr = @[@"普通用户",@"VIP1-5",@"VIP6-8",@"每月之星"];
    NSArray *unlockStateArr = @[@YES,@YES,@YES,@YES];
    for (int i = 0; i < 4; i++) {
        //因为间距不一样，加代码做调整
        UILabel *detailLB = [[UILabel alloc]init];
        if (i < 2) {
            detailLB.frame = CGRectMake(0.1062*CGRectW(self.bgIV)+0.2192*CGRectW(self.bgIV)*i, 0.7992*CGRectH(self.bgIV), 0.1541*CGRectW(self.bgIV), 0.0656*CGRectH(self.bgIV));
        }else{
            detailLB.frame = CGRectMake(0.1062*CGRectW(self.bgIV)+0.2102*CGRectW(self.bgIV)*i, 0.7992*CGRectH(self.bgIV), 0.1541*CGRectW(self.bgIV), 0.0656*CGRectH(self.bgIV));
        }
        detailLB.text = detailArr[i];
        detailLB.font = MFont(11);
        detailLB.textAlignment = NSTextAlignmentCenter;
        [self.bgIV addSubview:detailLB];
        CGRect frame = detailLB.frame;
        frame.origin.y = frame.origin.y + frame.size.height;
        UILabel *unlockStateLB = [[UILabel alloc]initWithFrame:frame];
        unlockStateLB.text = unlockStateArr[i]?@"已解锁":@"未解锁";
        unlockStateLB.font = MFont(11);
        unlockStateLB.textAlignment = NSTextAlignmentCenter;
        [self.bgIV addSubview:unlockStateLB];
    }
}

-(void)clickBackBtn:(UIButton *)sender{
    //保存设置
    [self.delegate editHeadView:self HeadInsideImage:self.headIV.headInsideIV.image];
    
    [self removeFromSuperview];
}

-(void)clickCustomBtn:(UIButton *)sender{
    MYLog(@"自定义");
}

-(void)clickChooseBorderBtn:(UIButton *)sender{
    MYLog(@"相框选择");
}

-(void)chooseHeadBtn:(UIButton *)sender{
    self.headIV.headInsideIV.image = MImage(self.headStrArr[sender.tag-555]);
    
}
@end
