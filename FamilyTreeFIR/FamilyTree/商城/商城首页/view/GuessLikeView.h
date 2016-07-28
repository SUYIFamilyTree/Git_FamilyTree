//
//  GuessLikeView.h
//  ListV
//
//  Created by imac on 16/7/26.
//  Copyright © 2016年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  GuessLikeViewDelegate<NSObject>

- (void)selectCellLike:(NSIndexPath*)index;

@end

@interface GuessLikeView : UIView

@property (weak,nonatomic) id<GuessLikeViewDelegate>delegate;

@end
