//
//  RootTabBarViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/24.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "Tools.h"

#define TabBarBtn_tag 10

@interface RootTabBarViewController ()
{
    NSArray *_viewControllersTitles;
    NSArray *_barImageArr;
    NSArray *_barSelectedImageArr;
}

-(void)configTabBarViewController;  /**< 配置标签控制器 */
-(void)initTabBarItem;/*自定义标签栏item*/
-(void)initData;/*初始化数据*/
@end

@implementation RootTabBarViewController

#pragma mark *** 生命周期 ***
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self configTabBarViewController];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark *** 初始化数据 ***
-(void)initData{
    //标题、图片和选择图片
    _viewControllersTitles = @[kStringWithHomeVcTitle,kStringWithFamilyTreeVcTitle,kStringWithShoppingVcTitle,kStringWithPersonalCenterVcTitle];
    _barImageArr = @[kImageWithHomeVc,kImageWithFamilyTreeVc,kImageWithShoppingVc,kImageWithPersonalCenterVc];
    _barSelectedImageArr = @[kSelectedImageWithHomeVc,kSelectedImageWithFamilyTreeVc,kSelectedImageWithShoppingVc,kSelectedImageWithPersonalCenterVc];
}

#pragma mark *** 配置标签控制器 ***

-(void)configTabBarViewController{
    //初始化控制器
    HomeViewController *homeVc = [[HomeViewController alloc] init];
    FamilyTreeViewController *familyVc = [[FamilyTreeViewController alloc] init];
    ShoppingViewController *shopVc = [[ShoppingViewController alloc] init];
    
    PersonalCenterViewController *personCen = [[PersonalCenterViewController alloc] init];
    
    //控制器数组
    NSArray *viewControllers = @[homeVc,familyVc,shopVc,personCen];
    
    //配置全部viewControllers的导航控制器
    NSMutableArray *navs = [@[] mutableCopy];
    
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController *  _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *title = _viewControllersTitles[idx];
        
        vc.title = title;
        
        //初始化导航控制器
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.navigationBar.barTintColor = [UIColor colorWithRed:75/255.0 green:88/255.0 blue:91/255.0 alpha:1];
        nav.navigationBar.tintColor = [UIColor blackColor];
        nav.navigationBar.translucent = YES;
        //隐藏导航栏
//        nav.navigationController.toolbarHidden = YES;
        
        //配置标签栏item
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
        tabBarItem.title = _viewControllersTitles[idx];
        tabBarItem.image = [UIImage imageNamed:_barImageArr[idx]];
        tabBarItem.selectedImage = [UIImage imageNamed:_barSelectedImageArr[idx]];
        
        vc.tabBarItem = tabBarItem;
        
        [navs addObject:nav];
    }];
    
    //设置标签控制器的导航控制器
    self.viewControllers = navs;
    //配置标签栏颜色
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor blackColor];
    self.selectedIndex = 0;
    
//    [self initTabBarItem];
    
}

#pragma mark *** 自定义标签栏item ***
-(void)initTabBarItem{
    //便利删除标签栏说有控件
    for (UIView *subView in self.tabBar.subviews) {
        [subView removeFromSuperview];
    }
    //自定义Item
    NSInteger itemAmount = _viewControllersTitles.count;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width/itemAmount;
    CGFloat height = CGRectGetHeight(self.tabBar.bounds);
    
    for (int i = 0; i<itemAmount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置大小和位置
//        btn.backgroundColor = [UIColor redColor];
        btn.frame = CGRectMake(i*width, 0, width, height);
        [btn setTitle:_viewControllersTitles[i] forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        btn.tag=TabBarBtn_tag+i;
        [btn addTarget:self action:@selector(respondsToItemBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.adjustsImageWhenHighlighted = NO;
        [btn setImage:[UIImage imageNamed:_barImageArr[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:_barSelectedImageArr[i]] forState:UIControlStateFocused];
        if (btn.tag == TabBarBtn_tag+3) {
            btn.backgroundColor = [UIColor orangeColor];
            NSLog(@"%f", CGRectGetMaxX(btn.bounds));
            
            btn.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, -45);
            
            btn.titleEdgeInsets = UIEdgeInsetsMake(19, 0, 0, 19);

        }

        //添加按钮
        [self.tabBar addSubview:btn];
    }
    
}
#pragma mark *** BtnEvents ***

-(void)respondsToItemBtn:(UIButton *)sender{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    self.selectedIndex = sender.tag-TabBarBtn_tag;
}

@end
