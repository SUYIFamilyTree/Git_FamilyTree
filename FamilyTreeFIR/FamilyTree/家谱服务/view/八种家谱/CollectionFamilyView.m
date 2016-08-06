//
//  CollectionFamilyView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/26.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "CollectionFamilyView.h"
#import "CustomCollectionViewCell.h"

#define Cell_size 90

#define GapOfCell 10

static NSString *const kReusableCellIdentifier = @"cellIdentifier";

@interface CollectionFamilyView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSArray *_imageNames;
    NSArray *_cellNames;
}

@property (nonatomic,strong) UICollectionView *collectionView; /*几何视图*/
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout; /**< 流式布局 */


@end

@implementation CollectionFamilyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initUI];
    }
    return self;
}
#pragma mark *** 初始化数据 ***
-(void)initData{
    _imageNames = @[@"icon_1",@"icon_2",@"icon_3",@"icon_4",@"icon_5",@"icon_6",@"icon_7",@"icon_8"];
    _cellNames = @[@"传统家谱",@"数字家谱",@"教你修谱",@"赏金寻亲",@"婚庆嫁娶",@"增值服务",@"风水鉴定",@"祭祀法事"];
    
}
#pragma mark *** 初始化界面 ***
-(void)initUI{
    [self addSubview:self.collectionView];

}
#pragma mark *** collectionViewDataScource ***

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageNames.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReusableCellIdentifier forIndexPath:indexPath];
    cell.cusImage.image = MImage(_imageNames[indexPath.row]);
    cell.cusLabel.text = _cellNames[indexPath.row];
    return cell;
}
#pragma mark *** collectionViewDelegate ***
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_delegate && [_delegate respondsToSelector:@selector(CollevtionFamily:didSelectedItemAtIndexPath:)]) {
        [_delegate CollevtionFamily:self didSelectedItemAtIndexPath:indexPath];
    }
    
}

#pragma mark *** getters ***

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SelfView_width, self.bounds.size.height) collectionViewLayout:self.flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:kReusableCellIdentifier];
        
    }
    return _collectionView;
}
-(UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(40, 60);
        _flowLayout.minimumLineSpacing = 10;
        _flowLayout.minimumInteritemSpacing = (SelfView_width-4*_flowLayout.itemSize.width)/4;
        
    }
    return _flowLayout;
}
@end
