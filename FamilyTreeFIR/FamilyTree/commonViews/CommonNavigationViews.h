//
//  CommonNavigationViews.h
//  FamilyTree
//
//  Created by 王子豪 on 16/5/27.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommonNavigationViews;
@protocol CommandNavigationViewsDelegate <NSObject>

-(void)CommonNavigationViews:(CommonNavigationViews *)comView respondsToRightBtn:(UIButton *)sender;

@end
@interface CommonNavigationViews : UIView

@property (nonatomic,strong) UIView *backView; /*头部*/
@property (nonatomic,strong) UILabel *titleLabel; /*标题*/
@property (nonatomic,strong) UIButton *rightBtn; /*右边按钮*/
@property (nonatomic,strong) UIButton *MyFamilyRightBtn;
@property (nonatomic,strong) UIButton *leftBtn;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)imageName;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

//返回按钮
-(void)respondsToReturnBtn;

//右边按钮
-(void)respondsToRightBtn:(UIButton *)sender;

@property (nonatomic,weak) id<CommandNavigationViewsDelegate> delegate; /*代理人*/

@end
