//
//  ToRegistView.h
//  FamilyTree
//
//  Created by 王子豪 on 16/5/27.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ToRegistView;
@protocol ToRegisViewDelegate <NSObject>

-(void)ToRegisViewDidSelectedVerfication:(ToRegistView *)registView;
-(void)ToRegisViewDidSelectedRegistBtn:(ToRegistView *)registView;
@end
@interface ToRegistView : UIView
@property (nonatomic,weak) id<ToRegisViewDelegate> delegate; /*代理人*/

@end
