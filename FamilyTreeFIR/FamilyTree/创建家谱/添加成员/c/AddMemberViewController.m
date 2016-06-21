//
//  AddMemberViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "AddMemberViewController.h"
#import "AddMenberView.h"
@interface AddMemberViewController ()

@end

@implementation AddMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets=false;
    self.tabBarController.tabBar.hidden = YES;
    
    AddMenberView *addM = [[AddMenberView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height)];
    [self.view addSubview:addM];
    
  
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.tabBarController.tabBar.hidden = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
