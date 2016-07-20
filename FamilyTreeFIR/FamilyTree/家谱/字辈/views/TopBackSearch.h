//
//  TopBackSearch.h
//  FamilyTree
//
//  Created by 王子豪 on 16/6/8.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "TopSearchView.h"
#import "SelectMyFamilyView.h"
@interface TopBackSearch : TopSearchView<SelectMyFamilyViewDelegate>
@property (nonatomic,strong) UIButton *backBtn; /*返回按钮*/
/**我的家谱↓*/
@property (nonatomic,strong) SelectMyFamilyView *selecMyFamView;
/**我的家谱btn*/
@property (nonatomic,strong) UIButton *MyFamilyRightBtn;


@end
