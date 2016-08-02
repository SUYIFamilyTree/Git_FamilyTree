//
//  WCartTableViewCell.h
//  FamilyTree
//
//  Created by 王子豪 on 16/7/27.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodNumberView.h"
@interface WCartTableViewCell : UITableViewCell<GoodNumberViewDelegate>
/**图片*/
@property (nonatomic,strong) UIImageView *cellImage;
/**商品名字*/
@property (nonatomic,strong) UILabel *cellName;
/**款式*/
@property (nonatomic,strong) UILabel *cellType;
/**数量*/
@property (nonatomic,strong) GoodNumberView *cellNumber;
/**单价*/
@property (nonatomic,strong) UILabel *cellPrice;
/**购物车id*/
@property (nonatomic,strong) NSString *cellCarId;
/**商品id*/
@property (nonatomic,strong) NSString *cellGoodsId;





@end
