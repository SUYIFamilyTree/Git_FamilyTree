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
    [self.view addSubview:self.bannerScrollView];
}

#pragma mark -lazyLoad
-(ScrollerView *)bannerScrollView{
    if (!_bannerScrollView) {
        _bannerScrollView = [[ScrollerView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, 175) images:nil];
    }
    return _bannerScrollView;
}

@end
