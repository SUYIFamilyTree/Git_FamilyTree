//
//  HomeViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/24.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "HomeViewController.h"
#import "Tools.h"
#import "DivinationViewController.h"
#import "LineView.h"

typedef enum : NSUInteger {
    HomePersonal,
    HomeLuctScore,
    HomeLinQian,
    HomeFameTree,
    HomeNameSource,
    HomeService
} clickBtnTag;

@interface HomeViewController ()<CommandNavigationViewsDelegate>
{
    NSMutableArray *_ScrImages;
}

@property (nonatomic,strong) CommonNavigationViews *naviBar; /*导航栏*/

@property (nonatomic,strong) ScrollerView *topScrollerView; /*滚动图*/

@property (nonatomic,strong) UILabel *time_StatuLabel; /*丙申年农历*/

@property (nonatomic,strong) LoginViewController *logVc; /*登录Vc*/

@end

@implementation HomeViewController



#pragma mark *** 生命周期 ***

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //先跳转到登录页面
    
    [self.navigationController pushViewController:self.logVc animated:false];
    
    //注册通知
    [self registerNotifacation];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    self.navigationController.navigationBar.hidden = YES;
    [self initData];
    [self initUI];
    [self initBtn];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = false;
}

-(void)registerNotifacation{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondsToNotifacation) name:LogStatusNotifacation object:nil];
    
}
-(void)respondsToNotifacation{
    if ([[USERDEFAULT objectForKey:LoginStates] boolValue]) {
        [_naviBar.rightBtn setTitle:@"切换账号" forState:0];
    }else{
        [_naviBar.rightBtn setTitle:@"登录" forState:0];
        
    }
}
#pragma mark *** 初始化数据 ***
-(void)initData{
    _ScrImages = [@[@"index_lunbo",@"index_icon_fuWu",@"index_icon_human",@"index_icon_s1"] mutableCopy];
}

#pragma mark *** 初始化界面 ***
-(void)initUI{
    [self.view addSubview:self.topScrollerView];
    [self.view addSubview:self.naviBar];
    
    //下半部分背景
    UIImageView *baImg = [UIImageView new];
    baImg.image = MImage(@"index_bg");
    [self.view addSubview:baImg];
    baImg.sd_layout.topSpaceToView(self.topScrollerView,0).rightSpaceToView(self.view,0).bottomSpaceToView(self.tabBarController.tabBar,0).leftSpaceToView(self.view,0);
    
    [self.view addSubview:self.time_StatuLabel];
}


#pragma mark *** BtnEvent ***
-(void)respondsToBtn:(UIButton *)sender{
    switch (sender.tag) {
        case HomePersonal:
        {
            self.tabBarController.selectedIndex = 3;
        }
            break;
        case HomeLuctScore:
        {
            FortuneTodayViewController *fort = [[FortuneTodayViewController alloc] initWithTitle:@"今日运势" image:nil];
            [self.navigationController pushViewController:fort animated:YES];
        }
            break;
        case HomeFameTree:
        {
            self.tabBarController.selectedIndex = 1;
        }
            break;
        case HomeLinQian:
        {
            MYLog(@"灵签");
            DivinationViewController *divVc = [[DivinationViewController alloc] initWithTitle:@"灵签" image:nil];
            [self.navigationController pushViewController:divVc animated:YES];
            
        }
            break;
        case HomeService:
        {
            FamilServiceViewController *fam = [FamilServiceViewController new];
            [self.navigationController pushViewController:fam animated:YES];
        }
            break;
        case HomeNameSource:
        {
            MYLog(@"姓氏起源");
            NewsCenterViewController *newCenter = [[NewsCenterViewController alloc] initWithTitle:@"新闻中心" image:nil];
            newCenter.bacScrollView.contentOffset = CGPointMake(0, newCenter.hundredVies.frame.origin.y-375*AdaptationWidth());
            [self.navigationController pushViewController:newCenter animated:true];
        }
            break;
            
        default:
            break;
    }
}
//导航栏按钮
-(void)CommonNavigationViews:(CommonNavigationViews *)comView respondsToRightBtn:(UIButton *)sender{
    
    MYLog(@"登录按钮");
    [self.navigationController pushViewController:self.logVc animated:YES];
    
  
  
    
}

#pragma mark *** 6个btn ***

