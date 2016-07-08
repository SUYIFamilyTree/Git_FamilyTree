//
//  AllGoodsView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/13.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "AllGoodsView.h"
#import "CemSingleGoodsCollectionViewCell.h"


static NSString *const kReusableCemGoodsCellIdentifier = @"cemGoodsCell";


@interface AllGoodsView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView; /*集合视图*/


@end
@implementation AllGoodsView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
    }
    return self;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //MYLog(@"贡品数组%@",_goodsArr);
    return 3;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CemSingleGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReusableCemGoodsCellIdentifier forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            cell.cemGoodsShopModel = self.goodsArr[indexPath.row];
            break;
        case 1:
            cell.cemGoodsShopModel = self.goodsArr[indexPath.row+5];
            break;
        case 2:
            cell.cemGoodsShopModel = self.goodsArr[indexPath.row+10];
        default:
            break;
    }
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *nameArr = @[@"供花",@"供果",@"供香"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:AdaptationFrame(0, 10, 200, 42)];
    label.font = MFont(30*AdaptationWidth());
    label.text = nameArr[indexPath.section];
    
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headLabel" forIndexPath:indexPath];
    [header addSubview:label];
    return header;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"%ld", indexPath.row);
    CemSingleGoodsCollectionViewCell *cell = (CemSingleGoodsCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.selectedItem) {
        [self.isSelectedGoodsArr addObject:cell.cemGoodsShopModel];
    }else{
        [self.isSelectedGoodsArr removeObject:cell.cemGoodsShopModel];
    }
    
    //MYLog(@"%@",self.isSelectedGoodsArr);
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = AdaptationSize(81, 129);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 26*AdaptationWidth();
        flowLayout.headerReferenceSize = AdaptationSize(200, 60);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        _collectionView.allowsSelection = YES;
        
        [_collectionView registerClass:[CemSingleGoodsCollectionViewCell class] forCellWithReuseIdentifier:kReusableCemGoodsCellIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headLabel"];
    }
    return _collectionView;
}

-(NSMutableArray *)isSelectedGoodsArr{
    if (!_isSelectedGoodsArr) {
        _isSelectedGoodsArr = [@[] mutableCopy];
    }
    return _isSelectedGoodsArr;
}

@end
