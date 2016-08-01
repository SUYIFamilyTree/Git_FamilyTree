//
//  GuessLikeView.h
//  ListV
//
//  Created by imac on 16/7/26.
//  Copyright © 2016年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
@protocol  GuessLikeViewDelegate<NSObject>

- (void)selectCellLike:(NSString*)goodsId;

@end

@interface GuessLikeView : UIView
/**头部*/
@property (nonatomic,strong) UIView *headView;
@property (strong,nonatomic) UICollectionView *collectionV;

/**modelArr*/
@property (nonatomic,strong) NSArray <GoodsDatalist *>*dataSource;

@property (weak,nonatomic) id<GuessLikeViewDelegate>delegate;

@end
