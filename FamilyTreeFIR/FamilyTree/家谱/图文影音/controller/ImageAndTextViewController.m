//
//  ImageAndTextViewController.m
//  FamilyTree
//
//  Created by 姚珉 on 16/5/31.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "ImageAndTextViewController.h"
#import "CommonNavigationViews.h"
#import "SelectMyFamilyView.h"

@interface ImageAndTextViewController()<UITableViewDelegate,UITableViewDataSource,CommandNavigationViewsDelegate,SelectMyFamilyViewDelegate>
/** 书视图*/
@property (nonatomic, strong) UIImageView *bookImageView;
/** 左侧表视图*/
@property (nonatomic, strong) UITableView *leftTableView;
/** 左侧表视图目录*/
@property (nonatomic, strong) NSArray *leftListArr;
/** 正文底部视图*/
@property (nonatomic, strong) UIView *contentView;
/** 时间标签*/
@property (nonatomic, strong) UILabel *timeLB;
/** 正文图*/
@property (nonatomic, strong) UIImageView *contentImageView;
/** 正文图下面的标签*/
@property (nonatomic, strong) UILabel *contentUnderImageLB;
/** 正文右侧视图*/
@property (nonatomic, strong) UIView *rightView;
/** 正文右侧视图标签a*/
@property (nonatomic, strong) UILabel *rightViewLBA;
/** 正文右侧视图标签b*/
@property (nonatomic, strong) UILabel *rightViewLBB;
/** 正文右侧视图标签c*/
@property (nonatomic, strong) UILabel *rightViewLBC;
/** 正文右侧视图标签d*/
@property (nonatomic, strong) UILabel *rightViewLBD;
/** 家谱选择视图*/
@property (nonatomic, strong) SelectMyFamilyView *selecMyFamView;
@end

