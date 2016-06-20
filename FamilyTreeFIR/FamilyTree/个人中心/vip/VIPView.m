//
//  VIPView.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/13.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "VIPView.h"
#import "UIView+getCurrentViewController.h"
#import "NSString+arabicToChinese.h"
#import "VIPSelectViewController.h"

@interface VIPView()
/** 中间框*/
@property (nonatomic, strong) UIImageView *bgIV;
/** 当前vip等级*/
@property (nonatomic, assign) int currentVIPLevel;
/** 进度*/
@property (nonatomic, strong) NSString *progressStr;
/** 几天后到期*/
@property (nonatomic, assign) int Deadline;
/** 会员详情数组*/
@property (nonatomic, strong) NSArray<NSString *> *VIPInfoStrArr;
@end

@implementation VIPView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        //设置背景图
        self.bgIV = [[UIImageView alloc]initWithFrame:CGRectMake(0.0469*CGRectW(self), 0.0293*CGRectH(self), 0.9156*CGRectW(self), 0.9385*CGRectH(self))];
        self.bgIV.image = MImage(@"vip_bg");
        self.bgIV.userInteractionEnabled = YES;
        [self addSubview:self.bgIV];
        //加入会员按钮
        [self initAddToVIPBtn];
        //会员等级标签及进度视图
        self.currentVIPLevel = 3;
        self.progressStr = @"400/500";
        self.Deadline = 7;
        [self initVIPProgress];
        //会员详情
        self.VIPInfoStrArr = @[@"论坛版主优先权优于VIP3以下的用户。",
                               @"我需要发布数量1个",
                               @"好友里排名显示前于VIP3以下的用户。",
                               @"每日求签次数1次",
                               @"签到奖励每天14-15同城币",
                               @"贡品清茶、檀香、供油免费",
                               @"昵称金色标识",
                               @"数字家谱专享模板。",
                               @"商城优惠额度95折。",
                               @"每月签文详解名字12次",
                               @"运程免费时间1周",
                               @"动态头像。",];
        [self initVIPInfoLBs];
        //左右箭头翻页
        UIButton *leftBtn =[[UIButton alloc]initWithFrame:CGRectMake(0.0171*CGRectW(self.bgIV), 0.4309*CGRectH(self.bgIV), 0.0785*CGRectW(self.bgIV), 0.0726*CGRectH(self.bgIV))];
        [leftBtn setBackgroundImage:MImage(@"vip_left") forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(clickLeftBtnForLookVIPInfo:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgIV addSubview:leftBtn];
        
        UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0.9113*CGRectW(self.bgIV), CGRectY(leftBtn), CGRectW(leftBtn), CGRectH(leftBtn))];
        [rightBtn setBackgroundImage:MImage(@"vip_right") forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(clickRightBtnForLookVIPInfo:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgIV addSubview:rightBtn];
        
        //关闭按钮
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0.935*CGRectW(self), 0.015*CGRectH(self), 0.05*CGRectW(self), 0.05*CGRectW(self))];
        [backBtn setBackgroundImage:MImage(@"close") forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(clickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
        
    }
    return self;
}

