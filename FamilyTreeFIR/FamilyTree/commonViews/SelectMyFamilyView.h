//
//  SelectMyFamilyView.h
//  FamilyTree
//
//  Created by 王子豪 on 16/6/15.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectMyFamilyView;

@protocol SelectMyFamilyViewDelegate <NSObject>

-(void)SelectMyFamilyViewDelegate:(SelectMyFamilyView *)seleMyFam didSelectItemTitle:(NSString *)title;

@end

@interface SelectMyFamilyView : UIView
@property (nonatomic,weak) id<SelectMyFamilyViewDelegate> delegate; /*代理人*/

@end
