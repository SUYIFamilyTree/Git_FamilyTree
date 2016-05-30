//
//  FamilServiceViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/26.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "FamilServiceViewController.h"

#import "TopSearchView.h"
#import "ScrollerView.h"
#import "CollectionFamilyView.h"
#import "FamilyShopView.h"
#import "TableView.h"


#define ScrollerView_Height 210
@interface FamilServiceViewController ()<TopSearchViewDelegate,TableViewDelegate,FamilyShopViewDelegate,CollectionFamilyDelegate>

@property (nonatomic,strong) TopSearchView *topSearchView; /*顶部搜索*/
@property (nonatomic,strong) ScrollerView *scrollerView; /*滚动图*/

@property (nonatomic,strong) CollectionFamilyView *collecFamView; /*八种家谱集合视图*/

@property (nonatomic,strong) FamilyShopView *famShop; /*商城*/

@property (nonatomic,strong) TableView *tableView; /*表格*/

@property (nonatomic,strong) UIScrollView *backScrollerView; /*背景图*/



@end

@implementation FamilServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.view.backgroundColor = LH_RGBCOLOR(236, 236, 236);
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    [self.view addSubview:self.backScrollerView];
    
    [self.view addSubview:self.topSearchView];
    [self.view addSubview:self.scrollerView];
    [self.backScrollerView addSubview:self.collecFamView];
    [self.backScrollerView addSubview:self.famShop];
    [self.backScrollerView addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark *** 协议方法 ***
-(void)TopSearchViewDidTapView:(TopSearchView *)topSearchView{
    MYLog(@"点击搜索栏");
}
-(void)TopSearchView:(TopSearchView *)topSearchView didRespondsToMenusBtn:(UIButton *)sender{
    MYLog(@"点击右上角菜单");
}

-(void)tableView:(TableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MYLog(@"点击table-- %ld 行 ",indexPath.row);
}

-(void)familyShopViewDidTapView:(FamilyShopView *)famShop{
    MYLog(@"点击商城");
}

-(void)CollevtionFamily:(CollectionFamilyView *)collecView didSelectedItemAtIndexPath:(NSIndexPath *)indexPath{
    MYLog(@"点击collection -- %ld",indexPath.row);
}

#pragma mark *** getters ***

-(UIScrollView *)backScrollerView{
    if (!_backScrollerView) {
        _backScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, CGRectGetMinY(self.tabBarController.tabBar.frame))];
        _backScrollerView.contentSize = CGSizeMake(Screen_width, CGRectGetMaxY(self.tableView.frame));
        _backScrollerView.bounces = NO;
        _backScrollerView.contentOffset = CGPointMake(0, 0);
        
        _backScrollerView.scrollEnabled = YES;
    }
    return _backScrollerView;
}

-(TopSearchView *)topSearchView{
    if (!_topSearchView) {
        _topSearchView = [[TopSearchView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, StatusBar_Height+NavigationBar_Height)];
        _topSearchView.delegate = self;
        
    }
    return _topSearchView;
}
-(ScrollerView *)scrollerView{
    if (!_scrollerView) {
        _scrollerView = [[ScrollerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topSearchView.frame), Screen_width, ScrollerView_Height)];
        
        
    }
    return _scrollerView;
}
-(CollectionFamilyView *)collecFamView{
    if (!_collecFamView) {
        _collecFamView = [[CollectionFamilyView alloc] initWithFrame:CGRectMake(0, 15, Screen_width*0.85, 130)];
        _collecFamView.center = CGPointMake(self.view.center.x,CGRectGetMaxY(self.scrollerView.frame)+15+_collecFamView.bounds.size.height/2);
        _collecFamView.delegate = self;
        
        
    }
    return _collecFamView;
}
-(FamilyShopView *)famShop{
    if (!_famShop) {
        _famShop = [[FamilyShopView alloc] initWithFrame:CGRectMake(0.05*Screen_width, CGRectGetMaxY(self.collecFamView.frame)+0.06*Screen_width, Screen_width, 34)];
        _famShop.delegate = self;
    }
    return _famShop;
}
-(TableView *)tableView{
    if (!_tableView) {
        _tableView = [[TableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.famShop.frame)+10, Screen_width , 0.25*Screen_height)];
        _tableView.backgroundColor = LH_RGBCOLOR(235, 235, 235);
        _tableView.delegate = self;
    }
    return _tableView;
}
@end
