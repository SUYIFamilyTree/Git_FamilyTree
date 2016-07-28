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
#import "SelectMyFamilyView.h"

#define cell_width 50
#define cell_height 75

@interface LineageViewController()<CommandNavigationViewsDelegate,SelectMyFamilyViewDelegate>
/** 家谱选择视图*/
@property (nonatomic, strong) SelectMyFamilyView *selecMyFamView;


@end

@implementation LineageViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    //设置背景
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height-64-49)];
    bgImageView.image = MImage(@"bg");
    [self.view addSubview:bgImageView];
    //添加人
    [self getData];
    [self initPerson];
}

#pragma mark - getData
-(void)getData{
    [TCJPHTTPRequestManager POSTWithParameters:@{@"genid":@10000,@"userid":@1001110,@"gentions":@"1"} requestID:GetUserId requestcode:kRequestCodequerytreebygenid success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        MYLog(@"%@",jsonDic[@"message"]);
        if (succe) {
            MYLog(@"tree----%@", jsonDic[@"data"]);
            
        }
    } failure:^(NSError *error) {
        
    }];

}

#pragma mark - 视图初始化
-(void)initPerson{
    LineageCellView *ziji = [[LineageCellView alloc]initWithFrame:CGRectMake((Screen_width-cell_width)/2, 64+(Screen_height-49-64)/2, cell_width, cell_height)];
    [self.view addSubview:ziji];
}

#pragma mark - SelectMyFamilyViewDelegate
-(void)SelectMyFamilyViewDelegate:(SelectMyFamilyView *)seleMyFam didSelectFamID:(NSString *)famId{
    NSLog(@"famid--%@", famId);
}



#pragma mark *** SelectMyFamViewDelegate ***

-(void)SelectMyFamilyViewDelegate:(SelectMyFamilyView *)seleMyFam didSelectItemTitle:(NSString *)title{
    NSLog(@"%@", title);
}



@end
