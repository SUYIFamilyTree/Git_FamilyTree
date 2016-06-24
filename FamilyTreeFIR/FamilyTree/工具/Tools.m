//
//  Tools.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/24.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "Tools.h"

@implementation Tools


#pragma mark *** VC Titles ***

NSString * _Nonnull const kStringWithHomeVcTitle = @"主页";
NSString * _Nonnull const kStringWithFamilyTreeVcTitle = @"家谱";
NSString * _Nonnull const kStringWithShoppingVcTitle = @"商场";
NSString * _Nonnull const kStringWithPersonalCenterVcTitle = @"个人中心";

#pragma mark *** VC Images ***
NSString * _Nonnull const kImageWithHomeVc = @"index_icon_a";
NSString * _Nonnull const kImageWithFamilyTreeVc = @"jiaPu_icon_a";
NSString * _Nonnull const kImageWithShoppingVc = @"shop_icon_a";
NSString * _Nonnull const kImageWithPersonalCenterVc = @"geren_icon_a";

#pragma mark *** VC SelectedImages ***

NSString * _Nonnull const kSelectedImageWithHomeVc = @"index_icon_b";
NSString * _Nonnull const kSelectedImageWithFamilyTreeVc = @"jiaPu_icon_b";
NSString * _Nonnull const kSelectedImageWithShoppingVc = @"shop_icon_b";
NSString * _Nonnull const kSelectedImageWithPersonalCenterVc = @"geren_icon_b";

#pragma mark *** 网络请求requestcode ***
//登录
NSString * _Nonnull const kRequestCodeLogin = @"login";
NSString * _Nonnull const kRequestCodeRegister = @"register";
NSString * _Nonnull const kRequestCodeUpdatePassword = @"updatepswd";
NSString * _Nonnull const kRequestCodeEditProfile = @"editperinfo";
NSString * _Nonnull const kRequestCodeBackPassword = @"backpswd";

NSString * _Nonnull const kRequestCodeGetMemallInfo = @"getmemallinfo";
NSString * _Nonnull const kRequestCodeQueryMem = @"querymem";
NSString * _Nonnull const kRequestCodeQuerygendata = @"querygendeta";
NSString * _Nonnull const kRequestCodeGetsyntype =  @"getsyntype";



+(void)showAlertViewControllerAutoDissmissWithTarGet:(id)target Message:(NSString *)message delay:(NSInteger)time complete:(void (^)(BOOL))complete{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [target presentViewController:alert animated:YES completion:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [target dismissViewControllerAnimated:YES completion:nil];
            complete(YES);
        });
    }];
}

@end
