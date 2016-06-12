//
//  PersonalCenterMyPhotoAlbumsView.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/11.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "PersonalCenterMyPhotoAlbumsView.h"
#import "CALayer+drawborder.h"
@implementation PersonalCenterMyPhotoAlbumsView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //头视图
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, 28)];
        [CALayer drawBottomBorder:headView];
        [self addSubview:headView];
        //我的相册
        UILabel *myPhotoLB = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 60, 18)];
        myPhotoLB.text = @"我的相册";
        myPhotoLB.font = MFont(14);
        [self addSubview:myPhotoLB];
        //more
        UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0.8038*CGRectW(self), 8, 60, 18)];
        [moreBtn setTitle:@"MORE" forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(clickMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
        [moreBtn setTitleColor:LH_RGBCOLOR(118, 118, 118) forState:UIControlStateNormal];
        moreBtn.titleLabel.font = MFont(12);
        [self addSubview:moreBtn];
        //三张照片
        [self initPhotosIV];
    }
    return self;
}

-(void)clickMoreBtn:(UIButton *)sender{
    MYLog(@"相册更多");
    [self.delegate clickMoreBtnTo];
}

-(void)initPhotosIV{
    for (int i = 0; i < 3; i++) {
        UIImageView *photosIV = [[UIImageView alloc]initWithFrame:CGRectMake(0.0875*CGRectW(self)+0.2813*CGRectW(self)*i, 40, 0.2578*CGRectW(self), 90)];
        photosIV.image = MImage(@"gr_ct_photo");
        [self addSubview:photosIV];
    }
}
@end
