//
//  TopBackSearch.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/8.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "TopBackSearch.h"

@implementation TopBackSearch
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.searchView.frame = CGRectMake(0.10*Screen_width, SearchToTop, 0.75*Screen_width, SearchView_Height);
        self.searchImage.frame = CGRectMake(475*AdaptationWidth(), 10*AdaptationWidth(), self.searchImage.bounds.size.width, self.searchImage.bounds.size.height);
        
        self.searchLabel.text = @"查询字辈";
        
        [self addSubview:self.backBtn];
        
    }
    return self;
}

#pragma mark *** getters ***
-(UIButton *)backBtn{
    
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(-10*AdaptationWidth(), StatusBar_Height, 44, 44)];
        [_backBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    }
    return _backBtn;
    
}
@end
