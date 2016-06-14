//
//  WorshipViewController.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "WorshipViewController.h"
#import "CommonNavigationViews.h"
#import "PrivateWorshipView.h"
#import "PublicWorshipView.h"
#import "PrivateWorshipTableViewCell.h"
#import "CemeteryViewController.h"
#import "CreateCemViewController.h"


@interface WorshipViewController()<UIScrollViewDelegate,PrivateWorshipViewDelegate>
/** 分段控件*/
@property (nonatomic, strong) UISegmentedControl *headerSegment;
/** 滚动视图*/
@property (nonatomic, strong) UIScrollView *scrollView;
/** 私人墓园*/
@property (nonatomic, strong) PrivateWorshipView *privateWorshipV;
/** 公共祭祀*/
@property (nonatomic, strong) PublicWorshipView *publickWorshipV;

@end

@implementation WorshipViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = LH_RGBCOLOR(236, 236, 236);
    CommonNavigationViews *navi = [[CommonNavigationViews alloc]initWithFrame:CGRectMake(0, 0, Screen_width, 64) title:@"在线祭祀" image:MImage(@"chec")];
    [self.view addSubview:navi];
    //添加分段控件
    [self initSegment];
    self.privateWorshipV.delegate = self;
}

-(void)initSegment{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, 50)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [self.view addSubview:self.headerSegment];
    [self.view addSubview:self.scrollView];
    [self setUpScrollView];
    [self setUpChildViewControll];
    [self.headerSegment addTarget:self action:@selector(segmentSelect:) forControlEvents:UIControlEventValueChanged];
}


#pragma mark - lazyLoad
-(UISegmentedControl *)headerSegment{
    if (!_headerSegment) {
        _headerSegment = [[UISegmentedControl alloc]initWithItems:@[@"私人墓园",@"公共祭奠"]];
        _headerSegment.frame = CGRectMake((Screen_width-200)/2, 64+10, 200,30);
        _headerSegment.tintColor = LH_RGBCOLOR(69, 80, 83);
        _headerSegment.selectedSegmentIndex = 0;
    }
    return _headerSegment;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+50+5, Screen_width, Screen_height-64-50-49-5)];
    }
    return _scrollView;
}

-(void)segmentSelect:(UISegmentedControl*)seg{
    NSInteger index = seg.selectedSegmentIndex;
    CGRect frame = self.scrollView.frame;
    frame.origin.x = index * CGRectGetWidth(self.scrollView.frame);
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}
-(void)setUpScrollView{
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //方向锁
    self.scrollView.directionalLockEnabled = YES;
    //取消自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView.contentSize = CGSizeMake(Screen_width * 2, Screen_height - 64 - 50-49-5);
    self.scrollView.bounces = NO;
}
/**
 *  设置控制的每一个子控制器
 */
-(void)setUpChildViewControll{
    self.privateWorshipV = [[PrivateWorshipView alloc]initWithFrame:CGRectMake(0,0, Screen_width, CGRectH(self.scrollView))];
    self.publickWorshipV = [[PublicWorshipView alloc]initWithFrame:CGRectMake(Screen_width, 0, Screen_width, CGRectH(self.scrollView))];
    
    //将视图view加入到scrollview上
    [self.scrollView addSubview:self.publickWorshipV];
    [self.scrollView addSubview:self.privateWorshipV];
    
}

#pragma mark - Scrollview delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offSetX = scrollView.contentOffset.x;
    NSInteger ratio = round(offSetX / Screen_width);
    self.headerSegment.selectedSegmentIndex = ratio;
}

#pragma mark - PrivateWorshipViewDelegate
-(void)PrivateWorshipView:(PrivateWorshipView *)privateWorshipView didSelect:(BOOL)isEditing{
    
}

-(void)PrivateWorshipView:(PrivateWorshipView *)privateWorshipView didSelectTableRowAtIndexPath:(NSIndexPath *)index{
    CemeteryViewController *cemeVc = [[CemeteryViewController alloc] initWithTitle:@"墓园名称" image:nil];
    [self.navigationController pushViewController:cemeVc animated:YES];
}

-(void)PrivateWorshipViewDidSelectedCreateCem:(PrivateWorshipView *)privateWorshipView{
    CreateCemViewController *createCemVc = [[CreateCemViewController alloc] initWithTitle:@"在线祭祀" image:nil];
    [self.navigationController pushViewController:createCemVc animated:YES];
}

@end
