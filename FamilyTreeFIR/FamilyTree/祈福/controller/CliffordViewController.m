//
//  CliffordViewController.m
//  FamilyTree
//
//  Created by 姚珉 on 16/7/19.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "CliffordViewController.h"

@interface CliffordViewController()
/** 背景视图*/
@property (nonatomic, strong) UIImageView *backIV;
/** 帘子视图*/
@property (nonatomic, strong) UIImageView *curtainIV;
/** 开场动画按钮*/
@property (nonatomic, strong) UIButton *beginBtn;
/** 佛像*/
@property (nonatomic, strong) UIImageView *jossIV;
/** 左烛台*/
@property (nonatomic, strong) UIImageView *leftCandleHolderIV;
/** 右烛台*/
@property (nonatomic, strong) UIImageView *rightCandleHolderIV;
/** 香炉*/
@property (nonatomic, strong) UIImageView *burnerIV;
/** 拜佛按钮*/
@property (nonatomic, strong) UIButton *worshipJossBtn;
/** 点击弹出贡品的视图*/
@property (nonatomic, strong) UIView *clickView;
@end

@implementation CliffordViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.backIV];
    [self.view addSubview:self.curtainIV];
    [self.curtainIV addSubview:self.beginBtn];
    [self.backIV addSubview:self.jossIV];
    [self.backIV addSubview:self.leftCandleHolderIV];
    [self.backIV addSubview:self.rightCandleHolderIV];
    [self.backIV addSubview:self.burnerIV];
    [self.backIV addSubview:self.worshipJossBtn];
    //支持摇一摇
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    
    [self.backIV addSubview:self.clickView];
}

#pragma mark - 点击事件
-(void)clickToBegin{
    [self startCurtainAnimation];
}

-(void)clickToPushTributeView{
    MYLog(@"弹出贡品视图");
}

#pragma mark *** 摇一摇 ***
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    MYLog(@"摇一摇");
    [self worshipJossAnimation];
}

-(void)worshipJossAnimation{
    MYLog(@"叩拜动画");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //弹出祈福语
        [self getCliffordStr];
    });
}

//帘子动画
-(void)startCurtainAnimation{
    [UIView animateWithDuration:2 animations:^{
        [self.beginBtn removeFromSuperview];
        self.curtainIV.frame = CGRectMake(0, 64, Screen_width, 0);
    } completion:^(BOOL finished) {
         [self.curtainIV removeFromSuperview];
        
    }];
}

#pragma mark - 网络请求
-(void)getCliffordStr{
    NSDictionary *logDic = @{@"userid":GetUserId};
    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:GetUserId requestcode:@"getmemqfy" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        MYLog(@"%@",jsonDic[@"data"]);
        if (succe) {
            
        }
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - lazyLoad
-(UIImageView *)backIV{
    if (!_backIV) {
        _backIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height-64-49)];
        _backIV.userInteractionEnabled = YES;
        _backIV.backgroundColor = [UIColor blueColor];
    }
    return _backIV;
}


-(UIImageView *)curtainIV{
    if (!_curtainIV) {
        _curtainIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height-64-49-10)];
        _curtainIV.backgroundColor = [UIColor redColor];
        _curtainIV.userInteractionEnabled = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self startCurtainAnimation];
        });
    }
    return _curtainIV;
}

-(UIButton *)beginBtn{
    if (!_beginBtn) {
        _beginBtn = [[UIButton alloc]initWithFrame:CGRectMake(0.2063*CGRectW(self.backIV), 0.3626*CGRectH(self.backIV)-10, 0.6*CGRectW(self.backIV), 0.2537*CGRectH(self.backIV))];
        _beginBtn.backgroundColor = [UIColor grayColor];
        [_beginBtn addTarget:self action:@selector(clickToBegin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _beginBtn;
}

-(UIImageView *)jossIV{
    if (!_jossIV) {
        _jossIV = [[UIImageView alloc]initWithFrame:CGRectMake(0.2313*CGRectW(self.backIV), 0.0549*CGRectH(self.backIV), 0.5375*CGRectW(self.backIV), 0.5099*CGRectH(self.backIV))];
        _jossIV.backgroundColor = [UIColor yellowColor];
    }
    return _jossIV;
}

-(UIImageView *)leftCandleHolderIV{
    if (!_leftCandleHolderIV) {
        _leftCandleHolderIV = [[UIImageView alloc]initWithFrame:CGRectMake(0.1141*CGRectW(self.backIV), 0.4824*CGRectH(self.backIV), 0.1172*CGRectW(self.backIV), 0.1714*CGRectH(self.backIV))];
        _leftCandleHolderIV.backgroundColor = [UIColor redColor];
    }
    return _leftCandleHolderIV;
}

-(UIImageView *)rightCandleHolderIV{
    if (!_rightCandleHolderIV) {
        _rightCandleHolderIV = [[UIImageView alloc]initWithFrame:CGRectMake(0.7563*CGRectW(self.backIV), CGRectY(self.leftCandleHolderIV), CGRectW(self.leftCandleHolderIV), CGRectH(self.leftCandleHolderIV))];
        _rightCandleHolderIV.backgroundColor = [UIColor redColor];
        _rightCandleHolderIV.contentMode = UIViewContentModeBottom;
    }
    return _rightCandleHolderIV;
}

-(UIImageView *)burnerIV{
    if (!_burnerIV) {
        _burnerIV = [[UIImageView alloc]initWithFrame:CGRectMake(0.375*CGRectW(self.backIV), 0.3637*CGRectH(self.backIV), 0.2578*CGRectW(self.backIV), 0.2934*CGRectH(self.backIV))];
        _burnerIV.backgroundColor = [UIColor redColor];
    }
    return _burnerIV;
}

-(UIButton *)worshipJossBtn{
    if (!_worshipJossBtn) {
        _worshipJossBtn = [[UIButton alloc]initWithFrame:CGRectMake(0.1922*CGRectW(self.backIV), 0.8725*CGRectH(self.backIV), 0.6375*CGRectW(self.backIV), 0.0923*CGRectH(self.backIV))];
        _worshipJossBtn.backgroundColor = [UIColor whiteColor];
        [_worshipJossBtn addTarget:self action:@selector(worshipJossAnimation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _worshipJossBtn;
}

-(UIView *)clickView{
    if (!_clickView) {
        _clickView = [[UIView alloc]initWithFrame:CGRectMake(0.0453*CGRectW(self.backIV), 0.5582*CGRectH(self.backIV), 0.9094*CGRectW(self.backIV), 0.2132*CGRectH(self.backIV))];
        _clickView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickToPushTributeView)];
        [_clickView addGestureRecognizer:tap];
    }
    return _clickView;
}

@end
