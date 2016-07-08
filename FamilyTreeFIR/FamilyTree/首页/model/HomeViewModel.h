//
//  HomeViewModel.h
//  FamilyTree
//
//  Created by 姚珉 on 16/7/8.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeViewImgArrayModel;
@interface HomeViewModel : NSObject
/** 轮转图数组*/
@property (nonatomic, strong) NSArray<HomeViewImgArrayModel *> *imgArray;
/** 农历日期*/
@property (nonatomic, strong) NSString *rq;
/** 气节*/
@property (nonatomic, strong) NSString *qj;
@end

@interface HomeViewImgArrayModel : NSObject
/** 图片id*/
@property (nonatomic, assign) NSInteger ID;
/** 图片路径*/
@property (nonatomic, strong) NSString *imgpath;
/** 图片需要链接的地址*/
@property (nonatomic, strong) NSString *url;

@end