//
//  AdgnatioHelpInfoViewController.m
//  FamilyTree
//
//  Created by 姚珉 on 16/8/2.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "AdgnatioHelpInfoViewController.h"
#import "ScrollerView.h"

@interface AdgnatioHelpInfoViewController ()
/** 滚动图*/
@property (nonatomic, strong) ScrollerView *bannerScrollView;

@end

@implementation AdgnatioHelpInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - 视图初始化
-(void)initUI{
    self.view.backgroundColor = LH_RGBCOLOR(236, 236, 236);
    [self.view addSubview:self.bannerScrollView];
//    //关注人数
//    UIView *attentionV =[[UIView alloc]init];
//    attentionV.backgroundColor = LH_RGBCOLOR(139, 31, 71);
//    [self.view addSubview:attentionV];
//    
//    //意向联系
//    UIView *purposeContactV = [[UIView alloc]init];
//    purposeContactV.backgroundColor = LH_RGBCOLOR(212, 59, 34);
//    [self.view addSubview:purposeContactV];
//    //剩余天数
//    UIView *deadlineDayV = [[UIView alloc]init];
//    deadlineDayV.backgroundColor = LH_RGBCOLOR(245, 172, 50);
//    [self.view addSubview:deadlineDayV];
//    
//    attentionV.sd_layout.topSpaceToView(self.bannerScrollView,15).leftSpaceToView(self.view,15).heightIs(55).rightSpaceToView(purposeContactV,15);
//    
//    purposeContactV.sd_layout.topSpaceToView(self.bannerScrollView,15).heightIs(55).rightSpaceToView(deadlineDayV,15).leftSpaceToView(attentionV,15);
//    
//    deadlineDayV.sd_layout.topSpaceToView(self.bannerScrollView,15).heightIs(55).rightSpaceToView(self.view,15).leftSpaceToView(purposeContactV,15);
}

#pragma mark -lazyLoad
-(ScrollerView *)bannerScrollView{
    if (!_bannerScrollView) {
        _bannerScrollView = [[ScrollerView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, 175) images:nil];
    }
    return _bannerScrollView;
}

@end
