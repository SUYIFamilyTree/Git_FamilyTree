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
#import "NSString+getStarDate.h"

@interface FortuneTodayViewController ()
{
    NSArray *_dataSource;
    NSArray *_iconCount;
}
@end

@implementation FortuneTodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.comNavi.titleLabel.text = @"今日运势";
    [self initData];
    [self initForUI];
    [self getMainData];
    //MYLog(@"%@",[NSString getStarDateWithStar:@"狮子座"]);
}

-(void)getMainData{
    NSDictionary *logDic = @{@"userid":[NSString stringWithFormat:@"%@",GetUserId]};
    //WK(weakSelf)
    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:GetUserId requestcode:kRequestCodeGetMemys success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            MYLog(@"%@",jsonDic[@"data"]);
            
            
        }else{
            MYLog(@"%@",jsonDic[@"message"]);
        }
    } failure:^(NSError *error) {
        MYLog(@"失败---%@",error.description);
    }];

    
    
}

#pragma mark *** 初始化数据 ***
-(void)initData{
    _iconCount = @[@"3",@"2",@"1",@"4"];
    _dataSource = @[@"今天出门上班前要多检查随身物品，不要忘记带重要文件，记忆力可是有点不太靠谱破！工作今天出门上班前要多检查随身物品，不要忘记带重要文件，记忆力可是有点不太靠谱破！工作。sss",@"需要多花些心思在感情经营上。",@"工作上需要特别小心处理细节问题",@"彩云状况不错可以放心投资"];
    
}
#pragma mark *** 初始化界面 ***
-(void)initForUI{
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    UIImageView *bgView = [[UIImageView alloc] initWithImage:MImage(@"bg")];
    bgView.frame = CGRectMake(0, 64, Screen_width, Screen_height);
    [self.view addSubview:bgView];
    
    HeadLuckView *heav = [[HeadLuckView alloc] initWithFrame:CGRectMake(20, 20, Screen_width-40, 0.21*Screen_height)];
    [self.view addSubview:heav];
    
    AllLucyNum *lucyView = [[AllLucyNum alloc] initWithFrame:CGRectMake(20, CGRectYH(heav)+0.015*Screen_height, heav.bounds.size.width, 15) TitleImage:MImage(@"todayYS_ZH_TitIMG") title:@"综合运势" lucyIconImage:MImage(@"todayYS_ZH_redXing") nullImage:MImage(@"todayYS_ZH_whiteXing") iconAmount:[_iconCount[0] integerValue] detailDsc:_dataSource[0]];
 
    
    AllLucyNum *loveLuc = [[AllLucyNum alloc] initWithFrame:CGRectMake(20, CGRectYH(lucyView)+0.015*Screen_height, heav.bounds.size.width, 10) TitleImage:MImage(@"todayYS_LV_TitIMG") title:@"爱情运势" lucyIconImage:MImage(@"todayYS_LV_reds") nullImage:MImage(@"todayYS_LV_whites") iconAmount:[_iconCount[1] integerValue] detailDsc:_dataSource[1]];
   
    
    AllLucyNum *businStu = [[AllLucyNum alloc] initWithFrame:CGRectMake(20, CGRectYH(loveLuc)+0.015*Screen_height, heav.bounds.size.width, 10) TitleImage:MImage(@"todayYS_learn_TitIMG") title:@"事业学业" lucyIconImage:MImage(@"todayYS_learn_blues") nullImage:MImage(@"todayYS_learn_whites") iconAmount:[_iconCount[2] integerValue] detailDsc:_dataSource[2]];
   
    
    AllLucyNum *treasureLuc = [[AllLucyNum alloc] initWithFrame:CGRectMake(20, CGRectYH(businStu)+0.015*Screen_height, heav.bounds.size.width, 10) TitleImage:MImage(@"todayYS_Wl_TitIMG") title:@"运势财富" lucyIconImage:MImage(@"todayYS_Wl_haveMoney") nullImage:MImage(@"todayYS_Wl_noMoney") iconAmount:[_iconCount[3] integerValue] detailDsc:_dataSource[3]];
   
    
    UIScrollView *bacScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height-60)];
    bacScrollView.bounces = NO;
    bacScrollView.contentSize = CGSizeMake(Screen_width, 84+CGRectSize(heav).height+lucyView.bounds.size.height+loveLuc.bounds.size.height+businStu.bounds.size.height+treasureLuc.bounds.size.height+50);
    [self.view addSubview:bacScrollView];
    
    [bacScrollView addSubview:heav];
    [bacScrollView addSubview:lucyView];
    [bacScrollView addSubview:loveLuc];
    [bacScrollView addSubview:businStu];
    [bacScrollView addSubview:treasureLuc];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
