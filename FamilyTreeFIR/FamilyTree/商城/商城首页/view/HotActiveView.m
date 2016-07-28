//
//  HotActiveView.m
//  ListV
//
//  Created by imac on 16/7/22.
//  Copyright © 2016年 imac. All rights reserved.
//

#import "HotActiveView.h"
#import "HotActiVeCell.h"

@interface HotActiveView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong,nonatomic) UICollectionView *collectionV;

@end

@implementation HotActiveView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.headerReferenceSize = CGSizeMake(0, 0);
    _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, (__kWidth)*11/36) collectionViewLayout:flowLayout];
    [self addSubview:_collectionV];
    _collectionV.backgroundColor = [UIColor whiteColor];
    [_collectionV registerClass:[HotActiVeCell class] forCellWithReuseIdentifier:@"HotActiVeCell"];
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    
}

#pragma mark -UICollectionView Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotActiVeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotActiVeCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[HotActiVeCell alloc]initWithFrame:CGRectMake(0, 0, __kWidth/2, (__kWidth)*11/36)];
    }
    cell.goodNameLb.text = @"风水本命年黑石貔貅手链";
    CGFloat money = 89.0;
    cell.payMoneyLb.text = [NSString stringWithFormat:@"¥%.1f",money];
    cell.quoteLb.text = @"109.0";
    NSMutableAttributedString *quoteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",cell.quoteLb.text]];
    [quoteStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid|NSUnderlineStyleSingle) range:NSMakeRange(0, quoteStr.length)];
    cell.quoteLb.attributedText = quoteStr;//加横线
    cell.goodIV.backgroundColor = [UIColor random];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate selectCellIndexPath:indexPath];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(__kWidth/2, (__kWidth)*11/36);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
