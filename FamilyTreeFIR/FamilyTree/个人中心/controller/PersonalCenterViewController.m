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
#import "PersonalCenterTodayFortuneView.h"
#import "PersonalCenterCliffordView.h"
#import "PersonalCenterMyPhotoAlbumsView.h"
#import "PayForFortuneView.h"
#import "PayForForeverFortuneView.h"
#import "RechargeViewController.h"
#import "FortuneTodayViewController.h"
#import "SettlementCenterViewController.h"
#import "VIPView.h"
#import "EditHeadView.h"


@interface PersonalCenterViewController ()<PersonalCenterHeaderViewDelegate,PersonalCenterTodayFortuneViewDelegate,UITableViewDataSource,UITableViewDelegate,PersonalCenterMyPhotoAlbumsViewDelegate,PayForFortuneViewDelegate,PayForForeverFortuneViewDelegate,VIPViewDelegate>
/** 全屏滚动*/
@property (nonatomic, strong) UIScrollView *scrollView;
/** 家族动态*/
@property (nonatomic, strong) NSArray *familyTreeNewsArr;
/** vip视图*/
@property (nonatomic, strong) VIPView *vipView;
/** 导航栏vip按钮*/
@property (nonatomic, strong) UIButton *vipBtn;
/** 切换家谱及头像视图*/
@property (nonatomic, strong) PersonalCenterInfoView *infoView;
@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    
    [self.view addSubview:self.scrollView];
    //添加背景图
    UIImageView *bgIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, 780)];
    bgIV.image = MImage(@"gr_ct_bg");
    [self.scrollView addSubview:bgIV];
    //添加背景模糊视图
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, 33)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.alpha = 0.8;
    [self.view addSubview:bgView];
    //添加头部视图
    PersonalCenterHeaderView *headerView = [[PersonalCenterHeaderView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, 33)];
    headerView.delegate = self;
    [self.view addSubview:headerView];
    //切换家谱及头像视图
    self.infoView = [[PersonalCenterInfoView alloc]initWithFrame:CGRectMake(0, 33, Screen_width, 138)];
    [self.scrollView addSubview:self.infoView];
    //命理视图
    PersonalCenterNumerologyView *numerologyView = [[PersonalCenterNumerologyView alloc]initWithFrame:CGRectMake(0, CGRectYH(self.infoView), Screen_width, 175)];
    [self.scrollView addSubview:numerologyView];
    //今日运势视图
    PersonalCenterTodayFortuneView *todayFortuneView = [[PersonalCenterTodayFortuneView alloc]initWithFrame:CGRectMake(0.0406*Screen_width, CGRectYH(numerologyView), 0.4469*Screen_width, 119)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ToFortuneTodayView)];
    [todayFortuneView addGestureRecognizer:tap];
    todayFortuneView.delegate = self;
    [self.scrollView addSubview:todayFortuneView];
    //求签祈福
    PersonalCenterCliffordView *cliffordView = [[PersonalCenterCliffordView alloc]initWithFrame:CGRectMake(0.5156*Screen_width, CGRectY(todayFortuneView), 0.4469*Screen_width, 119)];
    [self.scrollView addSubview:cliffordView];
    //家族动态
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectYH(cliffordView), Screen_width, 40)];
    [self.scrollView addSubview:tableHeaderView];
    UILabel *familyTreeNewsLB = [[UILabel alloc]initWithFrame:CGRectMake(22, 17, 60, 15)];
    familyTreeNewsLB.text = @"家族动态";
    familyTreeNewsLB.font = MFont(14);
    [tableHeaderView addSubview:familyTreeNewsLB];
    UITableView *familyTreeNewsTB = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectYH(tableHeaderView), Screen_width, 88)];
    familyTreeNewsTB.backgroundColor = [UIColor clearColor];
    familyTreeNewsTB.bounces = NO;
    familyTreeNewsTB.dataSource = self;
    familyTreeNewsTB.delegate = self;
    [self.scrollView addSubview:familyTreeNewsTB];
    //我的相册
    PersonalCenterMyPhotoAlbumsView *myPhotoAlbumsView = [[PersonalCenterMyPhotoAlbumsView alloc]initWithFrame:CGRectMake(0, CGRectYH(familyTreeNewsTB)+15, Screen_width, 150)];
    myPhotoAlbumsView.delegate = self;
    [self.scrollView addSubview:myPhotoAlbumsView];

}

