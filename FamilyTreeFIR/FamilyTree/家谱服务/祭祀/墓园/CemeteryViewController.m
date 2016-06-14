//
//  CemeteryViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/13.
//  Copyright © 2016年 王子豪. All rights reserved.
//

enum {
    BTNIntroTag,
    BTNJishiTag,
    BTNMianhuaiTag
};

#import "CemeteryViewController.h"
#import "CemDetailView.h"
#import "CemIntroViewController.h"
#import "CemGoodsShopView.h"
#import "InputCherishView.h"
#define bacheight (Screen_height-self.tabBarController.tabBar.bounds.size.height-64)
@interface CemeteryViewController ()
@property (nonatomic,strong) UIScrollView *scrollView; /*背景滚动图*/

@property (nonatomic,strong) UIImageView *cemImageView; /*背景图*/

@property (nonatomic,strong) CemDetailView *detailView; /*详细墓碑内容*/

@property (nonatomic,strong) CemGoodsShopView *goodsView; /*祭祀商品*/

@property (nonatomic,strong) InputCherishView *inputView; /*输入缅怀语*/



@end

@implementation CemeteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
}
#pragma mark *** 初始化数据 ***
-(void)initData{
    
}
#pragma mark *** 初始化界面 ***
-(void)initUI{
    [self.view addSubview:self.scrollView];
  
    
    [self.scrollView addSubview:self.cemImageView];
      [self initXiangLu];
    [self.scrollView addSubview:self.detailView];
    [self initRightBtn];
    
    
    
}
//香炉
-(void)initXiangLu{
    for (int idx = 0; idx<2; idx++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:AdaptationFrame((0.7*bacheight-Screen_width/2)/AdaptationWidth()+50+idx*(350+140), 520, 126, 226)];
        image.image = MImage(@"my_name_xiangLu");
        
        [self.scrollView addSubview:image];
    }
}
//三个btn
-(void)initRightBtn{
    
    NSArray *imageArr = @[@"my_name_nav_1",@"my_name_nav_2",@"my_name_nav_3"];
    
    for (int idx = 0; idx<3; idx++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:AdaptationFrame(Screen_width/AdaptationWidth()-130, 750+idx*130, 114, 114)];
        [btn setImage:MImage(imageArr[idx]) forState:0];
        btn.tag = idx;
        [btn addTarget:self action:@selector(respondsToCemBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}
#pragma mark *** btnEvents ***

-(void)respondsToCemBtn:(UIButton *)sender{
    switch (sender.tag) {
        case BTNIntroTag:
        {
            CemIntroViewController *cemIntro = [[CemIntroViewController alloc] initWithTitle:@"墓园名称" image:nil];
            [self.navigationController pushViewController:cemIntro animated:YES];
        }
            break;
        case BTNJishiTag:
        {
            [self.view addSubview:self.goodsView];
        }
            break;
        case BTNMianhuaiTag:
        {
            [self.view addSubview:self.inputView];
        }
            break;
        default:
            break;
    }
}

#pragma mark *** getters ***
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, bacheight)];
        _scrollView.contentSize = CGSizeMake(1.4*bacheight, bacheight);
        _scrollView.bounces = false;
        _scrollView.contentOffset = CGPointMake(0.7*bacheight-Screen_width/2, 0);
    }
    return _scrollView;
}

-(UIImageView *)cemImageView{
    if (!_cemImageView) {
        _cemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height)];
        _cemImageView.image = MImage(@"my_name_bg.png");
        _cemImageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _cemImageView;
}

-(CemDetailView *)detailView{
    if (!_detailView) {
        _detailView = [[CemDetailView alloc] initWithFrame:AdaptationFrame((0.7*bacheight-Screen_width/2)/AdaptationWidth()+243, 64/AdaptationWidth()+120, 240, 470)];
    }
    return _detailView;
}
-(CemGoodsShopView *)goodsView{
    if (!_goodsView) {
        _goodsView = [[CemGoodsShopView alloc] initWithFrame:CGRectMake(0, 64, Screen_width,Screen_height-64-self.tabBarController.tabBar.bounds.size.height)];
        
    }
    return _goodsView;
}
-(InputCherishView *)inputView{
    if (!_inputView) {
        _inputView = [[InputCherishView alloc] initWithFrame:AdaptationFrame(170, 955, 375, 162)];
        
    }
    return _inputView;
}
@end
