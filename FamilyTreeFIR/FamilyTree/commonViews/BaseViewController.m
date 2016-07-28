//
//  BaseViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/31.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()


@end

@implementation BaseViewController

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.comNavi = [[CommonNavigationViews alloc] initWithFrame:CGRectMake(0, 0, Screen_width, 44+StatusBar_Height) title:@"四海同宗" image:image];
        self.comNavi.titleLabel.text = title;
        if (image == nil) {
            self.comNavi.rightBtn.userInteractionEnabled = NO;
        }
        
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        self.comNavi = [[CommonNavigationViews alloc] initWithFrame:CGRectMake(0, 0, Screen_width, 44+StatusBar_Height) title:nil];
        self.comNavi.titleLabel.text = title;
        
    }
    return self;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.comNavi];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark *** getters ***





@end
