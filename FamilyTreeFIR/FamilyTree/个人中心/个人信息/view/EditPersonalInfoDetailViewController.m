//
//  EditPersonalInfoDetailViewController.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/16.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "EditPersonalInfoDetailViewController.h"
#import "CommonNavigationViews.h"

@interface EditPersonalInfoDetailViewController()
/** 白色背景视图*/
@property (nonatomic, strong) UIView *bgView;
@end

@implementation EditPersonalInfoDetailViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    CommonNavigationViews *navi = [[CommonNavigationViews alloc]initWithFrame:CGRectMake(0, 0, Screen_width, 64) title:[NSString stringWithFormat:@"更改%@", self.detailStr] image:MImage(@"chec")];
    [self.view addSubview:navi];
    UIImageView *bgIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height-64-49)];
    bgIV.image = MImage(@"bg");
    bgIV.userInteractionEnabled = YES;
    [self.view addSubview:bgIV];
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0.04375*CGRectW(bgIV),0.022*CGRectH(bgIV),0.91875*CGRectW(bgIV), 0.3143*CGRectH(bgIV))];
    self.bgView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5];
    [bgIV addSubview:self.bgView];
    [self initmainView];
}

-(void)initmainView{
    UITextField *detailTF = [[UITextField alloc]initWithFrame:CGRectMake(0.0561*CGRectW(self.bgView), 0.1154*CGRectH(self.bgView), 0.8878*CGRectW(self.bgView), 0.2308*CGRectH(self.bgView))];
    detailTF.text = self.TFStr;
    detailTF.layer.borderColor = LH_RGBCOLOR(219, 219, 219).CGColor;
    detailTF.layer.borderWidth = 1;
    [self.bgView addSubview:detailTF];
    
    UILabel *tipLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectX(detailTF), CGRectYH(detailTF)+8, CGRectW(detailTF), 0.1049*CGRectH(self.bgView))];
    tipLB.text = [NSString stringWithFormat:@"请输入您的%@",self.detailStr];
    tipLB.textColor = LH_RGBCOLOR(219, 219, 219);
    [self.bgView addSubview:tipLB];
    
    UIButton *sureEditBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectX(detailTF), 0.6294*CGRectH(self.bgView), CGRectW(detailTF), CGRectH(detailTF))];
    [sureEditBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    sureEditBtn.backgroundColor = LH_RGBCOLOR(75, 88, 91);
    [sureEditBtn addTarget:self action:@selector(clickSureEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:sureEditBtn];
    
}

-(void)clickSureEditBtn:(UIButton *)sender{
    MYLog(@"确认修改");
    //上传数据
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
