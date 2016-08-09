//
//  BannerView.m
//  FamilyTree
//
//  Created by 姚珉 on 16/8/9.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "BannerView.h"

@interface BannerView ()<UIScrollViewDelegate>
/** 滚动图*/
@property (nonatomic, strong) UIScrollView *bannerSV;
@end

@implementation BannerView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - 视图初始化

#pragma mark - UIScrollViewDelegate


#pragma mark - lazyLoad
-(UIScrollView *)bannerSV{
    if (!_bannerSV) {
        _bannerSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//        _bannerSV.contentSize = CGSizeMake(self.frame.size.width, <#CGFloat height#>);
        _bannerSV.bounces = NO;
        _bannerSV.pagingEnabled = YES;
        _bannerSV.delegate = self;
    }
    return _bannerSV;
}
@end
