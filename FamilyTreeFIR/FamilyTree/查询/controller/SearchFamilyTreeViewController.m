//
//  SearchFamilyTreeViewController.m
//  FamilyTree
//
//  Created by 姚珉 on 16/5/27.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "SearchFamilyTreeViewController.h"

@implementation SearchFamilyTreeViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = LH_RGBCOLOR(236, 236, 236);
    //导航栏
    [self initNavi];
    //搜索栏
    UISearchBar *seachBar = [[UISearchBar alloc]initWithFrame:CGRectMake(12, NavigationBar_Height+StatusBar_Height+8, Screen_width-24, 30)];
    seachBar.barTintColor = LH_RGBCOLOR(236, 236, 236);
    seachBar.placeholder = @"输入关键词";
    [self.view addSubview:seachBar];
}

-(void)initNavi{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, 64)];
    topView.backgroundColor = LH_RGBCOLOR(75, 88, 91);
    [self.view addSubview:topView];
    
    CGFloat topLabelWidth = 40;
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake((Screen_width-topLabelWidth)/2, StatusBar_Height, topLabelWidth, NavigationBar_Height)];
    topLabel.text = @"查询";
    topLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:topLabel];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 35, 8, 15)];
    [leftButton setBackgroundImage:MImage(@"fanhui.png") forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(Screen_width-38, 32, 20, 20)];
    [rightButton setBackgroundImage:MImage(@"chec.png") forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
}

//返回按钮
-(void)clickLeftButton{
    [self.navigationController popViewControllerAnimated:YES];
}

//右侧菜单
-(void)clickRightButton{
    MYLog(@"点击右侧菜单");
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
