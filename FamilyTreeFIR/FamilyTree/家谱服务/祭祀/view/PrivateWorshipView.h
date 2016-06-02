//
//  PrivateWorshipView.h
//  FamilyTree
//
//  Created by 姚珉 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PrivateWorshipView;
@protocol PrivateWorshipViewDelegate <NSObject>

-(void)PrivateWorshipView:(PrivateWorshipView *)privateWorshipView didSelect:(BOOL)isEditing;

@end


@interface PrivateWorshipView : UIView
/** 我的私人墓园*/
@property (nonatomic, strong) UITableView *MyTableView;
/** 是否编辑状态*/
@property (nonatomic, assign) BOOL PrivateWorshipEdit;

/** 代理*/
@property (nonatomic, weak) id<PrivateWorshipViewDelegate> delegate;
@end
