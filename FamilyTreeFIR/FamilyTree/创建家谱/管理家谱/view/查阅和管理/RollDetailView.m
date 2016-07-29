//
//  RollDetailView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/15.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "RollDetailView.h"
@interface RollDetailView()


@end

@implementation RollDetailView
- (instancetype)initWithFrame:(CGRect)frame leftViewDataArr:(NSArray *)leftArr rightViewDataArr:(NSArray *)rightArr
{
    self = [super initWithFrame:frame];
    if (self) {
        _leftArr = leftArr;
        _rightArr = rightArr;
        
        [self initData];
        [self initUIR];
        self.backgroundColor = [UIColor whiteColor];
        
        
        
    }
    return self;
}
#pragma mark *** 初始化数据 ***
-(void)initData{
    
}
#pragma mark *** 初始化界面 ***
-(void)initUIR{

    //左边信息
    for (int idx = 0; idx<_leftArr.count; idx++) {
        NSInteger length = ((NSString *)_leftArr[idx]).length;
        UILabel *leftLB = [[UILabel alloc] initWithFrame:AdaptationFrame(16, 16, length*50, 50+idx*90)];
        leftLB.font = MFont(22*AdaptationWidth());
        leftLB.text = _leftArr[idx];
        
        NSInteger length2 = 0;
        UILabel *rightLb = [[UILabel alloc] init];
//        if (idx==1&&![((NSString *)(_rightArr[idx][0])) isEqualToString:@"无数据"]) {
//            length2 = ((NSString *)_rightArr[idx][0]).length;
//            rightLb = [[UILabel alloc] initWithFrame:AdaptationFrame(CGRectXW(leftLB), 16, length2*50, leftLB.bounds.size.height/AdaptationWidth())];
//            rightLb.text = _rightArr[idx][0];
//        }else{
        
        length2 = ((NSString *)_rightArr[idx]).length;
        rightLb = [[UILabel alloc] initWithFrame:AdaptationFrame(CGRectXW(leftLB), 16, length2*50, leftLB.bounds.size.height/AdaptationWidth())];
        rightLb.text = _rightArr[idx];
            
     
        
        
        rightLb.font = leftLB.font;
        
        [self addSubview:leftLB];
        [self addSubview:rightLb];
        
    }
    
    [self addSubview:self.headImageView];

    [self addSubview:self.nameLabel];
    
    [self addSubview:self.genLabel];
    
}
-(UIImageView *)headImageView{
    if (!_headImageView) {
        //右边头像和代数
        UIImageView *headView = [[UIImageView alloc] initWithFrame:AdaptationFrame(272, 15, 134, 149)];
        headView.image = MImage(@"news_touxiang");
        headView.contentMode = UIViewContentModeScaleAspectFit;
        _headImageView = headView;
        
        
        
    }
    return _headImageView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.frame.origin.x, CGRectYH(self.headImageView), self.headImageView.bounds.size.width, 30*AdaptationWidth())];
        nameLabel.textAlignment = 1;
        nameLabel.font = MFont(25*AdaptationWidth());
        nameLabel.text = _rightArr[0];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}
-(UILabel *)genLabel{
    if (!_genLabel) {
        UILabel *genLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectXW(self.headImageView)+15*AdaptationWidth(), self.headImageView.frame.origin.y, 36*AdaptationWidth(), self.headImageView.bounds.size.height)];
        genLabel.font = MFont(25*AdaptationWidth());
        genLabel.textAlignment = 1;
        genLabel.text = [NSString verticalStringWith:@"第一代"];
        genLabel.layer.cornerRadius = 18*AdaptationWidth();
        genLabel.clipsToBounds = YES;
        genLabel.numberOfLines = 0;
        genLabel.textColor = [UIColor whiteColor];
        genLabel.backgroundColor = LH_RGBCOLOR(59, 59, 59);
        _genLabel = genLabel;
    }
    return _genLabel;
}
@end
