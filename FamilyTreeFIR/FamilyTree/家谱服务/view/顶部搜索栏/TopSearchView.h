//
//  TopSearchView.h
//  FamilyTree
//
//  Created by 王子豪 on 16/5/26.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TopSearchView;

@protocol TopSearchViewDelegate <NSObject>

-(void)TopSearchViewDidTapView:(TopSearchView *)topSearchView;

@end

@interface TopSearchView : UIView
@property (nonatomic,weak) id<TopSearchViewDelegate> delegate; /*代理人*/

@end
