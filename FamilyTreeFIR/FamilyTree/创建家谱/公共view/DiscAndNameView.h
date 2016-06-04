//
//  DiscAndNameView.h
//  FamilyTree
//
//  Created by 王子豪 on 16/6/3.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscAndNameView : UIView
@property (nonatomic,strong) UILabel *titleLabel; /*标题*/
@property (nonatomic,strong) UILabel *detailLabel; /*内容*/

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title detailCont:(NSString *)detailcont isStar:(BOOL)star;
@end
