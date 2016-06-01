//
//  InputView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "InputView.h"

#define Input_height 30

@interface InputView()
{
    BOOL _isSelectedBtn;
}

@end

@implementation InputView

- (instancetype)initWithFrame:(CGRect)frame Length:(NSInteger)length withData:(NSArray *)dataArr
{
    self = [super initWithFrame:frame];
    if (self) {
        _length = length;
        _dataArr = dataArr;
        
        
        self.frame = frame;
        
        [self addSubview:self.inputLabel];
        UILabel *triLabel = [[UILabel alloc] initWithFrame:CGRectMake(length-15, 12, 10, 10)];
        triLabel.text = @"▼";
        triLabel.font = MFont(10);
        [self addSubview:triLabel];
        
    }
    return self;
}

#pragma mark *** events ***
//点击展开视图
-(void)respondsToExtendLabelBtn:(UIButton *)sender{
    self.inputLabel.text = sender.titleLabel.text;
    [self extendTheLabel];
}

//点击label展开视图
-(void)extendTheLabel{
    _isSelectedBtn = !_isSelectedBtn;
    
    if (_isSelectedBtn) {
        [UIView animateWithDuration:0.3f animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _length, (1+_dataArr.count)*Input_height);
            self.layer.borderWidth = 1.0f;
            self.layer.borderColor = BorderColor;
            for (int idx = 0; idx<_dataArr.count; idx++) {
                UIButton *selecBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, (idx+1)*Input_height, _length,Input_height)];
                [selecBtn setTitleColor:[UIColor blackColor] forState:0];
                selecBtn.backgroundColor = [UIColor whiteColor];
                [selecBtn setTitle:_dataArr[idx] forState:0];
                
                selecBtn.tag = idx+10;
                
                selecBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_length+20, 0, 0);
                
                [selecBtn addTarget:self action:@selector(respondsToExtendLabelBtn:) forControlEvents:UIControlEventTouchUpInside];
                
                [self addSubview:selecBtn];
            }
        }];
    }else{
        [UIView animateWithDuration:0.3f animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _length, Input_height);
            
            [self.subviews enumerateObjectsUsingBlock:^(UIButton * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.tag == idx+8) {
                    
                    [obj removeFromSuperview];
                }
            }];
            
        }];
        
    }
 
}


#pragma mark *** getters ***

-(UILabel *)inputLabel{
    if (!_inputLabel) {
        _inputLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,_length , Input_height)];
        _inputLabel.layer.borderWidth = 1.0f;
        _inputLabel.layer.borderColor = BorderColor;
        
        _inputLabel.textColor = [UIColor blackColor];
        _inputLabel.userInteractionEnabled   = YES;
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(extendTheLabel)];
        [_inputLabel addGestureRecognizer:tapGes];
        
    }
    return _inputLabel;
}


@end
