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
#import "EditPersonalInfoView.h"
#import "MemallInfoModel.h"
#import "LoginModel.h"

@interface PersonalCenterViewController ()<PersonalCenterHeaderViewDelegate,PersonalCenterTodayFortuneViewDelegate,UITableViewDataSource,UITableViewDelegate,PersonalCenterMyPhotoAlbumsViewDelegate,PayForFortuneViewDelegate,PayForForeverFortuneViewDelegate,VIPViewDelegate>
/** 全屏滚动*/
@property (nonatomic, strong) UIScrollView *scrollView;
/** 导航栏*/
@property (nonatomic, strong) CommonNavigationViews *navi;
/** 头部视图*/
@property (nonatomic, strong) PersonalCenterHeaderView *headerView;
/** 切换家谱及头像视图*/
@property (nonatomic, strong) PersonalCenterInfoView *infoView;
/** 命理视图*/
@property (nonatomic, strong) PersonalCenterNumerologyView *numerologyView;
/** 今日运势视图*/
@property (nonatomic, strong) PersonalCenterTodayFortuneView *todayFortuneView;
/** 求签祈福视图*/
@property (nonatomic, strong)PersonalCenterCliffordView *cliffordView;
/** 家族动态表视图*/
@property (nonatomic, strong) UITableView *familyTreeNewsTB;
/** 个人相册视图*/
@property (nonatomic, strong) PersonalCenterMyPhotoAlbumsView *myPhotoAlbumsView;

/** 登录个人信息模型*/
@property (nonatomic, strong) LoginModel *loginModel;
/** 个人中心模型*/
@property (nonatomic, strong) MemallInfoModel *memallInfo;
/** 虔诚度模型*/
@property (nonatomic, strong) DevoutModel *devoutModel;


/** 家族动态数组*/
@property (nonatomic, strong) NSArray *familyTreeNewsArr;
/** vip视图*/
@property (nonatomic, strong) VIPView *vipView;
/** 导航栏vip按钮*/
@property (nonatomic, strong) UIButton *vipBtn;

/** 个人信息编辑页面*/
@property (nonatomic, strong) EditPersonalInfoView *editPersonalInfoView;


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
    
    //初始化界面
    [self initMainView];
    
}

-(void)getNaviData{
    NSDictionary *logDic = @{@"user":[USERDEFAULT valueForKey:UserAccount],@"pass":[USERDEFAULT valueForKey:UserPassword]};
    WK(weakSelf)
    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:@0 requestcode:kRequestCodeLogin success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            weakSelf.loginModel = [LoginModel modelWithJSON:jsonDic[@"data"]];
            //昵称
            [USERDEFAULT setObject:weakSelf.loginModel.memb.MeNickname forKey:@"MeNickname"];
            //vip等级
            [USERDEFAULT setObject:@(weakSelf.loginModel.memb.MeViplevel) forKey:@"MeViplevel"];
            
            
            [weakSelf initNaviData];
            [weakSelf.editPersonalInfoView reloadEditPersonalInfoData:weakSelf.loginModel];
        }else{
            
        }
    } failure:^(NSError *error) {
        MYLog(@"失败---%@",error.description);
    }];

}

-(void)getMainData{
    NSDictionary *logDic = @{@"userid":[NSString stringWithFormat:@"%@",GetUserId]};
    WK(weakSelf)
    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:GetUserId requestcode:kRequestCodeGetMemallInfo success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        [SXLoadingView showProgressHUD:@"正在加载" duration:0.5];
        if (succe) {
            weakSelf.memallInfo = [MemallInfoModel modelWithJSON:jsonDic[@"data"]];
            [weakSelf initNaviData];
            [weakSelf initMainData];
            [SXLoadingView hideProgressHUD];
        }else{
            [SXLoadingView showProgressHUD:jsonDic[@"message"] duration:0.5];
        }
    } failure:^(NSError *error) {
        MYLog(@"失败---%@",error.description);
    }];
    
    
