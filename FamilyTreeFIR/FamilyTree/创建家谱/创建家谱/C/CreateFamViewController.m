//
//  CreateFamViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "CreateFamViewController.h"
#import "BackScrollAndDetailView.h"
#import "CreateFamView.h"

#import <objc/runtime.h>
@interface CreateFamViewController ()<BackScrollAndDetailViewDelegate>
@property (nonatomic,strong) CreateFamView *cFameView; /*创建家谱view*/

@end

@implementation CreateFamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.automaticallyAdjustsScrollViewInsets=false;
    self.tabBarController.tabBar.hidden = YES;
    
    [self initUI];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = false;
}

#pragma mark *** BackScrollAndDetailViewDelegate ***
-(void)BackScrollAndDetailViewDidTapCreateButton{
//    unsigned int count;
//    objc_property_t *lis = class_copyPropertyList([CreateFamView class], &count);
//    
//    for (int idx = 0; idx<count; idx++) {
//        objc_property_t *th = lis + idx;
//        const char * name = property_getName(*th);
//        NSLog(@"Person has a property: '%s'", name);
//    }
//    
//    int i;
//    unsigned int propertyCount = 0;
//    objc_property_t *propertyList = class_copyPropertyList([BackScrollAndDetailView class], &propertyCount);
//    
//    for ( i=0; i < propertyCount; i++ ) {
//        objc_property_t *thisProperty = propertyList + i;
//        const char* propertyName = property_getName(*thisProperty);
//        NSLog(@"Person has a property: '%s'", propertyName);
//    }
    
    NSArray *createModel = @[self.cFameView.famName.titleLabel.text,self.cFameView.famfarName.titleLabel.text,self.cFameView.gennerNum.inputLabel.text,self.cFameView.famBookName.text,self.cFameView.sexInpuView.inputLabel.text,[NSNumber numberWithBool:self.cFameView.diXiView.marked],[NSNumber numberWithBool:self.cFameView.famousPerson.marked],self.cFameView.inputView.inputLabel.text,self.cFameView.parnName.text,self.cFameView.selecProtrai.image,self.cFameView.birtime.inputLabel.text,self.cFameView.monthLabel.inputLabel.text,self.cFameView.dayLabel.inputLabel.text,self.cFameView.birtime.inputLabel.text,self.cFameView.liveNowLabel.inputLabel.text,self.cFameView.selfYear.inputLabel.text,self.cFameView.selfMonth.inputLabel.text,self.cFameView.selfDay.inputLabel.text,self.cFameView.generationLabel.inputLabel.text,self.cFameView.gennerationNex.text,self.cFameView.moveCity.text];
    
    NSLog(@"%@", createModel);
    
    
    
}
#pragma mark *** 初始化界面 ***
-(void)initUI{
    
    CreateFamView *creFamView = [[CreateFamView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height)];
    creFamView.delegate = self;
    self.cFameView = creFamView;
    [self.view addSubview:self.cFameView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
