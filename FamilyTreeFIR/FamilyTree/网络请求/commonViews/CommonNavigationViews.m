//
//  CommonNavigationViews.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/27.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "CommonNavigationViews.h"

@interface CommonNavigationViews()


@end
@implementation CommonNavigationViews
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backView];
        
        [self addSubview:self.titleLabel];
        self.titleLabel.text = title;
        [self addSubview:self.rightBtn];
        [self.rightBtn setImage:image forState:0];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backView];
        [self addSubview:self.titleLabel];
        self.titleLabel.text = title;
        [self addSubview:self.rightView];
    }
    return self;
}


#pragma mark *** Events ***

-(void)respondsToReturnBtn{
    
    MYLog(@"返回按钮");
    
    [[self viewController] popViewControllerAnimated:YES];
    
}

-(void)respondsToRightBtn:(UIButton *)sender{
    MYLog(@"右按钮");
}
//获取当前view导航控制器
- (UINavigationController*)viewController {
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            
            return (UINavigationController*)nextResponder;
            
        }
        
    }
    
    return nil;
    
}
#pragma mark *** getters ***
-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, 44+StatusBar_Height)];
        _backView.backgroundColor = LH_RGBCOLOR(75, 88, 91);
        
        UIButton *returnBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_backView.bounds)/2-30+StatusBar_Height, 44, 44)];
        [returnBtn setImage:MImage(@"fanhui") forState:0];
        
        [returnBtn addTarget:self action:@selector(respondsToReturnBtn) forControlEvents:UIControlEventTouchUpInside];
        returnBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [_backView addSubview:returnBtn];
    }
    return _backView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        _titleLabel.center = CGPointMake(self.center.x,CGRectGetHeight(_backView.bounds)/2-30+StatusBar_Height+22);
        _titleLabel.textAlignment = 1;
        _titleLabel.text = @"这是标题";
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame)-44+5, CGRectGetHeight(_backView.bounds)/2-30+StatusBar_Height+10, 25, 25)];
        _rightBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [_rightBtn addTarget:self action:@selector(respondsToRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

-(UIView *)rightView{
    if (!_rightView) {
        _rightView = [[UIView alloc]initWithFrame:CGRectMake(0.8*CGRectW(self), StatusBar_Height, 0.2*CGRectW(self), 64-StatusBar_Height)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(respondsToRightBtn:)];
        [_rightView addGestureRecognizer:tap];
        UILabel *myFamilyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectX(_rightView), CGRectY(_rightView), CGRectW(_rightView)*0.8, CGRectH(_rightView))];
        myFamilyLabel.text = @"我的家谱";
        myFamilyLabel.font = MFont(12);
        myFamilyLabel.textColor = [UIColor whiteColor];
        myFamilyLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:myFamilyLabel];
        UIImageView *jiantou = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectX(_rightView)+CGRectW(myFamilyLabel), CGRectY(myFamilyLabel)+20, 10, 6)];
        jiantou.image = MImage(@"sel.png");
        [self addSubview:jiantou];

    }
    return _rightView;
}

@end
