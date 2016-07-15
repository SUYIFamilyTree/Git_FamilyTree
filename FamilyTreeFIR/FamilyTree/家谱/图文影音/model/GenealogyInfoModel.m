//
//  GenealogyInfoModel.m
//  FamilyTree
//
//  Created by 姚珉 on 16/7/14.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "GenealogyInfoModel.h"

@implementation GenealogyInfoModel
-(NSArray *)getMenuArr{
    NSMutableArray *menuArr = [@[] mutableCopy];
    if (self.Fm.count != 0) {
        [menuArr addObject:@"封面"];
    }
    if (self.Px.count != 0) {
        [menuArr addObject:@"谱序"];
    }
    if (!IsNilString(self.data.GeWords)) {
        [menuArr addObject:@"谱论"];
    }
    if (self.Ml.count != 0) {
        [menuArr addObject:@"目录"];
    }
    if (!IsNilString(self.data.GeWriter)) {
        [menuArr addObject:@"修谱名目"];
    }
    if (self.Zx.count != 0) {
        [menuArr addObject:@"祖先像赞"];
    }
    if (!IsNilString(self.data.GeIntroduction)) {
        [menuArr addObject:@"凡例"];
    }
    if (!IsNilString(self.data.GeHoner)) {
        [menuArr addObject:@"恩荣录"];
    }
    if (!IsNilString(self.data.GePrecepts)) {
        [menuArr addObject:@"家训"];
    }
    if (!IsNilString(self.data.GeTradition)) {
        [menuArr addObject:@"家风"];
    }
    if (!IsNilString(self.data.GeLaw)) {
        [menuArr addObject:@"家法"];
    }
    if (!IsNilString(self.data.GeLegend)) {
        [menuArr addObject:@"传记"];
    }
    if (!IsNilString(self.data.GeCustoms)) {
        [menuArr addObject:@"风俗礼仪"];
    }
    if (!IsNilString(self.data.GeLegend)) {
        [menuArr addObject:@"传记"];
    }
    if (self.Ct.count != 0) {
        [menuArr addObject:@"祠堂"];
    }
    if (self.Fy.count != 0) {
        [menuArr addObject:@"坟茔"];
    }
    if (self.Lz.count != 0) {
        [menuArr addObject:@"老宅"];
    }
    return [menuArr copy];
}

-(NSArray *)getInfoArr{
    NSMutableArray *infoArr = [@[] mutableCopy];
    if (self.Fm.count != 0) {
        [infoArr addObject:self.Fm];
    }
    if (self.Px.count != 0) {
        [infoArr addObject:self.Px];
    }
    if (!IsNilString(self.data.GeWords)) {
        [infoArr addObject:self.data.GeWords];
    }
    if (self.Ml.count != 0) {
        [infoArr addObject:self.Ml];
    }
    if (!IsNilString(self.data.GeWriter)) {
        [infoArr addObject:self.data.GeWriter];
    }
    if (self.Zx.count != 0) {
        [infoArr addObject:self.Zx];
    }
    if (!IsNilString(self.data.GeIntroduction)) {
        [infoArr addObject:self.data.GeIntroduction];
    }
    if (!IsNilString(self.data.GeHoner)) {
        [infoArr addObject:self.data.GeHoner];
    }
    if (!IsNilString(self.data.GePrecepts)) {
        [infoArr addObject:self.data.GePrecepts];
    }
    if (!IsNilString(self.data.GeTradition)) {
        [infoArr addObject:self.data.GeTradition];
    }
    if (!IsNilString(self.data.GeLaw)) {
        [infoArr addObject:self.data.GeLaw];
    }
    if (!IsNilString(self.data.GeLegend)) {
        [infoArr addObject:self.data.GeLegend];
    }
    if (!IsNilString(self.data.GeCustoms)) {
        [infoArr addObject:self.data.GeCustoms];
    }
    if (!IsNilString(self.data.GeLegend)) {
        [infoArr addObject:self.data.GeLegend];
    }
    if (self.Ct.count != 0) {
        [infoArr addObject:self.Ct];
    }
    if (self.Fy.count != 0) {
        [infoArr addObject:self.Fy];
    }
    if (self.Lz.count != 0) {
        [infoArr addObject:self.Lz];
    }
    return [infoArr copy];
}

@end
@implementation GenealogyInfoDataModel

@end


