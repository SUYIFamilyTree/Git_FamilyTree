//
//  WSwitchDetailFamView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/22.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "WSwitchDetailFamView.h"
@interface WSwitchDetailFamView()

@end
@implementation WSwitchDetailFamView
- (instancetype)initWithFrame:(CGRect)frame famNamesArr:(NSArray *)famNames
{
    self = [super initWithFrame:frame];
    if (self) {
        _famNamesArray = famNames;
        [self initData];
        [self initUI];
    }
    return self;
}

#pragma mark *** 初始化数据 ***
-(void)initData{
    
}


#pragma mark *** 初始化界面 ***
-(void)initUI{
    //卷谱
    NSMutableArray *allBtnArrs = [_famNamesArray mutableCopy];
    [allBtnArrs insertObject:@"切换家谱" atIndex:0];
    [allBtnArrs addObject:@"创建家谱"];
    for (int idx = 0; idx<allBtnArrs.count; idx++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:AdaptationFrame(0, idx*63, 187, 61)];
        btn.backgroundColor = [UIColor blackColor];
        btn.layer.cornerRadius = 2;
        btn.alpha = 0.8;
        [btn setTitle:allBtnArrs[idx] forState:0];
        btn.titleLabel.font = WFont(30);
        btn.tag = idx;
        [btn addTarget:self action:@selector(respondsToAllBtnArs:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
    
    //新增和删除
    NSArray *addDeletArr = @[@"新增卷谱",@"删除卷谱"];
    for (int idx = 0; idx<addDeletArr.count; idx++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:AdaptationFrame(35, allBtnArrs.count*63+70+60*idx, 140, 60)];
        btn.backgroundColor = [UIColor blackColor];
        btn.layer.cornerRadius = 2;
        btn.alpha = 0.8;
        [btn setTitle:addDeletArr[idx] forState:0];
        btn.titleLabel.font = WFont(30);
        btn.tag = idx+allBtnArrs.count;
        [btn addTarget:self action:@selector(respondsToAllBtnArs:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, allBtnArrs.count*63*AdaptationWidth()+190);
}
#pragma mark *** events ***
-(void)respondsToAllBtnArs:(UIButton *)sender{
    NSLog(@"%@", sender.titleLabel.text);
    if (_delegate && [_delegate respondsToSelector:@selector(WswichDetailFamViewDelegate:didSelectedButton:)]) {
        [_delegate WswichDetailFamViewDelegate:self didSelectedButton:sender];
    };
}

@end
