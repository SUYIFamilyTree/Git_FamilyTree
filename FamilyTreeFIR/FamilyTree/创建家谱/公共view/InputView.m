//
//  InputView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "InputView.h"

#define Input_height InputView_height

@interface InputView()
{
    BOOL _isSelectedBtn;
}
@property (nonatomic,strong) UIScrollView *backScroView; /*背景可滚动*/


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
        UILabel *triLabel = [[UILabel alloc] initWithFrame:CGRectMake(length-13, 15, 10, 10)];
        triLabel.text = @"▼";
        triLabel.font = MFont(8);
        [self addSubview:triLabel];
        
        
    }
    return self;
}

#pragma mark *** events ***
//点击展开视图
-(void)respondsToExtendLabelGes:(UITapGestureRecognizer *)sender{
    UILabel *gesView = (UILabel *)sender.view;
    self.inputLabel.text = gesView.text;
    [self extendTheLabel];
    
}

//点击label展开视图
-(void)extendTheLabel{
    _isSelectedBtn = !_isSelectedBtn;
    
    if (_isSelectedBtn) {
        
        
        
//        [UIView animateWithDuration:0.3f animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _length, ((1+_dataArr.count)>4?4:(1+_dataArr.count))*(Input_height-10));
            self.layer.borderWidth = 1.0f;
            self.layer.borderColor = BorderColor;
        
        
            for (int idx = 0; idx<_dataArr.count; idx++) {
                
                UILabel *seleclabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (idx)*(Input_height-10), _length,Input_height-10)];
                seleclabel.textColor = [UIColor blackColor];
                seleclabel.backgroundColor = [UIColor whiteColor];
                seleclabel.text = [NSString stringWithFormat:@"  %@",_dataArr[idx]];
                seleclabel.userInteractionEnabled = YES;
                seleclabel.font = WFont(35);
                
                seleclabel.textAlignment = 0;
                
                UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondsToExtendLabelGes:)];
                
                
                [seleclabel addGestureRecognizer:tapGes];
                
                
                
                [self.backScroView addSubview:seleclabel];
                [self addSubview:self.backScroView];
                
            }

        //        }];
    }else{
//        [UIView animateWithDuration:0.3f animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _length, Input_height);
            
            [self.backScroView.subviews enumerateObjectsUsingBlock:^(UILabel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [obj removeFromSuperview];
            }];
            
//        }];
        
    }
    
    
 
}


#pragma mark *** getters ***

-(UILabel *)inputLabel{
    if (!_inputLabel) {
        _inputLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,_length , Input_height)];
        _inputLabel.layer.borderWidth = 1.0f;
        _inputLabel.layer.borderColor = BorderColor;
        _inputLabel.backgroundColor = [UIColor whiteColor];
        _inputLabel.textColor = [UIColor blackColor];
        _inputLabel.userInteractionEnabled  = YES;
        _inputLabel.textAlignment = 0;
        _inputLabel.font = WFont(35);
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(extendTheLabel)];
        [_inputLabel addGestureRecognizer:tapGes];
        
    }
    return _inputLabel;
}

-(UIScrollView *)backScroView{
    if (!_backScroView) {
        
        _backScroView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, (Input_height-10), _length, (Input_height-10)*3)];
        _backScroView.bounces = true;
        _backScroView.contentSize = CGSizeMake(_length, (Input_height-10)*_dataArr.count);
        
    }
    return _backScroView;
}


@end
