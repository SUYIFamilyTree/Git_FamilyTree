//
//  CreateFamViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "CreateFamViewController.h"
#import "BackScrollAndDetailView.h"
@interface CreateFamViewController ()

@end

@implementation CreateFamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BackScrollAndDetailView *vis = [[BackScrollAndDetailView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:vis];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
