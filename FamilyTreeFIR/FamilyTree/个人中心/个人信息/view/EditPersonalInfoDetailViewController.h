//
//  EditPersonalInfoDetailViewController.h
//  FamilyTree
//
//  Created by 姚珉 on 16/6/16.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditPersonalInfoDetailViewController : UIViewController
/** 更改哪项内容*/
@property (nonatomic, copy) NSString *detailStr;
/** 文本框内容*/
@property (nonatomic, copy) NSString *TFStr;
@end
