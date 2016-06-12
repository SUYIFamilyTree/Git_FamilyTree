//
//  CreateFamViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "CreateFamViewController.h"
#import "BackScrollAndDetailView.h"
#import "CreateFamView.h"
@interface CreateFamViewController ()

@end

@implementation CreateFamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.automaticallyAdjustsScrollViewInsets=false;
    self.tabBarController.tabBar.hidden = YES;
    
    [self initUI];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = false;
}
#pragma mark *** 初始化界面 ***
-(void)initUI{
    
    CreateFamView *creFamView = [[CreateFamView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height)];
    [self.view addSubview:creFamView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
