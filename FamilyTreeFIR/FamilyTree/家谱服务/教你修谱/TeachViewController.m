//
//  TeachViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/12.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "TeachViewController.h"

@interface TeachViewController ()
@property (nonatomic,copy) NSString *name; /*姓名*/
@property (nonatomic,copy) NSString *phoneNumber; /*电话号码*/
@property (nonatomic,strong) UIScrollView *scrollView; /*背景滚动*/


@end

@implementation TeachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets = NO;
    [self initData];
    [self initUI];
}
#pragma mark *** 初始化数据 ***
-(void)initData{
    
}
#pragma mark *** 初始化界面 ***
-(void)initUI{
    
   
    
    self.view.backgroundColor = LH_RGBCOLOR(236, 236, 236);
    //流程图
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, 818*AdaptationWidth())];
    imageView.image = MImage(@"jnxp_bg");
   
    
    //更多信息
    UIView *moreInfo = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectYH(imageView)+10*AdaptationWidth(), Screen_width, 220*AdaptationWidth())];
    moreInfo.backgroundColor = [UIColor whiteColor];
    
    UILabel *moreLabel = [[UILabel alloc] initWithFrame:AdaptationFrame(46, 30, 500, 21)];
    moreLabel.text = @"了解更多修谱信息，请留下您的：";
    moreLabel.font = MFont(13);
    moreLabel.textAlignment = 0;
    [moreInfo addSubview:moreLabel];
    
    NSArray *arr = @[@"姓名:",@"电话:"];
    for (int idx = 0; idx<2; idx++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(86*AdaptationWidth(), CGRectYH(moreLabel)+15*AdaptationWidth()+idx*32*AdaptationWidth(), 60*AdaptationWidth(), 22*AdaptationWidth())];
        label.text = arr[idx];
        label.font = MFont(25*AdaptationWidth());
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectXW(label), CGRectY(label), 400*AdaptationWidth(), 22*AdaptationWidth())];
        [CALayer drawBottomBorder:textField];
        textField.font = label.font;
        [moreInfo addSubview:label];
        [moreInfo addSubview:textField];
    }
    
    UILabel *GMLabel = [[UILabel alloc ]initWithFrame:AdaptationFrame(86, CGRectYH(moreLabel)/AdaptationWidth()+103, 500, 20)];
    GMLabel.font = MFont(11);
    GMLabel.text = @"我们的客服MM会在半个小时内联系您。";
    GMLabel.textAlignment = 0;
    [moreInfo addSubview:GMLabel];
    
    UIScrollView *bacScreView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height-64-self.tabBarController.tabBar.bounds.size.height)];
    bacScreView.contentSize = CGSizeMake(Screen_width, CGRectGetMaxY(moreInfo.frame));
    bacScreView.bounces = false;
    
    
    [self.view addSubview:bacScreView];
    [bacScreView addSubview:imageView];
    [bacScreView addSubview:moreInfo];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
