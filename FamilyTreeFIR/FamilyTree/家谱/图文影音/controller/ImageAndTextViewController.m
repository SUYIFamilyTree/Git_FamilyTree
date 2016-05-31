//
//  ImageAndTextViewController.m
//  FamilyTree
//
//  Created by 姚珉 on 16/5/31.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "ImageAndTextViewController.h"
#import "CommonNavigationViews.h"
@implementation ImageAndTextViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    //配置导航栏
    CommonNavigationViews *navi = [[CommonNavigationViews alloc]initWithFrame:CGRectMake(0, 0, Screen_width, 64) title:@"图文影音"];
    [self.view addSubview:navi];
    //设置背景
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height-64-49)];
    bgImageView.image = MImage(@"bg");
    [self.view addSubview:bgImageView];
    
    
    
}

@end


