//
//  ShoppingViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/24.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "ShoppingViewController.h"
#import "WShopSearchViewController.h"
#import "GoodsCommentViewController.h"
@interface ShoppingViewController ()<TopSearchViewDelegate>

@property (nonatomic,strong) TopSearchView *topSearchView; /*顶部搜索*/
@property (nonatomic,strong) ScrollerView *scrollerView; /*滚动图*/

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = LH_RGBCOLOR(236, 236, 236);
    self.navigationController.navigationBarHidden = YES;
    
    [self.view addSubview:self.topSearchView];
    [self.view addSubview:self.scrollerView];
}

#pragma mark *** TopSearchViewDelegate ***

-(void)TopSearchViewDidTapView:(TopSearchView *)topSearchView{
    MYLog(@"商城搜索栏");
    WShopSearchViewController *searchVc = [[WShopSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];
}
-(void)TopSearchView:(TopSearchView *)topSearchView didRespondsToMenusBtn:(UIButton *)sender{
    MYLog(@"商城右菜单");
    GoodsCommentViewController *pingjia = [[GoodsCommentViewController alloc] init];
    [self.navigationController pushViewController:pingjia animated:YES];
    
}
#pragma mark *** getters ***
-(TopSearchView *)topSearchView{
    if (!_topSearchView) {
        _topSearchView = [[TopSearchView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, StatusBar_Height+NavigationBar_Height)];
        _topSearchView.searchLabel.placeholder = @"输入关键词";
        _topSearchView.delegate = self;
        
    }
    return _topSearchView;
}
-(ScrollerView *)scrollerView{
    if (!_scrollerView) {
        _scrollerView = [[ScrollerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topSearchView.frame), Screen_width, 210) images:nil];
        
    }
    return _scrollerView;
}
@end
