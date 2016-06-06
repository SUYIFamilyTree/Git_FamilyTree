//
//  PersonalCenterHeaderView.h
//  FamilyTree
//
//  Created by 姚珉 on 16/6/3.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonalCenterHeaderView;
@protocol PersonalCenterHeaderViewDelegate <NSObject>

-(void)clickMoneyViewToPay;
-(void)clickSameCityMoneyViewToPay;
@end

@interface PersonalCenterHeaderView : UIView
/** 金钱数量*/
@property (nonatomic, assign) double money;
/** 同城币数量*/
@property (nonatomic, assign) NSInteger sameCityMoney;
/** 代理人*/
@property (nonatomic, weak) id<PersonalCenterHeaderViewDelegate> delegate;
@end
