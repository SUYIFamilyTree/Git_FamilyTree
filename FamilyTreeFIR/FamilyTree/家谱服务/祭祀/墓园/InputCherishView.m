//
//  InputCherishView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/13.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "InputCherishView.h"
@interface InputCherishView()
@property (nonatomic,strong) UITextView *textView; /*说的话*/
@property (nonatomic,strong) UIButton *commitBtn; /*提交*/


@end
@implementation InputCherishView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *bacImage = [[UIImageView alloc] initWithFrame:self.bounds];
        bacImage.image = MImage(@"my_name_duiHuaK");
        [self addSubview:bacImage];
        [self addSubview:self.textView];
        [self addSubview:self.commitBtn];
    }
    return self;
}
-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:AdaptationFrame(30, 15, 300, 70)];
        _textView.text = @"你想对他说的话";
        _textView.textAlignment = 0;
        
    }
    return _textView;
}
-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [[UIButton alloc] initWithFrame:AdaptationFrame(CGRectXW(self.textView)/AdaptationWidth()-65, 102, 80, 40)];
        [_commitBtn setTitle:@"提交" forState:0];
        _commitBtn.titleLabel.font = MFont(24*AdaptationWidth());
        _commitBtn.layer.borderWidth = 1.0f;
        _commitBtn.layer.cornerRadius = 5;
        [_commitBtn setTitleColor:[UIColor blackColor] forState:0];
        
    }
    return _commitBtn;
}
@end
