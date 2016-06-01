//
//  LineageViewController.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "LineageViewController.h"
#import "CommonNavigationViews.h"
#import "LineageCellView.h"

#define cell_width 50
#define cell_height 75
@implementation LineageViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    CommonNavigationViews *navi = [[CommonNavigationViews alloc]initWithFrame:CGRectMake(0, 0, Screen_width, 64) title:@"世系图"];
    [self.view addSubview:navi];
    //设置背景
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height-64-49)];
    bgImageView.image = MImage(@"bg");
    [self.view addSubview:bgImageView];
    //添加人
    [self initPerson];
    //[self drawLine];
}

-(void)initPerson{
    LineageCellView *ziji = [[LineageCellView alloc]initWithFrame:CGRectMake((Screen_width-cell_width)/2, 64+(Screen_height-49-64)/2, cell_width, cell_height)];
    [self.view addSubview:ziji];
    
}


    


@end
