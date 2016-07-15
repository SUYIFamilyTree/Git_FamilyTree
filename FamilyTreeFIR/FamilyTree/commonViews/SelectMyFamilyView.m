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
    
    NSArray *arr = @[@""];
    NSArray *arr2 = @[@"修谱名目",@"家训家风",@"世系图",@"字辈",@"恩荣录",@"名人传记",@"图文影音",@"家族互助",@"风俗礼仪",@"祠堂",@"坟茔",@"契约"];
    _dataSource = [@[arr,arr2] mutableCopy];

}

-(void)updateDataSourceAndUI{
    //获取我的所有家谱
    _dataSource[0] = [WSelectMyFamModel sharedWselectMyFamModel].myFamArray;
    [self.collectionView reloadData];
        
}

#pragma mark *** 初始化界面 ***
-(void)initUI{
    [self addSubview:self.collectionView];
}

#pragma mark *** delegate ***

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _dataSource.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return ((NSArray *)(_dataSource[section])).count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MyFamilyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReusableMyFamCellIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = _dataSource[indexPath.section][indexPath.row];
    
   return cell;
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kReusableMyheaderIdentifier forIndexPath:indexPath];
    [view removeAllSubviews];
    if (indexPath.section == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:AdaptationFrame(0, 0, 200, 84)];
        label.text = @"我的家谱";
        label.textAlignment = 0;
        label.font = MFont(30*AdaptationWidth());
        [view addSubview:label];
    }else {
        UIView *lineView = [[UIView alloc] initWithFrame:AdaptationFrame(0, 43, 658, 1)];
        lineView.backgroundColor = LH_RGBCOLOR(240, 240, 240);
        [view addSubview:lineView];
    }
    
    
    return view;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MyFamilyCollectionViewCell *cell = ((MyFamilyCollectionViewCell *)([collectionView cellForItemAtIndexPath:indexPath]));
    
    //点击section 0的时候
    if (indexPath.section == 0) {
        /**
         *  在有重复名字家谱的情况下，判断点击的家谱名是第几个。因为用家谱名获取id时会得到数组
         */
        
//        NSInteger famRepeatCount = 0;
//        NSMutableArray *arrC = [@[] mutableCopy];
//        for (int idx = 0; idx<indexPath.row; idx++) {
//            [arrC addObject:self.dataSource[0][idx]];
//        }
//        
//        for (NSString *string in arrC) {
//            if ([string isEqualToString:cell.titleLabel.text]) {
//                famRepeatCount += 1;
//            }
//        }
        
//        if (_delegate && [_delegate respondsToSelector:@selector(SelectMyFamilyViewDelegate:didSelectItemTitle:forCountOfFamNameInAllNames:)]) {
//            [_delegate SelectMyFamilyViewDelegate:self didSelectItemTitle:cell.titleLabel.text forCountOfFamNameInAllNames:famRepeatCount];
//        }
//        

        if (_delegate && [_delegate respondsToSelector:@selector(SelectMyFamilyViewDelegate:didSelectFamID:)]) {
            [_delegate SelectMyFamilyViewDelegate:self didSelectFamID:[WSelectMyFamModel sharedWselectMyFamModel].myFamIdArray[indexPath.row]];
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(SelectMyFamilyViewDelegate:didSelectFamTitle:SelectFamID:)]) {
            [_delegate SelectMyFamilyViewDelegate:self didSelectFamTitle:cell.titleLabel.text SelectFamID:[WSelectMyFamModel sharedWselectMyFamModel].myFamIdArray[indexPath.row]];
        };
        
    }
    
    
}

#pragma mark *** respondsToBlackArea ***
//点击黑色背景移除视图
-(void)respondsToBlackArea{
    [self removeFromSuperview];
}
#pragma mark *** getters ***
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 22*AdaptationWidth();
        flowLayout.minimumInteritemSpacing = 28*AdaptationWidth();
        flowLayout.itemSize = AdaptationSize(200, 73);
        flowLayout.headerReferenceSize = AdaptationSize(200, 84);
        _collectionView = [[UICollectionView alloc] initWithFrame:AdaptationFrame(30, 0, self.bounds.size.width/AdaptationWidth()-60, 634) collectionViewLayout:flowLayout];;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MyFamilyCollectionViewCell class] forCellWithReuseIdentifier:kReusableMyFamCellIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kReusableMyheaderIdentifier];
        //背景
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,Screen_width, _collectionView.bounds.size.height)];
        whiteView.backgroundColor = [UIColor whiteColor];
        UIView *halfBlackView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectYH(whiteView), Screen_width, 500*AdaptationWidth())];
        halfBlackView.backgroundColor = [UIColor blackColor];
        halfBlackView.alpha = 0.6;
        halfBlackView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapHaG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondsToBlackArea)];
        [halfBlackView addGestureRecognizer:tapHaG];
        
        
        [self addSubview:whiteView];
        [self addSubview:halfBlackView];
    }
    return _collectionView;
}


@end
