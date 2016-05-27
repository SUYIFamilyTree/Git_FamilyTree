//
//  AccountView.h
//  FamilyTree
//
//  Created by 王子豪 on 16/5/25.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountView : UIView


@property (nonatomic,strong) UIButton *goArrows; /*登入箭头*/

@property (nonatomic,strong) UIImageView *headView; /*左边图*/

- (instancetype)initWithFrame:(CGRect)frame headImage:(UIImage *)image isSafe:(BOOL)Safe hasArrows:(BOOL)hasArrows;
@end
