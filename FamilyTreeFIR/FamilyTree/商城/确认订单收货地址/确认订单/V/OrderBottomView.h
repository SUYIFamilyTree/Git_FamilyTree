//
//  OrderBottomView.h
//  ListV
//
//  Created by imac on 16/8/2.
//  Copyright © 2016年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderBottomView : UIView
/**
 *  订单报价
 */
@property (strong,nonatomic) UILabel *orderQuoteLb;
/**
 *  运费
 */
@property (strong,nonatomic) UILabel *orderFreightLb;
/**
 *  优惠
 */
@property (strong,nonatomic) UILabel *concessionsLb;
/**
 *  应付金额
 */
@property (strong,nonatomic) UILabel *orderPayLb;

@end
