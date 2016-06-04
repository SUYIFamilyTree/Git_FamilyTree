//
//  PersonalCenterViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/24.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "CommonNavigationViews.h"
#import "PersonalCenterHeaderView.h"
#import "PersonalCenterInfoView.h"
#import "PersonalCenterNumerologyView.h"
@interface PersonalCenterViewController ()<PersonalCenterHeaderViewDelegate>
/** 全屏滚动*/
@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    CommonNavigationViews *navi = [[CommonNavigationViews alloc]initWithFrame:CGRectMake(0, 0, Screen_width, 64) title:@"小雪" image:MImage(@"chec")];
    [navi.leftBtn setImage:MImage(@"human_write") forState:UIControlStateNormal];
    [navi.leftBtn setTitle:@"VIP3" forState:UIControlStateNormal];
    navi.leftBtn.titleLabel.font = MFont(14);
    CGRect frame =navi.leftBtn.frame;
    frame.size.width = 100;
    navi.leftBtn.frame = frame;
    [navi.leftBtn addTarget:self action:@selector(clickVipBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navi];
    
    [self.view addSubview:self.scrollView];
    //添加背景图
    UIImageView *bgIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height*2)];
    bgIV.image = MImage(@"human_bg");
    [self.scrollView addSubview:bgIV];
    //添加头部视图
    PersonalCenterHeaderView *headerView = [[PersonalCenterHeaderView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, 0.062*Screen_height)];
    headerView.delegate = self;
    [self.scrollView addSubview:headerView];
    //切换家谱及头像视图
    PersonalCenterInfoView *infoView = [[PersonalCenterInfoView alloc]initWithFrame:CGRectMake(0, CGRectYH(headerView), Screen_width, 0.3636*Screen_height)];
    [self.scrollView addSubview:infoView];
    //命理视图
    PersonalCenterNumerologyView *numerologyView = [[PersonalCenterNumerologyView alloc]initWithFrame:CGRectMake(0.0418*Screen_width, CGRectYH(infoView), 0.9164*Screen_width, 0.3511*Screen_height)];
    [self.scrollView addSubview:numerologyView];
    
}

#pragma mark - lazyLoad
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height)];
        _scrollView.contentSize = CGSizeMake(Screen_width, Screen_height*2);
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

//点击vip按钮
-(void)clickVipBtn:(UIButton *)sender{
    MYLog(@"点击vip");
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - PersonalCenterHeaderViewDelegate
-(void)clickMoneyViewToPay{
    //跳转支付页面
    MYLog(@"跳转支付页面");
}

-(void)clickSameCityMoneyViewToPay{
    //跳转同城币支付页面
    MYLog(@"跳转同城币支付页面");
}
@end
