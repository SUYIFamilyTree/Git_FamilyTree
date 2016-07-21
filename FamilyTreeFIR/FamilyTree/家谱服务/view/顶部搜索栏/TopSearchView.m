//
//  TopSearchView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/26.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "TopSearchView.h"


@interface TopSearchView ()

@end

@implementation TopSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backView];
        [self addSubview:self.searchView];
        
        [self.searchView addSubview:self.searchLabel];
        [self.searchView addSubview:self.searchImage];
        [self addSubview:self.menuBtn];
        
       
    }
    return self;
}

#pragma mark *** 点击搜索栏 ***
-(void)didTapSearchView{
    if (_delegate && [_delegate respondsToSelector:@selector(TopSearchViewDidTapView:)]) {
        [_delegate TopSearchViewDidTapView:self];
    }
}

#pragma mark *** 点击菜单栏 ***
-(void)respondsToMenuBtn:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(TopSearchView:didRespondsToMenusBtn:)]) {
        [_delegate TopSearchView:self didRespondsToMenusBtn:sender];
    }
}

#pragma mark *** getters ***
-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:self.bounds];
        _backView.backgroundColor = LH_RGBCOLOR(75, 88, 91);
        
    }
    return _backView;
}
-(UIView *)searchView{
    if (!_searchView) {
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(0.05*Screen_width, SearchToTop, 0.8*Screen_width, SearchView_Height)];
        _searchView.layer.cornerRadius = SearchView_Height/2.0f;
        _searchView.backgroundColor = [UIColor whiteColor];

    }
    return _searchView;
}
-(UITextField *)searchLabel{
    if (!_searchLabel) {
        _searchLabel = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, 150, SearchView_Height)];
        _searchLabel.font = BFont(13);
        _searchLabel.textAlignment = NSTextAlignmentLeft;
       
        _searchLabel.textColor = LH_RGBCOLOR(143, 143, 143);
        
    }
    return _searchLabel;
}
-(UIImageView *)searchImage{
    if (!_searchImage) {
        _searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.searchView.frame)-3*SearchImage_Size, self.searchView.bounds.size.height/2-SearchImage_Size/2, SearchImage_Size, SearchImage_Size)];
        _searchImage.image = MImage(@"search");
        _searchImage.userInteractionEnabled = true;
        //添加手势
        UITapGestureRecognizer *tapGues = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapSearchView)];
        [_searchImage addGestureRecognizer:tapGues];
        
    }
    return _searchImage;
}
-(UIButton *)menuBtn{
    if (!_menuBtn) {
        _menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame)-0.07*Screen_width-MenusBtn_size/2, SearchToTop+(SearchView_Height-MenusBtn_size), MenusBtn_size, MenusBtn_size*0.8)];
        [_menuBtn setBackgroundImage:MImage(@"chec") forState:UIControlStateNormal];
        [_menuBtn addTarget:self action:@selector(respondsToMenuBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _menuBtn;
}

@end
