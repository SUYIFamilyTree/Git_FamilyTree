//
//  JossSelectViewController.m
//  FamilyTree
//
//  Created by 姚珉 on 16/7/20.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "JossSelectViewController.h"

@interface JossSelectViewController()
/** 背景图*/
@property (nonatomic, strong) UIImageView *backIV;
/** 白色背景*/
@property (nonatomic, strong) UIImageView *whiteBackIV;
/** 阶梯背景图*/
@property (nonatomic, strong) UIImageView *ladderIV;
@end

@implementation JossSelectViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.backIV];
    [self.backIV addSubview:self.ladderIV];
    [self.backIV addSubview:self.whiteBackIV];
}

#pragma mark - lazyLoad
-(UIImageView *)backIV{
    if (!_backIV) {
        _backIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height-64-49)];
        _backIV.image = MImage(@"bg");
        _backIV.userInteractionEnabled = YES;
    }
    return _backIV;
}

-(UIImageView *)whiteBackIV{
    if (!_whiteBackIV) {
        _whiteBackIV = [[UIImageView alloc]initWithFrame:CGRectMake(0.04375*CGRectW(self.backIV), 0.0264*CGRectH(self.backIV), 0.9125*CGRectW(self.backIV), 0.5714*CGRectH(self.backIV))];
        _whiteBackIV.image = MImage(@"qf_bg_03");
    }
    return _whiteBackIV;
}


-(UIImageView *)ladderIV{
    if (!_ladderIV) {
        _ladderIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0.8352*CGRectH(self.backIV), Screen_width, 0.1538*CGRectH(self.backIV))];
        _ladderIV.image = MImage(@"qf_bgsk");
        UIImageView *redLadderIV = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_width/3-10, 0, Screen_width/3+20, CGRectH(_ladderIV)+5)];
        redLadderIV.image = MImage(@"qf_hukuai");
        MYLog(@"%lf",redLadderIV.frame.size.width);
        [_ladderIV addSubview:redLadderIV];
    }
    return _ladderIV;
}
@end
