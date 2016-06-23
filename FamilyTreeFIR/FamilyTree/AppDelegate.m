//
//  AppDelegate.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/24.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarViewController.h"
#import "LoginViewController.h"
#import "TCJPHTTPRequestManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
        //状态栏
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //初始化window
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    RootTabBarViewController *rootVc = [[RootTabBarViewController alloc] init];
    
//    LoginViewController *loginVc = [[LoginViewController alloc] init];
    
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVc];
    
    _window.backgroundColor = [UIColor grayColor];
    
    _window.rootViewController = rootVc;
    
    
    [_window makeKeyAndVisible];
   
//    //查询相关数据存储plist文件
//    //查询职业
//    NSDictionary *logDic = @{@"typeval":@"GRXL"};
//    //WK(weakSelf)
//    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:@1 requestcode:@"getsyntype" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
//        if (succe) {
//            
//            //weakSelf.memallInfo = [MemallInfoModel modelWithJSON:jsonDic[@"data"]];
//            NSString *filePath = [UserDocumentD stringByAppendingPathComponent:@"job.plist"];
//            NSArray *array = @[@"abc",@123,@"a-d-g"];
//            
//            //[array writeToFile: atomically:YES];
//            
//        }else{
//            //[SXLoadingView showProgressHUD:jsonDic[@"message"] duration:0.5];
//        }
//    } failure:^(NSError *error) {
//        MYLog(@"失败---%@",error.description);
//    }];
 
   
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
