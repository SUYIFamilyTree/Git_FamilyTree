//
//  WCartTableFooterView.h
//  FamilyTree
//
//  Created by 王子豪 on 16/7/27.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCartTableFooterView : UITableViewHeaderFooterView
/**全选按钮*/
@property (nonatomic,strong) UIButton *footSelectBtn;
/**合计多少钱*/
@property (nonatomic,strong) UILabel *priceLabel;
/**结算*/
@property (nonatomic,strong) UIButton *clearPrice;



@end
