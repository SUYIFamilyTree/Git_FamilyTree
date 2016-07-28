//
//  NeedRushView.h
//  ListV
//
//  Created by imac on 16/7/26.
//  Copyright © 2016年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
@protocol NeedRushViewDelegate <NSObject>
/**
 *  点击cell 跳转到详情页
 */
- (void)selectCellRush:(NSIndexPath*)index;

@end

@interface NeedRushView : UIView

@property (weak,nonatomic) id<NeedRushViewDelegate>delegate;

@property (strong,nonatomic) NSMutableArray<GoodsModel*> *rushArr;

@end
