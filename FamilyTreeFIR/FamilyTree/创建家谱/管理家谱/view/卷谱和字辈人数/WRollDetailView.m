//
//  WRollDetailView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/22.
//  Copyright © 2016年 王子豪. All rights reserved.
//
enum {
    BTNTAGRead,
    BTNTAGManager
};
#import "WRollDetailView.h"
@interface WRollDetailView()
{
    NSMutableArray *_leftArr;
    NSMutableArray *_rightArr;
}
/**背景*/
@property (nonatomic,strong) UIView *backView;

@end
@implementation WRollDetailView

- (instancetype)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backView];
        
        [self initData];
        [self initUI];
    }
    return self;
}

-(void)updateUI{
    
    WJPPersonZBNumberModel *model = [WJPPersonZBNumberModel sharedWJPPersonZBNumberModel];
    
    NSInteger personNumber = 0;
    
    for (int idx = 0; idx<model.datalist.count; idx++) {
        _leftArr[idx+2] = [NSString stringWithFormat:@"%@：",model.datalist[idx].zb];
        _rightArr[idx+2] = [NSString stringWithFormat:@"%ld",model.datalist[idx].cnt];
        
        personNumber += model.datalist[idx].cnt;
        
    }
    
    _rightArr[0] = [NSString stringWithFormat:@"%ld",personNumber];
    
    [self removeAllSubviews];
    [self addSubview:self.backView];
    [self initUI];
    
    
}
#pragma mark *** 初始化数据 ***
-(void)initData{
    _leftArr = [@[@"人数：",@"字辈：",@"",@"",@"",@"",@""] mutableCopy];
    
    _rightArr = [@[@"",@"",@"",@"",@"",@"",@""] mutableCopy];
}

#pragma mark *** events ***
-(void)respondsTolefTwBtn:(UIButton *)sender{
    switch (sender.tag) {
        case BTNTAGRead:
        {
            WDetailManagerViewController *detaiVc = [[WDetailManagerViewController alloc] initWithTitle:@"管理卷谱" image:nil];
            [[self viewController].navigationController pushViewController:detaiVc animated:YES];
        }
            break;
        case BTNTAGManager:
        {
            WDetailManagerViewController *detaiVc = [[WDetailManagerViewController alloc] initWithTitle:@"管理卷谱" image:nil];
            [[self viewController].navigationController pushViewController:detaiVc animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark *** 初始化界面 ***
-(void)initUI{
  
    
    //具体信息
    for (int idx = 0; idx<_leftArr.count; idx++) {
        NSInteger length = ((NSString *)_leftArr[idx]).length;
        UILabel *leftLB = [[UILabel alloc] initWithFrame:AdaptationFrame(16+46, 16, length*27, 45+idx*90)];
        leftLB.font = MFont(26*AdaptationWidth());
        leftLB.text = _leftArr[idx];
        
        
        NSInteger length2 = ((NSString *)_rightArr[idx]).length;
        UILabel *rightLb = [[UILabel alloc] initWithFrame:AdaptationFrame(CGRectXW(leftLB)/AdaptationWidth(), 16, length2*50, leftLB.frame.size.height/AdaptationWidth())];
        rightLb.text = [NSString stringWithFormat:@"%@人",_rightArr[idx]];
        rightLb.font = leftLB.font;
        
        [self addSubview:leftLB];
        [self addSubview:rightLb];
        
    }
    
    //左边两个btn
    NSArray *btnTitle = @[@"查阅",@"管理"];
    NSArray *colorArr = @[LH_RGBCOLOR(217, 169, 129),LH_RGBCOLOR(90, 110, 115)];
    for (int idx = 0; idx<btnTitle.count; idx++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:AdaptationFrame(0, 24+167*idx, 47, 134)];
        [btn setTitle:btnTitle[idx] forState:0];
        btn.tag = idx;
        btn.titleLabel.font = WFont(32);
        [btn setTitleColor:[UIColor whiteColor] forState:0];
        btn.titleLabel.numberOfLines = 0;
        btn.backgroundColor = colorArr[idx];
        btn.layer.cornerRadius = 2;
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(respondsTolefTwBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

#pragma mark *** getters ***
-(UIView *)backView{
    if (!_backView) {
        //背景加边框
        UIView *bakView = [[UIView alloc] initWithFrame:CGRectMake(46*AdaptationWidth(), 0, 225*AdaptationWidth(), self.bounds.size.height)];
        bakView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
        bakView.layer.borderWidth = 1.0f;
        bakView.layer.borderColor = LH_RGBCOLOR(234, 221, 200).CGColor;
        
        _backView = bakView;
        
    }
    return _backView;
}
@end
