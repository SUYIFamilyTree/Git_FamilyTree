//
//  ManagerFamilyViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/15.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "ManagerFamilyViewController.h"

#define ZeroContentOffset 320

@interface ManagerFamilyViewController ()

@property (nonatomic,strong) UIScrollView *backScrollView; /*背景滚动图*/

@property (nonatomic,strong) UIImageView *famImage; /*家族名字图*/

@property (nonatomic,strong) UIButton *switchFam; /*切换家谱*/


@end

@implementation ManagerFamilyViewController
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.backScrollView];
    [self.view addSubview:self.switchFam];
    [self initAllRollView];
    [self.backScrollView addSubview:self.famImage];
    
    [self.view bringSubviewToFront:self.switchFam];
}

-(void)initAllRollView{
    NSArray *titleArr = @[@"段正淳1|5代卷谱",@"段志兴6|9代卷谱",@"段志兴6|9代卷谱",@"段志兴十|代卷谱",@"段志兴10|15代卷谱",@"段志兴10|15代卷谱"];
    NSArray *frameArr = @[[NSValue valueWithCGPoint:CGPointMake(383, 30)],[NSValue valueWithCGPoint:CGPointMake(380, 438)],[NSValue valueWithCGPoint:CGPointMake(565, 438)],[NSValue valueWithCGPoint:CGPointMake(381, 851)],[NSValue valueWithCGPoint:CGPointMake(190, 851)],[NSValue valueWithCGPoint:CGPointMake(0, 851)],];
    
    for (int idx = 0; idx<titleArr.count; idx++) {
        CGPoint potRect = [frameArr[idx] CGPointValue];
        
        RollView *rollView = [[RollView alloc] initWithFrame:AdaptationFrame(ZeroContentOffset+potRect.x, potRect.y, 131, 358) withTitle:titleArr[idx]];
        
        [self.backScrollView addSubview:rollView];
        
    }
    
    
    
}
#pragma mark *** getters ***
-(UIScrollView *)backScrollView{
    if (!_backScrollView) {
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, HeightExceptNaviAndTabbar)];
        _backScrollView.contentSize = AdaptationSize(1040, 1500);
        _backScrollView.contentOffset = AdaptationCenter(ZeroContentOffset, 0);
        _backScrollView.bounces = false;
        UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _backScrollView.contentSize.width, _backScrollView.contentSize.height)];
        backView.image = MImage(@"gljp_bg");
        [_backScrollView addSubview:backView];
        
    }
    return _backScrollView;
}

-(UIImageView *)famImage{
    if (!_famImage) {
        _famImage = [[UIImageView alloc] initWithFrame:AdaptationFrame(560+ZeroContentOffset, 30, 131, 358)];
        _famImage.image = MImage(@"jp_IMG");
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:AdaptationFrame(0, 15, 131, 325)];
        
        
        nameLabel.text = [NSString verticalStringWith:@"云南大理段氏"];
        nameLabel.textAlignment = 1;
        nameLabel.numberOfLines = 0;
        nameLabel.font = WFont(40);
        [_famImage addSubview:nameLabel];
    }
    return _famImage;
}


-(UIButton *)switchFam{
    if (!_switchFam) {
        _switchFam = [[UIButton alloc] initWithFrame:AdaptationFrame(660, 413+self.comNavi.frame.size.height/AdaptationWidth(), 62, 200)];
        _switchFam.backgroundColor = [UIColor blackColor];
    }
    return _switchFam;
}
@end
