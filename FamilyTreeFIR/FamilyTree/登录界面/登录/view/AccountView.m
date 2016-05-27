//
//  AccountView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/25.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "AccountView.h"
#import "LineView.h"
#define HeadView_size 22
#define GapToView 15
@interface AccountView()

@property (nonatomic,strong) UIImageView *headView; /*左边图*/

@property (nonatomic,strong) UIView *verticalLine; /*竖线*/

@property (nonatomic,strong) UITextField *inputTextView; /*输入框*/

@property (nonatomic,strong) LineView *lineView; /*底部线*/



@end

@implementation AccountView

- (instancetype)initWithFrame:(CGRect)frame headImage:(UIImage *)image isSafe:(BOOL)Safe hasArrows:(BOOL)hasArrows
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headView];
        self.headView.image = image;
        [self addSubview:self.verticalLine];
        [self addSubview:self.inputTextView];
        [self addSubview:self.lineView];
        
        if (hasArrows) {
            [self addSubview:self.goArrows];
        }
        if (Safe) {
            self.inputTextView.secureTextEntry = YES;
        }
    }
    return self;
}

#pragma mark *** getters ***

-(UIImageView *)headView{
    if (!_headView) {
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, HeadView_size, HeadView_size)];
        
    }
    return _headView;
}

-(UIView *)verticalLine{
    if (!_verticalLine) {
        _verticalLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headView.frame)+GapToView, 1, 1, HeadView_size-2)];
        _verticalLine.backgroundColor = [UIColor whiteColor];
        
    }
    return _verticalLine;
}
-(UITextField *)inputTextView{
    if (!_inputTextView) {
        _inputTextView = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.verticalLine.frame)+GapToView, 0, 0.65*Screen_width, HeadView_size)];

        
    }
    return _inputTextView;
}
-(UIButton *)goArrows{
    if (!_goArrows) {
        _goArrows = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame)-HeadView_size-0.14*Screen_width, 0, HeadView_size, HeadView_size)];
        [_goArrows setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
        
    }
    return _goArrows;
}

-(LineView *)lineView{
    if (!_lineView) {
        _lineView = [[LineView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame)+15, SelfView_width+10, 100)];
        _lineView.backgroundColor = [UIColor clearColor];
        
    }
    return _lineView;
}

@end
