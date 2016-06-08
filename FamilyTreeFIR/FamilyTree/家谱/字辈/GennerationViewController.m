//
//  GennerationViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/8.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "GennerationViewController.h"

@interface GennerationViewController ()
@property (nonatomic,strong) TopBackSearch *topView; /*头部搜索带返回键*/

@end

@implementation GennerationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topView];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark *** getters ***

-(TopBackSearch *)topView{
    if (!_topView) {
        _topView = [[TopBackSearch alloc] initWithFrame:CGRectMake(0, 0, Screen_width, StatusBar_Height+NavigationBar_Height)];
        
    }
    return _topView;
}

@end

