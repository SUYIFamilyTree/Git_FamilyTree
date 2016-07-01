//
//  PrivateWorshipTableViewCell.h
//  FamilyTree
//
//  Created by 姚珉 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CemeterialModel.h"

@class PrivateWorshipTableViewCell;
@protocol  PrivateWorshipTableViewCellDelegate<NSObject>

-(void)cemeterialDidEdit:(PrivateWorshipTableViewCell *)cell;
-(void)cemeterialDidDelete:(PrivateWorshipTableViewCell *)cell;

@end

@interface PrivateWorshipTableViewCell : UITableViewCell
/** 编辑按钮*/
@property (nonatomic, strong) UIButton *editBtn;
/** 删除按钮*/
@property (nonatomic, strong) UIButton *deleteBtn;
/** 是否处于编辑状态*/
//@property (nonatomic, assign)BOOL cellEdit;
/** 代理人*/
@property (nonatomic, weak) id<PrivateWorshipTableViewCellDelegate> delegate;
/** 祭陵图*/
@property (nonatomic, strong) UIImageView *cemeterialImageView;
/** 祭陵名字*/
@property (nonatomic, strong) NSString *cemeterialName;
/** 园号*/
@property (nonatomic, strong) NSString *cemeterialID;
/** 浏览人数*/
@property (nonatomic, strong) NSString *visitorNumber;
@end
