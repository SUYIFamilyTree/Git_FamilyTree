//
//  AccountView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/25.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "AccountView.h"
#define HeadView_size 22
#define GapToView 15
@interface AccountView()<UITextFieldDelegate>


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
        [self addSubview:self.placeholder];
        
        if (hasArrows) {
            [self addSubview:self.goArrows];
        }
        if (Safe) {
            self.inputTextView.secureTextEntry = YES;
        }
    }
    return self;
}


#pragma mark *** UITextFieldDelegate ***

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (_placeholder) {
//        _placeholder.hidden = YES;
    }
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"%ld", textField.text.length);
    if (textField.text.length >0) {
        _placeholder.hidden = YES;
    }else{
        _placeholder.hidden = NO;
    }
    
    return YES;
}

#pragma mark *** getters ***

-(UIImageView *)headView{
    if (!_headView) {
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, HeadView_size, HeadView_size)];
        _headView.contentMode = UIViewContentModeScaleAspectFit;
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
        _inputTextView.delegate = self;
        
        
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
        _lineView = [[LineView alloc] initWithFrame:CGRectMake(-5, CGRectGetMaxY(self.headView.frame)+5, SelfView_width+10, 100) lineWidth:SelfView_width+5];
        _lineView.backgroundColor = [UIColor clearColor];
        
    }
    return _lineView;
}

-(UILabel *)placeholder{
    if (!_placeholder) {
        _placeholder = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.inputTextView.frame), 1, 150, HeadView_size-2)];
        _placeholder.text = @"手    机    号";
        _placeholder.font = MFont(20);
        _placeholder.textColor = [UIColor whiteColor];
        _placeholder.alpha = 0.8;
        _placeholder.textAlignment = 0;
        
    }
    return _placeholder;
}

@end
