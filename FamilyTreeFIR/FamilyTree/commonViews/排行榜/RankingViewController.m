//
//  RankingViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/7/22.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "RankingViewController.h"
#import "MonthStarView.h"
#import "RankingView.h"
#import "TypeRankingView.h"
@interface RankingViewController ()
@property (strong,nonatomic) MonthStarView *monthStarV;//每月之星视图

@property (strong,nonatomic) RankingView *rankingV;//排行榜视图

@property (strong,nonatomic) TypeRankingView *typerankV;//种类排行榜视图
@end

@implementation RankingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"排行榜";
    self.automaticallyAdjustsScrollViewInsets = false;
    
    
    [self initView];
}

- (void)initView{
    UIScrollView *backV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-114)];
    [self.view addSubview:backV];
    backV.scrollEnabled = YES;
    backV.backgroundColor = [UIColor whiteColor];
    backV.contentSize = CGSizeMake(__kWidth, 900);
    UIImageView *backIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kWidth,800)];
    [backV addSubview:backIV];
    backIV.image = [UIImage imageNamed:@"back"];
    
    _monthStarV = [[MonthStarView alloc]initWithFrame:CGRectMake(15, 10, __kWidth-30, (__kWidth-30)/33*25)];
    [backV addSubview:_monthStarV];
    _monthStarV.surnameLb.text = @"蚌埠王氏";
    _monthStarV.generationLb.text = @"第十三代";
    _monthStarV.nameLb.text = @"王二麻子";
    _monthStarV.characterLb.text = @"字辈 麻";
    _monthStarV.rankingLb.text = @"排行 2.";
    
    _rankingV = [[RankingView alloc]initWithFrame:CGRectMake(15, CGRectYH(_monthStarV)+10, __kWidth-30, 235)];
    [backV addSubview:_rankingV];
    _rankingV.topNameLb.text = @"陈一";
    _rankingV.topScoreLb.text = @"100";
    _rankingV.secondNameLb.text = @"孙二";
    _rankingV.secondScoreLb.text = @"90";
    _rankingV.thirdNameLb.text = @"王三";
    _rankingV.thirdScoreLb.text = @"80";
    
    _typerankV = [[TypeRankingView alloc]initWithFrame:CGRectMake(15, CGRectYH(_rankingV)+10, __kWidth-30, 285)];
    [backV addSubview:_typerankV];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
