//
//  PersonalCenterTodayFortuneView.h
//  FamilyTree
//
//  Created by 姚珉 on 16/6/6.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonalCenterTodayFortuneView;

@protocol PersonalCenterTodayFortuneViewDelegate <NSObject>

-(void)clickPayForFortuneBtn;

@end


@interface PersonalCenterTodayFortuneView : UIView
/** 代理人*/
@property (nonatomic, weak) id<PersonalCenterTodayFortuneViewDelegate> delegate;


@end
