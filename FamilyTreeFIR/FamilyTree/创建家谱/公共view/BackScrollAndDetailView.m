//
//  BackScrollAndDetailView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "BackScrollAndDetailView.h"

#define GapOfView 15

@interface BackScrollAndDetailView()
@property (nonatomic,strong) UIScrollView *backView; /*滚动背景*/
@property (nonatomic,strong) UIView *whiteBack; /*半透明背景*/

@property (nonatomic,strong) UIButton *createBtn; /*创建按钮*/

@property (nonatomic,strong) InputView *inputView; /*是否结婚*/

@property (nonatomic,strong) UITextField *parnName; /*配偶名*/


@property (nonatomic,strong) UIImageView *selecProtrai; /*选择头像*/


@end
@implementation BackScrollAndDetailView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backView];
        [self.backView addSubview:self.createBtn];
        [self.backView addSubview:self.whiteBack];
        
        [self.backView addSubview:self.inputView];
        [self.backView addSubview:self.parnName];
        [self.backView addSubview:self.selecProtrai];
       
        [[UILabel appearance] setTextColor:LH_RGBCOLOR(140, 140, 140)];
    }
    return self;
}

#pragma mark *** events ***
-(void)respondsToCreatBtn:(UIButton *)sender{
    MYLog(@"创建！");
}
#pragma mark *** getters ***

-(UIScrollView *)backView{
    if (!_backView) {
        _backView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height)];
        _backView.contentSize = CGSizeMake(Screen_width, Screen_height*2);
        _backView.bounces = NO;
        _backView.backgroundColor = [UIColor colorWithPatternImage:MImage(@"cratebg.png")];
    }
    return _backView;
}
-(UIButton *)createBtn{
    if (!_createBtn) {
        _createBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.backView.bounds)*2-50-64, Screen_width-20, 40)];
        [_createBtn setTitle:@"创 建" forState:0];
        _createBtn.backgroundColor = LH_RGBCOLOR(74, 81, 97);
        [_createBtn addTarget:self action:@selector(respondsToCreatBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _createBtn;
}
-(UIView *)whiteBack{
    if (!_whiteBack) {
        _whiteBack = [[UIView alloc] initWithFrame:CGRectMake(10, 15, Screen_width-20, Screen_height*2-40-50-64)];
        _whiteBack.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
        
        
    }
    return _whiteBack;
}

-(InputView *)inputView{
    if (!_inputView) {
        
        
        UILabel *theLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 80, 30)];
        theLabel.text = @"是否结婚:";
        [self.backView addSubview:theLabel];
        
        _inputView = [[InputView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(theLabel.frame), theLabel.frame.origin.y, 70, 30) Length:60 withData:@[@" 是",@" 否"]];
        _inputView.inputLabel.text = @" 否";
        
    }
    return _inputView;
}
-(UITextField *)parnName{
    if (!_parnName) {
        UILabel *theLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectYH(self.inputView)+GapOfView, 0.33*Screen_width, 30)];
        theLabel.text = @"输入配偶姓名:";
        [self.backView addSubview:theLabel];
        _parnName = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(theLabel.frame), theLabel.frame.origin.y, 0.5*Screen_width, 30)];
        _parnName.backgroundColor = [UIColor whiteColor];
        _parnName.layer.borderWidth = 1.0f;
        _parnName.layer.borderColor = BorderColor;
        _parnName.placeholder = @"第一（原）配姓名";
    }
    return _parnName;
}

-(UIImageView *)selecProtrai{
    if (!_selecProtrai) {
        _selecProtrai = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectYH(self.parnName)+GapOfView, 70, 40)];
        _selecProtrai.image = MImage(@"man");
        _selecProtrai.contentMode = UIViewContentModeScaleAspectFit;
        _selecProtrai.layer.borderColor = self.parnName.layer.borderColor;
        _selecProtrai.layer.borderWidth = 1.0f;
        
        UIButton *seletBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectXW(_selecProtrai)+20, _selecProtrai.frame.origin.y, 0.5*Screen_width, 40)];
        [seletBtn setTitle:@"选择头像" forState:0];
        [seletBtn setTitleColor:[UIColor blackColor] forState:0];
        seletBtn.layer.borderWidth = 1.0f;
        seletBtn.layer.borderColor = BorderColor;
        seletBtn.backgroundColor = [UIColor whiteColor];
        [self.backView addSubview:seletBtn];
        
    }
    return _selecProtrai;
}
@end
