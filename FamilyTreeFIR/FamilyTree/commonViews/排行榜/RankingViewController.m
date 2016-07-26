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

/** 初始化 */
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
        if (myZhi.tx&&myZhi.tx.length!=0) {
            _monthStarV.headIV.imageURL = [NSURL URLWithString:myZhi.tx];

        }
    }
    if (self.model.lsmyzxr && self.model.lsmyzxr.count!=0) {
        _monthStarV.dataArr = self.model.lsmyzxr;
    }
    
    _rankingV = [[RankingView alloc]initWithFrame:CGRectMake(15, CGRectYH(_monthStarV)+10, __kWidth-30, 235)];
    [backV addSubview:_rankingV];
    _rankingV.topNameLb.text = @"";
    _rankingV.topScoreLb.text = @"";
    _rankingV.secondNameLb.text = @"";
    _rankingV.secondScoreLb.text = @"";
    _rankingV.thirdNameLb.text = @"";
    _rankingV.thirdScoreLb.text = @"";
    if (self.model.hybr && self.model.hybr.count!=0) {
        NSInteger hyCount = self.model.hybr.count;
        
        if (hyCount==1) {
            Hybr *br = self.model.hybr[0];
            _rankingV.topNameLb.text = br.mz;
            _rankingV.topScoreLb.text = [NSString stringWithFormat:@"%ld",br.hyd];
            if (br.tx&&br.tx.length!=0) {
                _rankingV.topIV.imageURL = [NSURL URLWithString:br.tx];
            }
           
        }else if (hyCount == 2){
            Hybr *br = self.model.hybr[0];
            _rankingV.topNameLb.text = br.mz;
            _rankingV.topScoreLb.text = [NSString stringWithFormat:@"%ld",br.hyd];
            Hybr *br1 = self.model.hybr[1];
            _rankingV.secondNameLb.text = br1.mz;
            _rankingV.secondScoreLb.text = [NSString stringWithFormat:@"%ld",br1.hyd];
            if (br.tx&&br.tx.length!=0) {
                _rankingV.topIV.imageURL = [NSURL URLWithString:br.tx];
            }
            if (br1.tx&&br1.tx.length!=0) {
                _rankingV.secondIV.imageURL = [NSURL URLWithString:br1.tx];
            }
        }else{
            Hybr *br = self.model.hybr[0];
            _rankingV.topNameLb.text = br.mz;
            _rankingV.topScoreLb.text = [NSString stringWithFormat:@"%ld",br.hyd];
            Hybr *br1 = self.model.hybr[1];
            _rankingV.secondNameLb.text = br1.mz;
            _rankingV.secondScoreLb.text = [NSString stringWithFormat:@"%ld",br1.hyd];
            Hybr *br2 = self.model.hybr[2];
            _rankingV.thirdNameLb.text = br2.mz;
            _rankingV.thirdScoreLb.text = [NSString stringWithFormat:@"%ld",br2.hyd];
            
            if (br.tx&&br.tx.length!=0) {
                _rankingV.topIV.imageURL = [NSURL URLWithString:br.tx];
            }
            if (br1.tx&&br1.tx.length!=0) {
                _rankingV.secondIV.imageURL = [NSURL URLWithString:br1.tx];
            }
            if (br2.tx&&br2.tx.length!=0) {
                _rankingV.thirdIV.imageURL = [NSURL URLWithString:br2.tx];
            }
            
        }
    }
    
    _typerankV = [[TypeRankingView alloc]initWithFrame:CGRectMake(15, CGRectYH(_rankingV)+10, __kWidth-30, 285) data:self.model];
    _typerankV.dataRank = self.model;
    [backV addSubview:_typerankV];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
