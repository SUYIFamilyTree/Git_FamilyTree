//
//  LineageCellView.h
//  FamilyTree
//
//  Created by 姚珉 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineageCellView : UIView
/** 头像视图*/
@property (nonatomic, strong) UIImageView *headIV;
/** 姓名标签*/
@property (nonatomic, strong) UILabel *nameLB;
/** 关系标签*/
@property (nonatomic, strong) UILabel *relationLB;
/** 性别*/
//决定边框颜色
@property (nonatomic,getter=isMan) BOOL man;
@end
