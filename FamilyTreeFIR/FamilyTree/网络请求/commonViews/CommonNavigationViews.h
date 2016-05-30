//
//  CommonNavigationViews.h
//  FamilyTree
//
//  Created by 王子豪 on 16/5/27.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonNavigationViews : UIView

@property (nonatomic,strong) UIView *backView; /*头部*/
@property (nonatomic,strong) UILabel *titleLabel; /*标题*/
@property (nonatomic,strong) UIButton *rightBtn; /*右边按钮*/

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)imageName;
//返回按钮
-(void)respondsToReturnBtn;

//右边按钮
-(void)respondsToRightBtn:(UIButton *)sender;


@end
