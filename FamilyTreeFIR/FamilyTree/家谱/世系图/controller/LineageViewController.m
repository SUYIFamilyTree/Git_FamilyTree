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
    CommonNavigationViews *navi = [[CommonNavigationViews alloc]initWithFrame:CGRectMake(0, 0, Screen_width, 64) title:@"世系图"];
    navi.delegate = self;
    [self.view addSubview:navi];
    //设置背景
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height-64-49)];
    bgImageView.image = MImage(@"bg");
    [self.view addSubview:bgImageView];
    //添加人
    [self initPerson];
    
    [TCJPHTTPRequestManager POSTWithParameters:@{@"genid":[WFamilyModel shareWFamilModel].myFamilyId,@"userid":@"1001574",@"gentions":@"1"} requestID:GetUserId requestcode:kRequestCodequerytreebygenid success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSLog(@"tree----%@", jsonDic[@"data"]);
        }
    } failure:^(NSError *error) {
        
    }];
    
}
-(void)SelectMyFamilyViewDelegate:(SelectMyFamilyView *)seleMyFam didSelectFamID:(NSString *)famId{
    NSLog(@"famid--%@", famId);
}
-(void)initPerson{
    LineageCellView *ziji = [[LineageCellView alloc]initWithFrame:CGRectMake((Screen_width-cell_width)/2, 64+(Screen_height-49-64)/2, cell_width, cell_height)];
    [self.view addSubview:ziji];
}

#pragma mark - lazyLoad
-(SelectMyFamilyView *)selecMyFamView{
    if (!_selecMyFamView) {
        _selecMyFamView = [[SelectMyFamilyView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, HeightExceptNaviAndTabbar)];
        _selecMyFamView.delegate = self;
    }
    [_selecMyFamView updateDataSourceAndUI];
    return _selecMyFamView;
}
#pragma mark - CommandNavigationViewsDelegate
-(void)CommonNavigationViews:(CommonNavigationViews *)comView respondsToRightBtn:(UIButton *)sender{
    MYLog(@"点击我的家谱");
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.view addSubview:self.selecMyFamView];
    }else{
        [self.selecMyFamView removeFromSuperview];
    }
    [self.selecMyFamView updateDataSourceAndUI];
}

#pragma mark *** SelectMyFamViewDelegate ***

-(void)SelectMyFamilyViewDelegate:(SelectMyFamilyView *)seleMyFam didSelectItemTitle:(NSString *)title{
    NSLog(@"%@", title);
}



@end
