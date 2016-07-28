//
//  ShoppingTypeView.h
//  ListV
//
//  Created by imac on 16/7/22.
//  Copyright © 2016年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShoppingTypeViewDelegate <NSObject>

- (void)pushView:(NSInteger)sender;

@end

@interface ShoppingTypeView : UIView

@property (weak,nonatomic) id<ShoppingTypeViewDelegate>delegate;
@end