//    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:GetUserId requestcode:@"getdevout" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
//        if (succe) {
//            MYLog(@"虔诚度%@",jsonDic);
//            //self.cliffordView reloadData:
//            
//        }else{
//            [SXLoadingView showProgressHUD:jsonDic[@"message"] duration:1];
//        }
//    } failure:^(NSError *error) {
//        MYLog(@"失败---%@",error.description);
//    }];

}

    
#pragma mark - 视图初始化
-(void)initNavi{
    self.navigationController.navigationBarHidden = YES;
    self.navi = [[CommonNavigationViews alloc]initWithFrame:CGRectMake(0, 0, Screen_width, 64) title:@"" image:MImage(@"chec")];
    self.navi.leftBtn.hidden = YES;
    UIButton *personalInfoEditBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 20, 20)];
    
    [personalInfoEditBtn setBackgroundImage:MImage(@"gr_ct_tit_wt") forState:UIControlStateNormal];
    [personalInfoEditBtn addTarget:self action:@selector(clickPersonalInfoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.navi addSubview:personalInfoEditBtn];
    self.vipBtn = [[UIButton alloc]init];
    NSString *vipLevelStr = [NSString stringWithFormat:@"VIP%@",[USERDEFAULT valueForKey:@"MeViplevel"]];
    [self.vipBtn setTitle:vipLevelStr forState:UIControlStateNormal];
    self.vipBtn.titleLabel.font = MFont(15);
    [self.vipBtn addTarget:self action:@selector(clickVipBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.navi addSubview:self.vipBtn];
    self.vipBtn.sd_layout.leftSpaceToView(personalInfoEditBtn,5).bottomSpaceToView(self.navi,15).widthIs(35).heightIs(15);
    [self.view addSubview:self.navi];

}

-(void)initMainView{
    //添加头部视图
    self.headerView = [[PersonalCenterHeaderView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, 33)];
    self.headerView.delegate = self;
    [self.view addSubview:self.headerView];
    //切换家谱及头像视图
    self.infoView = [[PersonalCenterInfoView alloc]initWithFrame:CGRectMake(0, 33, Screen_width, 138)];
    [self.scrollView addSubview:self.infoView];
    //命理视图
    self.numerologyView = [[PersonalCenterNumerologyView alloc]initWithFrame:CGRectMake(0, CGRectYH(self.infoView), Screen_width, 175)];
    [self.scrollView addSubview:self.numerologyView];
    //今日运势视图
    self.todayFortuneView = [[PersonalCenterTodayFortuneView alloc]initWithFrame:CGRectMake(0.0406*Screen_width, CGRectYH(self.numerologyView), 0.4469*Screen_width, 119)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ToFortuneTodayView)];
    [self.todayFortuneView addGestureRecognizer:tap];
    self.todayFortuneView.delegate = self;
    [self.scrollView addSubview:self.todayFortuneView];
    //求签祈福
    self.cliffordView = [[PersonalCenterCliffordView alloc]initWithFrame:CGRectMake(0.5156*Screen_width, CGRectY(self.todayFortuneView), 0.4469*Screen_width, 119)];
    [self.scrollView addSubview:self.cliffordView];
    //家族动态
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectYH(self.cliffordView), Screen_width, 40)];
    [self.scrollView addSubview:tableHeaderView];
    UILabel *familyTreeNewsLB = [[UILabel alloc]initWithFrame:CGRectMake(22, 17, 60, 15)];
    familyTreeNewsLB.text = @"家族动态";
    familyTreeNewsLB.font = MFont(14);
    [tableHeaderView addSubview:familyTreeNewsLB];
    self.familyTreeNewsTB = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectYH(tableHeaderView), Screen_width, 88)];
    self.familyTreeNewsTB.backgroundColor = [UIColor clearColor];
    self.familyTreeNewsTB.bounces = NO;
    self.familyTreeNewsTB.dataSource = self;
    self.familyTreeNewsTB.delegate = self;
    [self.scrollView addSubview:self.familyTreeNewsTB];
    //我的相册
    self.myPhotoAlbumsView = [[PersonalCenterMyPhotoAlbumsView alloc]initWithFrame:CGRectMake(0, CGRectYH(self.familyTreeNewsTB)+15, Screen_width, 150)];
    self.myPhotoAlbumsView.delegate = self;
    [self.scrollView addSubview:self.myPhotoAlbumsView];

    
}
//导航栏数据刷新
-(void)initNaviData{
    //导航栏数据
    self.navi.titleLabel.text = [USERDEFAULT valueForKey:@"MeNickname"];
    NSString *vipLevelStr = [NSString stringWithFormat:@"VIP%@",[USERDEFAULT valueForKey:@"MeViplevel"]];
    [self.vipBtn setTitle:vipLevelStr forState:UIControlStateNormal];
}
//主界面数据刷新
-(void)initMainData{
    //让金额为登录请求返回的值
    self.headerView.money =  [[USERDEFAULT valueForKey:@"MeBalance"] doubleValue];
    self.headerView.sameCityMoney = [[USERDEFAULT valueForKey:@"MeIntegral"] intValue];
    //会员家谱数据
    [self.infoView reloadData:self.memallInfo.hyjp];
    //命理数据
    [self.numerologyView reloadData:self.memallInfo.scbz];
    //今日运势数据
    [self.todayFortuneView reloadData:self.memallInfo.grys];
    //求签数据
    [self.cliffordView reloadData:self.memallInfo.grqw];
    //家族动态数据
    [self.familyTreeNewsTB reloadData];
    //个人相册数据
    [self.myPhotoAlbumsView reloadData:self.memallInfo.grxc];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    //界面出现就重新加载数据
    [self getMainData];
    [self getNaviData];
}

//点击个人信息编辑
-(void)clickPersonalInfoBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    MYLog(@"点击个人信息编辑");
    WK(weakSelf)
    if (!sender.selected) {
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.editPersonalInfoView.frame = CGRectMake(0,64,0,Screen_height-49-64);
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.editPersonalInfoView removeFromSuperview];
        });
        
    }
    
    
    NSDictionary *logDic = @{@"user":[USERDEFAULT valueForKey:UserAccount],@"pass":[USERDEFAULT valueForKey:UserPassword]};
    
    if (sender.selected) {
        
        [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:@0 requestcode:kRequestCodeLogin success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                weakSelf.loginModel = [LoginModel modelWithJSON:jsonDic[@"data"]];
                weakSelf.editPersonalInfoView = [[EditPersonalInfoView alloc]initWithFrame:CGRectMake(0, 64, 0, Screen_height-49-64)];
                [self.view addSubview:self.editPersonalInfoView];
                [weakSelf.editPersonalInfoView reloadEditPersonalInfoData:weakSelf.loginModel];
                
                [UIView animateWithDuration:0.5 animations:^{
                    weakSelf.editPersonalInfoView.frame = CGRectMake(0, 64, Screen_width, Screen_height-49-64);
                }];
                
                
            }else{
                
            }
        } failure:^(NSError *error) {
            MYLog(@"失败---%@",error.description);
        }];
        
    };
    
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





#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.memallInfo.jzdt.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.memallInfo.jzdt[indexPath.row].artitle;
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


-(VIPView *)vipView{
    if (!_vipView) {
        _vipView = [[VIPView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height-64-49)];
        _vipView.delegate = self;
    }
    return _vipView;
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
