//
//  GoodsModel.h
//  ListV
//
//  Created by imac on 16/7/26.
//  Copyright © 2016年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject
/**
 *  商品名
 */
@property (strong,nonatomic) NSString *goodName;
/**
 *  商品实付价格
 */
@property (strong,nonatomic) NSString *goodMoney;
/**
 *  商品报价
 */
@property (strong,nonatomic) NSString *goodQuote;
/**
 *  商品图片
 */
@property (strong,nonatomic) NSString *goodImage;
@end
