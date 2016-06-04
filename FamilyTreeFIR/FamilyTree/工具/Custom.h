//
//  Custom.h
//  测试接口
//
//  Created by 姚珉 on 16/5/25.
//  Copyright © 2016年 yaomin. All rights reserved.
//

#ifndef Custom_h
#define Custom_h

//NSLog
#ifdef DEBUG        //调试状态打开LOG功能
#define MYLog(...) NSLog(__VA_ARGS__)
#else               //发布状态关闭LOG功能
#define MYLog(...)
#endif

//weakSelf
#define WK(weakSelf) \
__block __weak __typeof(&*self)weakSelf = self;

//屏幕宽高

#define Screen_width CGRectGetWidth([UIScreen mainScreen].bounds)
#define Screen_height CGRectGetHeight([UIScreen mainScreen].bounds)
#define StatusBar_Height [[UIApplication sharedApplication] statusBarFrame].size.height
#define NavigationBar_Height self.navigationController.navigationBar.frame.size.height
//view自身宽高
#define SelfView_width self.bounds.size.width
#define SelfView_height self.bounds.size.height

//导航栏，状态栏

#define StatusBar_Height [[UIApplication sharedApplication] statusBarFrame].size.height
#define NavigationBar_Height self.navigationController.navigationBar.frame.size.height

//字体大小
#define MFont(font)   [UIFont systemFontOfSize:(font)]
#define BFont(font)   [UIFont boldSystemFontOfSize:(font)]
//图片命名
#define MImage(image) [UIImage imageNamed:(image)]


#define IsNull(__Text) [__Text isKindOfClass:[NSNull class]]
#define IsEquallString(_Str1,_Str2)  [_Str1 isEqualToString:_Str2]
//RGB
#define LH_RGBCOLOR(R, G, B)    [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1.0]
#define BorderColor LH_RGBCOLOR(215, 215, 215).CGColor
//addmethod
#define CGRectOrigin(v)    v.frame.origin
#define CGRectSize(v)      v.frame.size
#define CGRectX(v)         CGRectOrigin(v).x
#define CGRectY(v)         CGRectOrigin(v).y
#define CGRectW(v)         CGRectSize(v).width
#define CGRectH(v)         CGRectSize(v).height

#define CGRectXW(v)         (CGRectSize(v).width+CGRectOrigin(v).x)
#define CGRectYH(v)         (CGRectSize(v).height+CGRectOrigin(v).y)
#define USERDEFAULT [NSUserDefaults standardUserDefaults]

//RootURL
#define RootURL @"http://59.53.92.160:85/Api/Mobile/TestPost"
#define SecretKeySend @"abc123"
#define SecretKeyReiceive @"123abc"
//登录信息
#define LoginStates @"loginStatus"
#define UserId @"userid"
#define Password @"password"
//创建家谱控件高度
#define InputView_height 40

#endif /* Custom_h */
