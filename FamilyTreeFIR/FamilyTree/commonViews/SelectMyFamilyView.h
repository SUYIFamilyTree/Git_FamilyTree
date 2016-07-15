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

@optional
-(void)SelectMyFamilyViewDelegate:(SelectMyFamilyView *)seleMyFam didSelectItemTitle:(NSString *)title forCountOfFamNameInAllNames:(NSInteger)count;
-(void)SelectMyFamilyViewDelegate:(SelectMyFamilyView *)seleMyFam didSelectFamID:(NSString *)famId;
@end

@interface SelectMyFamilyView : UIView

@property (nonatomic,strong) UICollectionView *collectionView; /*集合*/
@property (nonatomic,copy) NSMutableArray *dataSource; /*家谱数据*/

@property (nonatomic,weak) id<SelectMyFamilyViewDelegate> delegate; /*代理人*/
-(void)updateDataSourceAndUI;
@end
