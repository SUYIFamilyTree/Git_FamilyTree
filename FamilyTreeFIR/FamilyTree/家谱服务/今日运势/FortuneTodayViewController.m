//
//  FortuneTodayViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/4.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "FortuneTodayViewController.h"
#import "HeadLuckView.h"
#import "AllLucyNum.h"
@interface FortuneTodayViewController ()

@end

@implementation FortuneTodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initForUI];
}

#pragma mark *** 初始化数据 ***

#pragma mark *** 初始化界面 ***
-(void)initForUI{
    
    UIImageView *bgView = [[UIImageView alloc] initWithImage:MImage(@"bg")];
    bgView.frame = CGRectMake(0, 64, Screen_width, Screen_height);
    [self.view addSubview:bgView];
    
    HeadLuckView *heav = [[HeadLuckView alloc] initWithFrame:CGRectMake(20, 64+20, Screen_width-40, 140)];
    [self.view addSubview:heav];
    
    AllLucyNum *lucyView = [[AllLucyNum alloc] initWithFrame:CGRectMake(20, CGRectYH(heav)+0.015*Screen_height, heav.bounds.size.width, 150) TitleImage:MImage(@"todayYS_ZH_TitIMG") title:@"综合运势" lucyIconImage:MImage(@"todayYS_ZH_redXing") nullImage:MImage(@"todayYS_ZH_whiteXing") iconAmount:3];
    [self.view addSubview:lucyView];
    
    AllLucyNum *loveLuc = [[AllLucyNum alloc] initWithFrame:CGRectMake(20, CGRectYH(lucyView)+0.015*Screen_height, heav.bounds.size.width, 100) TitleImage:MImage(@"todayYS_LV_TitIMG") title:@"爱情运势" lucyIconImage:MImage(@"todayYS_LV_reds") nullImage:MImage(@"todayYS_LV_whites") iconAmount:3];
//    loveLuc.detailText.text = @"今天今天啊实打实大声道阿萨德";
    
    [self.view addSubview:loveLuc];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
