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

/**model*/
@property (nonatomic,strong) RankingModel *model;

@end

@implementation RankingViewController

-(instancetype)initWithTitle:(NSString *)title image:(UIImage *)image model:(RankingModel *)rankModel{
    self = [super initWithTitle:title image:image];
    if (self) {
        self.model = rankModel;
    }
    return self;
}

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
    if (self.model.myzxr) {
        Myzxr *myZhi = self.model.myzxr;
        _monthStarV.surnameLb.text = myZhi.jpm;
        _monthStarV.generationLb.text = [NSString stringWithFormat:@"第%@代",[NSString translation:(int)myZhi.ds]];
        _monthStarV.nameLb.text = myZhi.mz;
        _monthStarV.characterLb.text = [NSString stringWithFormat:@"字辈 %@",myZhi.zb];
        _monthStarV.rankingLb.text = [NSString stringWithFormat:@"排行 %ld.",myZhi.ph];
#warning 头像路径有问题
        _monthStarV.headIV.imageURL = [NSURL URLWithString:myZhi.tx];
    }
    if (self.model.lsmyzxr && self.model.lsmyzxr.count!=0) {
        _monthStarV.dataArr = self.model.lsmyzxr;
    }
    
    _rankingV = [[RankingView alloc]initWithFrame:CGRectMake(15, CGRectYH(_monthStarV)+10, __kWidth-30, 235)];
    [backV addSubview:_rankingV];
    _rankingV.topNameLb.text = @"陈一";
    _rankingV.topScoreLb.text = @"100";
    _rankingV.secondNameLb.text = @"孙二";
    _rankingV.secondScoreLb.text = @"90";
    _rankingV.thirdNameLb.text = @"";
    _rankingV.thirdScoreLb.text = @"";
    if (self.model.lsmyzxr && self.model.lsmyzxr.count>1) {
        NSArray<Lsmyzxr *>*las = self.model.lsmyzxr;
        _rankingV.topNameLb.text =  self.model.myzxr.mz;
        _rankingV.topScoreLb.text = @"2016-06";
        _rankingV.secondNameLb.text = las[0].xm;
        _rankingV.secondScoreLb.text = las[0].yf;
        _rankingV.thirdNameLb.text = las[1].xm;
        _rankingV.thirdScoreLb.text = las[1].xm;
    }
    
    _typerankV = [[TypeRankingView alloc]initWithFrame:CGRectMake(15, CGRectYH(_rankingV)+10, __kWidth-30, 285)];
    [backV addSubview:_typerankV];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
