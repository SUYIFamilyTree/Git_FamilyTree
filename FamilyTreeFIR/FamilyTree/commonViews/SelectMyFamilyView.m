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
{
    NSInteger _itemBtnSelectedIndex;
}
@property (nonatomic,assign) NSInteger selectedItemNumber; /*选择了多少个*/

/**五个item*/
@property (nonatomic,strong) UICollectionView *itemCollectionView;

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
    NSArray <NSString *>*arr2 = @[@"四海同宗",@"世系图",@"阅读家谱",@"字辈",@"图文影音"];
    _dataSource = [@[arr,arr2] mutableCopy];
    _didSelectedItem = false;
    _selectedItemNumber = 0;
}

-(void)updateDataSourceAndUI{
    //获取我的所有家谱
    _dataSource[0] = [WSelectMyFamModel sharedWselectMyFamModel].myFamArray;
    [self.collectionView reloadData];
    
}

#pragma mark *** 初始化界面 ***
-(void)initUI{
    
    [self addSubview:self.collectionView];
    [self addSubview:self.itemCollectionView];
    
}

#pragma mark *** delegate ***

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.itemCollectionView) {
        return _dataSource[1].count;
    }
    return _dataSource[0].count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MyFamilyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReusableMyFamCellIdentifier forIndexPath:indexPath];
    
    if (collectionView == self.itemCollectionView) {
        
        cell.titleLabel.text = _dataSource[1][indexPath.row];

    }else{
        
        cell.titleLabel.text = _dataSource[indexPath.section][indexPath.row];
    
    }
    
   return cell;
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kReusableMyheaderIdentifier forIndexPath:indexPath];
    view.backgroundColor = [UIColor whiteColor];
    [view removeAllSubviews];
    
    if (collectionView == self.collectionView) {
        UILabel *label = [[UILabel alloc] initWithFrame:AdaptationFrame(0, 0, 200, 84)];
        label.text = @"我的家谱";
        label.textAlignment = 0;
        label.font = WFont(30);
        [view addSubview:label];
        
        UIButton *HeadBtn = [[UIButton alloc] initWithFrame:AdaptationFrame(550, 0, 100, 84)];
        [HeadBtn setTitle:@"确定" forState:0];
        [HeadBtn setTitleColor:[UIColor redColor] forState:0];
        HeadBtn.titleLabel.font = WFont(30);
        [HeadBtn addTarget:self action:@selector(respondsToHeadBtn) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:HeadBtn];
        
    }else{
        UIView *lineView = [[UIView alloc] initWithFrame:AdaptationFrame(0, view.bounds.size.height/AdaptationWidth()/2-2, view.bounds.size.width/AdaptationWidth(), 1)];
        lineView.backgroundColor = LH_RGBCOLOR(240, 240, 240);
        [view addSubview:lineView];
    }
    
    return view;
}
#pragma mark *** UICollectionViewDelegate ***

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MyFamilyCollectionViewCell *cell = ((MyFamilyCollectionViewCell *)([collectionView cellForItemAtIndexPath:indexPath]));
    
    //点击section 0的时候
    if (collectionView == self.collectionView) {
        
        _didSelectedItem = true;
 
        if (_delegate && [_delegate respondsToSelector:@selector(SelectMyFamilyViewDelegate:didSelectFamID:)]) {
            [_delegate SelectMyFamilyViewDelegate:self didSelectFamID:[WSelectMyFamModel sharedWselectMyFamModel].myFamIdArray[indexPath.row]];
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(SelectMyFamilyViewDelegate:didSelectFamTitle:SelectFamID:)]) {
            [_delegate SelectMyFamilyViewDelegate:self didSelectFamTitle:cell.titleLabel.text SelectFamID:[WSelectMyFamModel sharedWselectMyFamModel].myFamIdArray[indexPath.row]];
        };
        
        //点过后存起来
        [WFamilyModel shareWFamilModel].myFamilyId = [WSelectMyFamModel sharedWselectMyFamModel].myFamIdArray[indexPath.row];
        [WFamilyModel shareWFamilModel].myFamilyName = cell.titleLabel.text;
        
        [USERDEFAULT setObject:[WSelectMyFamModel sharedWselectMyFamModel].myFamIdArray[indexPath.row] forKey:kNSUserDefaultsMyFamilyID];
        [USERDEFAULT setObject:cell.titleLabel.text forKey:kNSUserDefaultsMyFamilyName];
        [USERDEFAULT synchronize];
        
        NSLog(@"家谱名:%@---id:%@", cell.titleLabel.text,[WSelectMyFamModel sharedWselectMyFamModel].myFamIdArray[indexPath.row]);
        
    }else{
        _selectedItemNumber = indexPath.row+1;
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
   
}
#pragma mark *** btnEvents ***
-(void)respondsToHeadBtn{
    MYLog(@"确定按钮");
    
    if (!_selectedItemNumber||!_didSelectedItem) {
        return;
    }
    
    /** 通知跳转 */
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationCodeSeletedMyFamilItem object:nil userInfo:@{@"itemName":@(_selectedItemNumber)}];
    
    [self removeFromSuperview];
}
#pragma mark *** respondsToBlackArea ***
//点击黑色背景移除视图
-(void)respondsToBlackArea{
//    [self removeFromSuperview];
}
#pragma mark *** getters ***
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 22*AdaptationWidth();
        flowLayout.minimumInteritemSpacing = 28*AdaptationWidth();
        flowLayout.itemSize = AdaptationSize(200, 73);
        flowLayout.headerReferenceSize = AdaptationSize(200, 84);
        flowLayout.sectionHeadersPinToVisibleBounds = true;
        _collectionView = [[UICollectionView alloc] initWithFrame:AdaptationFrame(30, 0, self.bounds.size.width/AdaptationWidth()-60, 450) collectionViewLayout:flowLayout];;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MyFamilyCollectionViewCell class] forCellWithReuseIdentifier:kReusableMyFamCellIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kReusableMyheaderIdentifier];
    
        //背景
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,Screen_width, 710*AdaptationWidth())];
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
-(UICollectionView *)itemCollectionView{
    if (!_itemCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 22*AdaptationWidth();
        flowLayout.minimumInteritemSpacing = 28*AdaptationWidth();
        flowLayout.itemSize = AdaptationSize(200, 73);
        flowLayout.headerReferenceSize = AdaptationSize(200, 84);
        flowLayout.sectionHeadersPinToVisibleBounds = true;
        _itemCollectionView = [[UICollectionView alloc] initWithFrame:AdaptationFrame(30, CGRectYH(self.collectionView)/AdaptationWidth(), self.bounds.size.width/AdaptationWidth()-60, 260) collectionViewLayout:flowLayout];
        
        _itemCollectionView.delegate = self;
        _itemCollectionView.dataSource = self;
        _itemCollectionView.backgroundColor = [UIColor whiteColor];
        [_itemCollectionView registerClass:[MyFamilyCollectionViewCell class] forCellWithReuseIdentifier:kReusableMyFamCellIdentifier];
        [_itemCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kReusableMyheaderIdentifier];

    }
    return _itemCollectionView;
}
@end
