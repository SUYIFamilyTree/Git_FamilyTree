//
//  SelectMyFamilyView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/15.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "SelectMyFamilyView.h"
#import "MyFamilyCollectionViewCell.h"

static NSString *const kReusableMyFamCellIdentifier = @"MyFamcellIdentifier";
static NSString *const kReusableMyheaderIdentifier = @"Myheaderidentifier";



@interface SelectMyFamilyView()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView; /*集合*/

@end

@implementation SelectMyFamilyView
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
    
}
#pragma mark *** 初始化界面 ***
-(void)initUI{
    [self addSubview:self.collectionView];
}

#pragma mark *** delegate ***

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MyFamilyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReusableMyFamCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
   return cell;
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kReusableMyheaderIdentifier forIndexPath:indexPath];
    
    UILabel *label = [[UILabel alloc] initWithFrame:AdaptationFrame(0, 0, 200, 84)];
    label.text = @"我的家谱";
    label.textAlignment = 0;
    label.font = MFont(30*AdaptationWidth());
    [view addSubview:label];
    
    return view;
}
#pragma mark *** getters ***
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 22*AdaptationWidth();
        flowLayout.minimumInteritemSpacing = 28*AdaptationWidth();
        flowLayout.itemSize = AdaptationSize(200, 73);
        flowLayout.headerReferenceSize = AdaptationSize(200, 84);
        _collectionView = [[UICollectionView alloc] initWithFrame:AdaptationFrame(30, 0, self.bounds.size.width/AdaptationWidth()-60, self.bounds.size.height/AdaptationWidth()) collectionViewLayout:flowLayout];;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MyFamilyCollectionViewCell class] forCellWithReuseIdentifier:kReusableMyFamCellIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kReusableMyheaderIdentifier];
    }
    return _collectionView;
}


@end