#pragma mark - 视图初始化
-(void)initNavi{
    self.navigationController.navigationBarHidden = YES;
    CommonNavigationViews *navi = [[CommonNavigationViews alloc]initWithFrame:CGRectMake(0, 0, Screen_width, 64) title:@"小雪" image:MImage(@"chec")];
    navi.leftBtn.hidden = YES;
    UIButton *personalInfoEditBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 20, 20)];
    
    [personalInfoEditBtn setBackgroundImage:MImage(@"gr_ct_tit_wt") forState:UIControlStateNormal];
    [personalInfoEditBtn addTarget:self action:@selector(clickPersonalInfoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [navi addSubview:personalInfoEditBtn];
    self.vipBtn = [[UIButton alloc]init];
    
    [self.vipBtn setTitle:@"VIP3" forState:UIControlStateNormal];
    self.vipBtn.titleLabel.font = MFont(15);
    [self.vipBtn addTarget:self action:@selector(clickVipBtn:) forControlEvents:UIControlEventTouchUpInside];
    [navi addSubview:self.vipBtn];
    self.vipBtn.sd_layout.leftSpaceToView(personalInfoEditBtn,5).bottomSpaceToView(navi,15).widthIs(35).heightIs(15);
    [self.view addSubview:navi];

}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.familyTreeNewsArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.familyTreeNewsArr[indexPath.row];
    cell.textLabel.font = MFont(12);
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = indexPath.row%2?[UIColor clearColor]:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:0.5];
    cell.textLabel.textColor = LH_RGBCOLOR(118, 118, 118);
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 22;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - lazyLoad
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height-49-64)];
        _scrollView.contentSize = CGSizeMake(Screen_width, 780);
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

-(NSArray *)familyTreeNewsArr{
    if (!_familyTreeNewsArr) {
        _familyTreeNewsArr = @[@"怀宁陈氏，5月31日举办认亲大会",@"怀宁陈氏，5月31日举办认亲大会",@"怀宁陈氏，5月31日举办认亲大会",@"怀宁陈氏，5月31日举办认亲大会",@"怀宁陈氏，5月31日举办认亲大会",@"怀宁陈氏，5月31日举办认亲大会",@"怀宁陈氏，5月31日举办认亲大会",@"怀宁陈氏，5月31日举办认亲大会",@"怀宁陈氏，5月31日举办认亲大会"];
    }
    return _familyTreeNewsArr;
}

-(VIPView *)vipView{
    if (!_vipView) {
        _vipView = [[VIPView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height-64-49)];
        _vipView.delegate = self;
    }
    return _vipView;
}

//点击个人信息编辑
-(void)clickPersonalInfoBtn:(UIButton *)sender{
    MYLog(@"点击个人信息编辑");
}

//点击vip按钮
-(void)clickVipBtn:(UIButton *)sender{
    MYLog(@"点击vip");
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [self.view addSubview:self.vipView];
    }else{
        [self.vipView removeFromSuperview];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - PersonalCenterHeaderViewDelegate
-(void)clickMoneyViewToPay{
    //跳转充值页面
    RechargeViewController *rechargeVC = [[RechargeViewController alloc]init];
    [self.navigationController pushViewController:rechargeVC animated:YES];
}

-(void)clickSameCityMoneyViewToPay{
    //跳转同城币充值页面
    MYLog(@"跳转同城币支付页面");
}

-(void)ToFortuneTodayView{
    FortuneTodayViewController *fortuneTodayVC = [[FortuneTodayViewController alloc]init];
    [self.navigationController pushViewController:fortuneTodayVC animated:YES];
}

#pragma mark - PersonalCenterTodayFortuneViewDelegate
-(void)clickPayForFortuneBtn{
    MYLog(@"跳转续时运势页面");
    PayForFortuneView *payForFortuneView = [[PayForFortuneView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height-64-49)];
    payForFortuneView.delegate = self;
    [self.view addSubview:payForFortuneView];
    
}

#pragma mark - PersonalCenterMyPhotoAlbumsViewDelegate
-(void)clickMoreBtnTo{
    MYLog(@"跳转我的相册");
}

#pragma mark - PayForFortuneViewDelegate
-(void)toPayForForeverFortuneView{
    MYLog(@"跳转续时永久页面");
    PayForForeverFortuneView *payForForeverFortuneView = [[PayForForeverFortuneView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height-64-49)];
    payForForeverFortuneView.delegate = self;
    [self.view addSubview:payForForeverFortuneView];
}

#pragma mark - PayForForeverFortuneViewDelegate
-(void)clickPayForForeverFortuneSure{
    SettlementCenterViewController *settlementCenterVC = [[SettlementCenterViewController alloc]init];
    [self.navigationController pushViewController:settlementCenterVC animated:YES];
}

#pragma mark - VIPViewDelegate
-(void)clickVipBackBtn{
    self.vipBtn.selected = NO;
}

@end