-(void)initBtn{
    //两个背景btn
    UIButton *bacBtn1 = [[UIButton alloc] initWithFrame:AdaptationFrame(489, (CGRectYH(self.topScrollerView))/AdaptationWidth()+205, 80, 80)];
    bacBtn1.userInteractionEnabled = false;
    [bacBtn1 setImage:MImage(@"index_icon_s2") forState:0];
    UIButton *bacBtn2 = [[UIButton alloc] initWithFrame:AdaptationFrame(276, (CGRectYH(self.topScrollerView))/AdaptationWidth()+550, 55, 55)];
    [bacBtn2 setImage:MImage(@"index_icon_s1") forState:0];
    bacBtn2.userInteractionEnabled = false;
    [self.view addSubview:bacBtn1];
    [self.view addSubview:bacBtn2];
    
    //主要服务btn
    NSValue *rect1 = [NSValue valueWithCGRect:AdaptationFrame(417, (CGRectYH(self.topScrollerView))/AdaptationWidth()+35, 195, 195)];
    NSValue *rect2 = [NSValue valueWithCGRect:AdaptationFrame(85, (CGRectYH(self.topScrollerView))/AdaptationWidth()+125, 195, 195)];
    NSValue *rect3 = [NSValue valueWithCGRect:AdaptationFrame(147, (CGRectYH(self.topScrollerView))/AdaptationWidth()+358, 172, 172)];
    NSValue *rect4 = [NSValue valueWithCGRect:AdaptationFrame(255, (CGRectYH(self.topScrollerView))/AdaptationWidth()+212, 227, 227)];
    NSValue *rect5 = [NSValue valueWithCGRect:AdaptationFrame(457, (CGRectYH(self.topScrollerView))/AdaptationWidth()+563, 117, 117)];
    NSValue *rect6 = [NSValue valueWithCGRect:AdaptationFrame(337, (CGRectYH(self.topScrollerView))/AdaptationWidth()+433, 177, 177)];

    NSArray *rectArr = @[rect1,rect2,rect3,rect4,rect5,rect6];
    NSArray *imageNames = @[@"index_icon_human",@"index_icon_yunShi",@"index_icon_linQian",@"index_icon_jiaPu",@"index_icon_nameQiYuan",@"index_icon_fuWu"];
    
    for (int idx = 0; idx<rectArr.count; idx++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:[rectArr[idx] CGRectValue]];
        btn.tag = idx;
        [btn setImage:MImage(imageNames[idx]) forState:0];
        [btn addTarget:self action:@selector(respondsToBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

#pragma mark *** getters ***

-(ScrollerView *)topScrollerView{
    if (!_topScrollerView) {
        _topScrollerView = [[ScrollerView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, 0.36*Screen_height)images:_ScrImages];
        
    }
    return _topScrollerView;
}

-(CommonNavigationViews *)naviBar{
    if (!_naviBar) {
        _naviBar = [[CommonNavigationViews alloc] initWithFrame:CGRectMake(0, 0, Screen_width, 64) title:@"同城家谱" image:nil];
        [_naviBar.leftBtn setImage:MImage(@"index_logo") forState:0];
        _naviBar.backView.backgroundColor = [UIColor clearColor];
        if ([[USERDEFAULT objectForKey:LoginStates] boolValue]) {
            [_naviBar.rightBtn setTitle:@"切换账号" forState:0];
        }else{
            [_naviBar.rightBtn setTitle:@"登录" forState:0];

        }
        _naviBar.rightBtn.titleLabel.font = MFont(13);
        _naviBar.rightBtn.frame = CGRectMake(CGRectGetMaxX(_naviBar.backView.frame)-70, CGRectGetHeight(_naviBar.backView.bounds)/2-30+StatusBar_Height+10, 60, 25);
        _naviBar.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _naviBar.delegate = self;
        
    }
    return _naviBar;
}

-(UILabel *)time_StatuLabel{
    if (!_time_StatuLabel) {
        _time_StatuLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectYH(self.topScrollerView)+6, 0.6*Screen_width, 20)];
        _time_StatuLabel.text = @"丙申年农历十二月廿四  谷雨";
        _time_StatuLabel.font = MFont(14);
    }
    return _time_StatuLabel;
}

-(LoginViewController *)logVc{
    if (!_logVc) {
        _logVc = [[LoginViewController alloc] init];
        
    }
    return _logVc;
}

@end
