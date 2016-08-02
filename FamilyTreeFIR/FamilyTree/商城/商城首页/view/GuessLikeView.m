//
//  GuessLikeView.m
//  ListV
//
//  Created by imac on 16/7/26.
//  Copyright © 2016年 imac. All rights reserved.
//

#import "GuessLikeView.h"
#import "GuessLikeCell.h"

@interface GuessLikeView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end

@implementation GuessLikeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initView{
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake((__kWidth-150)/2, 0, __kWidth, 30)];
    [self addSubview:headV];
    headV.backgroundColor = [UIColor whiteColor];

    UIImageView *likeIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 15, 15)];
    [headV addSubview:likeIV];
    likeIV.layer.cornerRadius = 7.5;
    likeIV.image = MImage(@"like");//替换成喜欢image

    UILabel *likeLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(likeIV)+4, 12, 60, 15)];
    [headV addSubview:likeLb];
    likeLb.font = MFont(14);
    likeLb.text = @"猜你喜欢";
    likeLb.textAlignment = NSTextAlignmentLeft;

    UILabel *updateLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(likeLb), 14, 70, 16)];
    [headV addSubview:updateLb];
    updateLb.font = MFont(12);
    updateLb.textColor = LH_RGBCOLOR(90, 90, 90);
    updateLb.textAlignment = NSTextAlignmentLeft;
    updateLb.text = @"(08:00更新)";//数据可刷新获取看接口文档是否有接口
    self.headView = headV;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.headerReferenceSize = CGSizeMake(0, 0);
    _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(5, CGRectYH(self.headView), __kWidth-10, __kWidth*5/9+160) collectionViewLayout:flowLayout];
    [self addSubview:_collectionV];
    [_collectionV registerClass:[GuessLikeCell class] forCellWithReuseIdentifier:@"GuessLikeCell"];
    _collectionV.backgroundColor = [UIColor whiteColor];
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    
}

#pragma mark -UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataSource.count&&self.dataSource.count!=0) {
        return self.dataSource.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GuessLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GuessLikeCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[GuessLikeCell alloc]initWithFrame:CGRectMake(0, 0, (__kWidth-10)/2, __kWidth*5/18+80)];
    }
    cell.goodIV.backgroundColor = [UIColor random];
    cell.goodNameLb.text = @"风水本命年黑曜石貔貅手链男女108颗佛珠";
    NSString *money = @"89.0";
    cell.payMoneyLb.text = [NSString stringWithFormat:@"¥%@",money];
    cell.quoteLb.text = @"109.0";
    
    if (self.dataSource) {
        GoodsDatalist *goods = self.dataSource[indexPath.row];
        
        cell.goodIV.imageURL = [NSURL URLWithString:goods.CoCover];
        cell.goodNameLb.text = goods.CoConame;
        cell.payMoneyLb.text = [NSString stringWithFormat:@"%ld",goods.CoprActpri];;
        cell.quoteLb.text = [NSString stringWithFormat:@"%ld",goods.CoprMoney];
        cell.goodId = [NSString stringWithFormat:@"%ld",goods.CoId];
        cell.goodTypeId = [NSString stringWithFormat:@"%ld",goods.CoprId];
    }
    
    NSMutableAttributedString *quoteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",cell.quoteLb.text]];
    [quoteStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid|NSUnderlineStyleSingle) range:NSMakeRange(0, quoteStr.length)];
    cell.quoteLb.attributedText = quoteStr;//加横线
    cell.shoppingBtn.userInteractionEnabled = YES;
    cell.shoppingBtn.tag = indexPath.row;
    [cell.shoppingBtn addTarget:self action:@selector(addInto:) forControlEvents:BtnTouchUpInside];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GuessLikeCell *cell = (GuessLikeCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self.delegate selectCellLike:cell.goodId];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((__kWidth-10)/2, __kWidth*17/36+10);
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

#pragma mark ==加入购物车==
- (void)addInto:(UIButton*)sender{
//    NSLog(@"商品%ld加入购物车",(long)sender.tag);
    GuessLikeCell *cell = (GuessLikeCell *)[self.collectionV cellForItemAtIndexPath:[NSIndexPath indexPathForItem:sender.tag inSection:0]];
    NSLog(@"商品%@,类型%@,加到购物车", cell.goodId,cell.goodTypeId);
    
    [self requestPostAddtoCartWithGoodNumber:cell.goodId goodsTypeId:cell.goodTypeId];
    
}
#pragma mark *** 请求添加到购物车 ***
-(void)requestPostAddtoCartWithGoodNumber:(NSString *)goodsId goodsTypeId:(NSString *)typeID{
    [TCJPHTTPRequestManager POSTWithParameters:@{@"ShCoid":goodsId,
                                                 @"ShMeid":GetUserId,
                                                 @"ShCoprid":typeID,
                                                 @"ShCount":@"1"} requestID:GetUserId requestcode:kRequestCodeaddshopcar success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