-(void)initAddToVIPBtn{
    UIButton *addToVipBtn = [[UIButton alloc]initWithFrame:CGRectMake(0.1024*CGRectW(self.bgIV), 0.0820*CGRectH(self.bgIV), 0.2526*CGRectW(self.bgIV), 0.0679*CGRectH(self.bgIV))];
    addToVipBtn.backgroundColor = LH_RGBCOLOR(226, 0, 37);
    [addToVipBtn setTitle:@"加入会员" forState:UIControlStateNormal];
    addToVipBtn.layer.cornerRadius = 3.0;
    addToVipBtn.titleLabel.font = MFont(15);
    [addToVipBtn addTarget:self action:@selector(clickAddToVipBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgIV addSubview:addToVipBtn];
}

-(void)initVIPProgress{
   //当前vip等级
    UILabel *currentVIPLevelLB = [[UILabel alloc]initWithFrame:CGRectMake(0.3652*CGRectW(self.bgIV), 0.0890*CGRectH(self.bgIV), 0.1024*CGRectW(self.bgIV), 0.0328*CGRectH(self.bgIV))];
    currentVIPLevelLB.text = [NSString stringWithFormat:@"VIP%d",self.currentVIPLevel];
    currentVIPLevelLB.textColor = [UIColor redColor];
    currentVIPLevelLB.font = MFont(13);
    [self.bgIV addSubview:currentVIPLevelLB];
    
    //进度条
    UIImageView *VIPProgressBgIV = [[UIImageView alloc]initWithFrame:CGRectMake(0.4812*CGRectW(self.bgIV), 0.0890*CGRectH(self.bgIV), 0.3072*CGRectW(self.bgIV), 0.0331*CGRectH(self.bgIV))];
    VIPProgressBgIV.image = MImage(@"vip_jindu");
    [self.bgIV addSubview:VIPProgressBgIV];
    double ratio = 0.8;//进度比例
    UIImageView *VIPProgressRedIV = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, ratio*CGRectW(VIPProgressBgIV)-1, CGRectH(VIPProgressBgIV)-2)];
    VIPProgressRedIV.image = MImage(@"vip_jindu_red");
    [VIPProgressBgIV addSubview:VIPProgressRedIV];
    //进度条文字进度
    UILabel *VIPProgressLB = [[UILabel alloc]initWithFrame:CGRectMake(0.6*CGRectW(VIPProgressBgIV), 0, 0.4*CGRectW(VIPProgressBgIV), CGRectH(VIPProgressBgIV))];
    VIPProgressLB.text = self.progressStr;
    VIPProgressLB.font = MFont(8);
    VIPProgressLB.textAlignment = NSTextAlignmentRight;
    [VIPProgressBgIV addSubview:VIPProgressLB];
    
    //下一个vip等级
    UILabel *nextVIPLevelLB = [[UILabel alloc]initWithFrame:CGRectMake(0.8191*CGRectW(self.bgIV), CGRectY(currentVIPLevelLB), CGRectW(currentVIPLevelLB), CGRectH(currentVIPLevelLB))];
    nextVIPLevelLB.text = [NSString stringWithFormat:@"VIP%d",self.currentVIPLevel+1];
    nextVIPLevelLB.textColor = [UIColor redColor];
    nextVIPLevelLB.font = MFont(13);
    [self.bgIV addSubview:nextVIPLevelLB];

    //到期时间
    UILabel *deadlineLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectX(VIPProgressBgIV), CGRectYH(VIPProgressBgIV), CGRectW(VIPProgressBgIV)+10, 0.0451*CGRectH(self))];
    deadlineLB.text = [NSString stringWithFormat:@"VIP%d%@天后到期",self.currentVIPLevel,[NSString translation:self.Deadline]];
    deadlineLB.font = MFont(11);
    [self.bgIV addSubview:deadlineLB];
    
}

-(void)initVIPInfoLBs{
    for (int i = 0; i < self.VIPInfoStrArr.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0.1024*CGRectW(self.bgIV), 0.1874*CGRectH(self.bgIV)+0.0515*CGRectH(self.bgIV)*i, 0.8*CGRectW(self.bgIV), 0.0515*CGRectH(self.bgIV))];
        label.text = self.VIPInfoStrArr[i];
        label.font = MFont(13);
        label.textColor = LH_RGBCOLOR(118, 126, 124);
        [self.bgIV addSubview:label];
    }
}

-(void)clickAddToVipBtn:(UIButton *)sender{
    VIPSelectViewController *VIPSelectVC = [[VIPSelectViewController alloc]init];
    [[self viewController].navigationController pushViewController:VIPSelectVC animated:YES];
    [self removeFromSuperview];
    
}

-(void)clickLeftBtnForLookVIPInfo:(UIButton *)sender{
    MYLog(@"向前查看vip");
}

-(void)clickRightBtnForLookVIPInfo:(UIButton *)sender{
    MYLog(@"向后查看vip");
}

-(void)clickBackBtn:(UIButton *)sender{
    [self.delegate clickVipBackBtn];
    [self removeFromSuperview];
    
    
}
@end
