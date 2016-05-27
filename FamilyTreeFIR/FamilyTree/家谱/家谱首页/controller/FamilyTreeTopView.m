//
//  FamilyTreeTopView.m
//  FamilyTree
//
//  Created by 姚珉 on 16/5/27.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "FamilyTreeTopView.h"

#define SearchToTop 30
#define SearchView_Height 25
#define SearchImage_Size 15
#define MenusBtn_size 22

@interface FamilyTreeTopView()
@property (nonatomic,strong) UIView *backView; /*黑色背景*/
@property (nonatomic,strong) UIView *searchView; /*搜索框*/
@property (nonatomic,strong) UILabel *searchLabel; /*输入关键词*/
@property (nonatomic,strong) UIImageView *searchImage; /*搜索图片*/
@property (nonatomic,strong) UIButton *menuBtn; /*右边菜单栏*/
@end

@implementation FamilyTreeTopView

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
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(0.05*Screen_width, SearchToTop, 0.75*Screen_width, SearchView_Height)];
        _searchView.layer.cornerRadius = SearchView_Height/2.0f;
        _searchView.backgroundColor = [UIColor whiteColor];
        
        //添加手势
        UITapGestureRecognizer *tapGues = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapSearchView)];
        [_searchView addGestureRecognizer:tapGues];
        
    }
    return _searchView;
}
-(UILabel *)searchLabel{
    if (!_searchLabel) {
        _searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 150, SearchView_Height)];
        _searchLabel.font = BFont(13);
        _searchLabel.textAlignment = NSTextAlignmentLeft;
        _searchLabel.text = @"输入关键词";
        _searchLabel.textColor = LH_RGBCOLOR(143, 143, 143);
        
    }
    return _searchLabel;
}
-(UIImageView *)searchImage{
    if (!_searchImage) {
        _searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.searchView.frame)-3*SearchImage_Size, self.searchView.bounds.size.height/2-SearchImage_Size/2, SearchImage_Size, SearchImage_Size)];
        _searchImage.image = MImage(@"search");
    }
    return _searchImage;
}
-(UIButton *)menuBtn{
    if (!_menuBtn) {
        _menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame)-0.07*Screen_width-MenusBtn_size/2-0.15*Screen_width, SearchToTop+(SearchView_Height-MenusBtn_size), MenusBtn_size+0.2*Screen_width, MenusBtn_size*0.8)];
        [_menuBtn setTitle:@"我的家谱" forState:UIControlStateNormal];
        _menuBtn.titleLabel.font = MFont(12);
        _menuBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_menuBtn setImage:MImage(@"sel") forState:UIControlStateNormal];
        _menuBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        _menuBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 65, 0, 0);
        [_menuBtn addTarget:self action:@selector(respondsToMenuBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _menuBtn;
}


@end