@implementation ImageAndTextViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //配置导航栏
    CommonNavigationViews *navi = [[CommonNavigationViews alloc]initWithFrame:CGRectMake(0, 0, Screen_width, 64) title:@"图文影音"];
    navi.delegate = self;
    [self.view addSubview:navi];
    //设置背景
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height-64-49)];
    bgImageView.image = MImage(@"bg");
    [self.view addSubview:bgImageView];
    //一本书
    [self initBookImageView];
    //左边目录
    [self initLeftTableView];
    //书正文视图
    [self initContentView];
    self.timeLB.text = @"子次公和日";
    [self.view addSubview:self.timeLB];
    self.contentImageView.image = MImage(@"bk_ye");
    [self.view addSubview:self.contentImageView];
    self.contentUnderImageLB.text = @"王氏32族谱";
    [self.view addSubview:self.contentUnderImageLB];
    //图下两条线
    [self initLeftAndRightLineIV];
    [self.view addSubview:self.rightView];
    //右侧四个标签
    [self initRightLBs];
    self.rightViewLBA.text = @"曾\n氏\n族\n谱";
    self.rightViewLBB.text = @"卷一";
    self.rightViewLBC.text = @"一\n百\n一\n十\n六\n页";
    self.rightViewLBD.text = @"白\n鹤\n堂";
}
//一本书
-(void)initBookImageView{
    _bookImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 64+50, 0.95*Screen_width, 0.66*Screen_height)];
    _bookImageView.image = MImage(@"book");
    [self.view addSubview:_bookImageView];
}
//左边目录
-(void)initLeftTableView{
    _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectX(_bookImageView)+15, CGRectY(_bookImageView)+65, 0.2*CGRectW(_bookImageView)+10, CGRectH(_bookImageView)) style:UITableViewStylePlain];
    _leftTableView.backgroundColor = [UIColor clearColor];
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
   [self.view addSubview:_leftTableView];
}
//正文视图
-(void)initContentView{
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(CGRectXW(_leftTableView), CGRectY(_bookImageView)+25, 0.65*CGRectW(_bookImageView), 0.88*CGRectH(_bookImageView)-5)];
    _contentView.backgroundColor = [UIColor clearColor];
    _contentView.layer.borderColor = [UIColor blackColor].CGColor;
    _contentView.layer.borderWidth = 1;
    [self.view addSubview:_contentView];
    //添加轻扫手势
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.contentView addGestureRecognizer:swipeGesture];
    swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesture:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.contentView addGestureRecognizer:swipeGesture];
}
//图下两条线
-(void)initLeftAndRightLineIV{
    UIImageView *leftLineIV =[[UIImageView alloc]initWithFrame:CGRectMake(CGRectX(_contentImageView),CGRectY(_contentUnderImageLB)+7, 0.33*CGRectW(_contentImageView), 5)];
    leftLineIV.image = MImage(@"ht_bt");
    [self.view addSubview:leftLineIV];
    UIImageView *rightLineIV =[[UIImageView alloc]initWithFrame:CGRectMake(CGRectX(_contentImageView)+0.67*CGRectW(_contentImageView), CGRectY(_contentUnderImageLB)+7, 0.33*CGRectW(_contentImageView), 5)];
    rightLineIV.image = MImage(@"ht_bt");
    [self.view addSubview:rightLineIV];
}
//四个标签
-(void)initRightLBs{
    _rightViewLBA = [[UILabel alloc]initWithFrame:CGRectMake(CGRectX(_rightView), CGRectY(_rightView), CGRectW(_rightView), 0.18*CGRectH(_rightView))];
    _rightViewLBA.font = MFont(12);
    _rightViewLBA.numberOfLines = 0;
    _rightViewLBA.textAlignment = NSTextAlignmentCenter;
    _rightViewLBA.layer.borderWidth = 1;
    [self.view addSubview:_rightViewLBA];
    UIImageView *angelIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectX(_rightView), CGRectYH(_rightViewLBA)+1, CGRectW(_rightView), 7)];
    angelIV.image = MImage(@"zp_top");
    [self.view addSubview:angelIV];
    UIImageView *cakeIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectX(_rightView)+2, CGRectYH(_rightViewLBA)+8, CGRectW(_rightView)-4, 35)];
    cakeIV.image = MImage(@"jz_bg");
    [self.view addSubview:cakeIV];
    _rightViewLBB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectX(_rightView)+3, CGRectY(cakeIV)+3, CGRectW(_rightView)-6, 30)];
    _rightViewLBB.font = MFont(12);
    _rightViewLBB.textColor = [UIColor whiteColor];
    _rightViewLBB.numberOfLines = 0;
    _rightViewLBB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_rightViewLBB];
    _rightViewLBC = [[UILabel alloc]initWithFrame:CGRectMake(CGRectX(_rightView), CGRectY(_rightView)+0.6*CGRectH(_rightView), CGRectW(_rightView), 0.25*CGRectH(_rightView))];
    _rightViewLBC.font = MFont(11);
    _rightViewLBC.numberOfLines = 0;
    _rightViewLBC.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_rightViewLBC];
    _rightViewLBD = [[UILabel alloc]initWithFrame:CGRectMake(CGRectX(_rightView), CGRectY(_rightView)+0.85*CGRectH(_rightView), CGRectW(_rightView), 0.15*CGRectH(_rightView))];
    _rightViewLBD.font = MFont(11);
    //_rightViewLBD.font = [UIFont fontWithName:@"Helvetica-Bold" size:11];
    _rightViewLBD.numberOfLines = 0;
    _rightViewLBD.textAlignment = NSTextAlignmentCenter;
    _rightViewLBD.layer.borderWidth = 1;
    
    [self.view addSubview:_rightViewLBD];
    
}
#pragma mark - lazyLoad
-(NSArray *)leftListArr{
    if (!_leftListArr) {
        _leftListArr = @[@"谱序",@"谱论",@"老宅",@"老照片",@"纪录片"];
    }
    return _leftListArr;
}
-(UILabel *)timeLB{
    if (!_timeLB) {
        _timeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectX(_contentView)+0.65*CGRectW(_contentView)-5, CGRectY(_contentView), 0.25*CGRectW(_contentView), 0.1*CGRectH(_contentView))];
        _timeLB.font = MFont(9);
    }
    return _timeLB;
}
-(UIImageView *)contentImageView{
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectX(_contentView)+5, CGRectYH(_timeLB), 0.85*CGRectW(_contentView)-5, 0.78*CGRectH(_contentView))];
        _contentImageView.contentMode = UIViewContentModeScaleToFill;
        _contentImageView.backgroundColor = [UIColor clearColor];
    }
    return _contentImageView;
}
-(UILabel *)contentUnderImageLB{
    if (!_contentUnderImageLB) {
        _contentUnderImageLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectX(_contentImageView)+0.33*CGRectW(_contentImageView), CGRectYH(_contentImageView)+10, 0.34*CGRectW(_contentImageView), 20)];
        _contentUnderImageLB.textColor = LH_RGBCOLOR(143, 34, 106);
        _contentUnderImageLB.textAlignment = NSTextAlignmentCenter;
        _contentUnderImageLB.font = MFont(10);
    }
    return _contentUnderImageLB;
}
-(UIView *)rightView{
    if (!_rightView) {
        _rightView = [[UIView alloc]initWithFrame:CGRectMake(CGRectX(_contentView)+0.88*CGRectW(_contentView), CGRectY(_contentView), 0.12*CGRectW(_contentView), CGRectH(_contentView))];
        _rightView.layer.borderWidth = 1;
        _rightView.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return _rightView;
}

-(UIView *)selecMyFamView{
    if (!_selecMyFamView) {
        _selecMyFamView = [[SelectMyFamilyView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, HeightExceptNaviAndTabbar)];
        _selecMyFamView.delegate = self;
    }
    return _selecMyFamView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.leftListArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.leftListArr[indexPath.row];
    cell.textLabel.font = MFont(11);
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//滑动正文手势事件
-(void)swipeGesture:(UISwipeGestureRecognizer *)swipe{
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft){
        MYLog(@"向左轻扫");
        self.contentImageView.image = MImage(@"bk_ye");
    }
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        MYLog(@"向右轻扫");
        self.contentImageView.image = MImage(@"sss_bg");
    }
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

}

#pragma mark *** SelectMyFamViewDelegate ***

-(void)SelectMyFamilyViewDelegate:(SelectMyFamilyView *)seleMyFam didSelectItemTitle:(NSString *)title{
    NSLog(@"%@", title);
}

@end


