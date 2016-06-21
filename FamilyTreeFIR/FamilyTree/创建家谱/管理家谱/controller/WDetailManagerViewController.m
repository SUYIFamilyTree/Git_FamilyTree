//
//  WDetailManagerViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/21.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "WDetailManagerViewController.h"

@interface WDetailManagerViewController ()
@property (nonatomic,strong) UIScrollView *backScrollView; /*背景滚动图*/
@property (nonatomic,strong) RollView *rollView; /*多少代卷谱*/
@property (nonatomic,strong) RollDetailView *rollDetail; /*具体某人*/
@end

@implementation WDetailManagerViewController

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
    [self.view addSubview:self.backScrollView];
    [self.backScrollView addSubview:self.rollView];
    [self.backScrollView addSubview:self.rollDetail];
}

#pragma mark *** getters ***
-(UIScrollView *)backScrollView{
    if (!_backScrollView) {
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, HeightExceptNaviAndTabbar)];
        _backScrollView.contentSize = AdaptationSize(720, 1025);
        
        UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _backScrollView.contentSize.width, _backScrollView.contentSize.height)];
        backView.image = MImage(@"bg");
        [_backScrollView addSubview:backView];
        
    }
    return _backScrollView;
}
-(RollView *)rollView{
    if (!_rollView) {
        _rollView = [[RollView alloc] initWithFrame:AdaptationFrame(558, 30, 135, 360) withTitle:@"段正淳1|5带卷谱"];
        
    }
    return _rollView;
}
-(RollDetailView *)rollDetail{
    if (!_rollDetail) {
        _rollDetail = [[RollDetailView alloc] initWithFrame:AdaptationFrame(30, 30, 500, 200)];
        
    }
    return _rollDetail;
}

@end
