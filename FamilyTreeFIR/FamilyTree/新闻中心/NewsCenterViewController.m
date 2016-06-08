//
//  NewsCenterViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/7.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "NewsCenterViewController.h"

@interface NewsCenterViewController ()
@property (nonatomic,strong) UIScrollView *bacScrollView; /*背景滚动图*/

@property (nonatomic,strong) UIView *whiteView; /*背景白*/


@property (nonatomic,strong) UISegmentedControl *segmentContl; /*分段控件*/
@property (nonatomic,strong) ScrollerView *scroView; /*滚动新闻图*/

@property (nonatomic,strong) NewsTableView *tableNesView; /*table*/

@property (nonatomic,strong) PortraitAndNameViews *proAndName; /*头像和名字*/

@property (nonatomic,strong) HundredNamesView *hundredVies; /*百家姓*/

@property (nonatomic,strong) NewsTableView *nameTableNews; /*百家姓新闻*/




@end

@implementation NewsCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LH_RGBCOLOR(236, 236, 236);
    
    [self.view addSubview:self.bacScrollView];
    [self.bacScrollView addSubview:self.whiteView];
    [self.bacScrollView addSubview:self.segmentContl];
    [self.bacScrollView addSubview:self.scroView];
    [self.bacScrollView addSubview:self.tableNesView];
    [self.bacScrollView addSubview:self.proAndName];
    [self.bacScrollView addSubview:self.hundredVies];
    [self.bacScrollView addSubview:self.nameTableNews];
    
}

#pragma mark *** getters ***

-(UIScrollView *)bacScrollView{
    if (!_bacScrollView) {
        _bacScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectYH(self.comNavi), Screen_width, Screen_height-64-self.tabBarController.tabBar.bounds.size.height)];
        _bacScrollView.bounces = false;
        _bacScrollView.contentSize = CGSizeMake(Screen_width, CGRectGetMaxY(self.nameTableNews.frame)+55*AdaptationWidth());
    }
    return _bacScrollView;
}
-(UIView *)whiteView{
    if (!_whiteView) {
        _whiteView = [[UIView alloc] initWithFrame:AdaptationFrame(0,0, Screen_width/AdaptationWidth(), 456)];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}
-(UISegmentedControl *)segmentContl{
    if (!_segmentContl) {
        _segmentContl = [[UISegmentedControl alloc] initWithItems:@[@"同城公告",@"同城活动",@"家谱新闻"]];
        _segmentContl.frame = AdaptationFrame(26, 24, 667, 53);
        _segmentContl.tintColor = self.comNavi.backView.backgroundColor;
//        _segmentContl.backgroundColor = self.comNavi.backView.backgroundColor;
        [_segmentContl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
        _segmentContl.selectedSegmentIndex = 2;
    }
    return _segmentContl;
}

-(ScrollerView *)scroView{
    if (!_scroView) {
        _scroView = [[ScrollerView alloc] initWithFrame:AdaptationFrame(27, CGRectYH(self.segmentContl)/AdaptationWidth()+28, 667, 333) images:[@[@"news_lunbo.png",@"xuShi_bg"] mutableCopy]];
        
    }
    return _scroView;
}
-(NewsTableView *)tableNesView{
    if (!_tableNesView) {
        _tableNesView = [[NewsTableView alloc] initWithFrame:CGRectMake(0, CGRectYH(self.scroView)+20*AdaptationWidth(), Screen_width, 416*AdaptationWidth())];
        
    }
    return _tableNesView;
}
-(PortraitAndNameViews *)proAndName{
    if (!_proAndName) {
        _proAndName = [[PortraitAndNameViews alloc] initWithFrame:AdaptationFrame(22, CGRectYH(self.tableNesView)/AdaptationWidth()+20, 670, 230)];
    }
    return _proAndName;
}
-(HundredNamesView *)hundredVies{
    if (!_hundredVies) {
        
        UIView *whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectYH(self.proAndName)+8*AdaptationWidth(), Screen_width, 312*AdaptationWidth())];
        whiteV.backgroundColor = [UIColor whiteColor];
        [self.bacScrollView addSubview:whiteV];
        
        _hundredVies = [[HundredNamesView alloc] initWithFrame:CGRectMake(0, CGRectYH(self.proAndName), Screen_width, 257*AdaptationWidth())];
        
    }
    return _hundredVies;
}
-(NewsTableView *)nameTableNews{
    if (!_nameTableNews) {
        _nameTableNews = [[NewsTableView alloc] initWithFrame:CGRectMake(0, CGRectYH(self.hundredVies)+80*AdaptationWidth(), Screen_width, 412*AdaptationWidth())];
    }
    return _nameTableNews;
}



@end
