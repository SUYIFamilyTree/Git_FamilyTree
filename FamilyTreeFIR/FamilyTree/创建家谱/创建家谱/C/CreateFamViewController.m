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
    
    //创建家谱
    
    NSArray *createModel = @[self.cFameView.famName.titleLabel.text,
                             self.cFameView.famfarName.titleLabel.text,
                             self.cFameView.gennerNum.inputLabel.text,
                             self.cFameView.famBookName.text,
                             self.cFameView.sexInpuView.inputLabel.text,
                             [NSNumber numberWithBool:self.cFameView.diXiView.marked],
                             [NSNumber numberWithBool:self.cFameView.famousPerson.marked],
                             self.cFameView.inputView.inputLabel.text,
                             self.cFameView.parnName.text,self.cFameView.selecProtrai.image,
                             self.cFameView.birthLabel.inputLabel.text,
                             self.cFameView.monthLabel.inputLabel.text,
                             self.cFameView.dayLabel.inputLabel.text,
                             self.cFameView.birtime.inputLabel.text,
                             self.cFameView.liveNowLabel.inputLabel.text,
                             self.cFameView.selfYear.inputLabel.text,
                             self.cFameView.selfMonth.inputLabel.text,
                             self.cFameView.selfDay.inputLabel.text,
                             self.cFameView.generationLabel.inputLabel.text,
                             self.cFameView.gennerationNex.text,
                             self.cFameView.selfTextView.text,
                             self.cFameView.moveCity.text];
    
//    NSLog(@"%@", self.cFameView.gennerNexArr);
    
    NSMutableDictionary *genDsListDic = [NSMutableDictionary dictionary];
    
    [self.cFameView.gennerNexArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (![obj isEqualToString:@""]) {
            [genDsListDic setValue:@[obj] forKey:[NSString stringWithFormat:@"%ld",idx+1]];
        }
        
    }];
//    NSLog(@"1111---%@", genDsListDic);
    //截取代数
    NSLog(@"%@", self.cFameView.gennerNum.inputLabel.text);
   
    NSString *genNumber = [self.cFameView.gennerNum.inputLabel.text stringByReplacingOccurrencesOfString:@"第" withString:@""];
    NSString *genNumberF = [genNumber stringByReplacingOccurrencesOfString:@"代" withString:@""];
    NSLog(@"%@", genNumberF);
    
    NSDictionary *dic = @{@"Ds":genNumberF,
                          @"GeSurname":@"",
                          @"JpName":self.cFameView.famBookName.text,
                          @"GeName":self.cFameView.famName.titleLabel.text,
                          @"GePhoto":@"",
                          @"Photo":@"",
                          @"Grjl":self.cFameView.selfTextView.text,
                          @"Jzd":self.cFameView.moveCity.text,
                          @"GemeSurname":@"",
                          @"GemeName":self.cFameView.famfarName.titleLabel.text,
                          @"GemeSex":[self.cFameView.sexInpuView.inputLabel.text isEqualToString:@"女"]?@"0":@"1",
                          @"GemeYear":self.cFameView.birthLabel.inputLabel.text,
                          @"GemeMonth":self.cFameView.monthLabel.inputLabel.text,
                          @"GemeDay":self.cFameView.dayLabel.inputLabel.text,
                          @"GemeHour":self.cFameView.birtime.inputLabel.text,
                          @"GemeDeathtime":[self.cFameView.liveNowLabel.inputLabel.text isEqualToString:@"是"]?@"":[NSString stringWithFormat:@"%@-%@-%@",self.cFameView.selfYear.inputLabel.text,self.cFameView.selfMonth.inputLabel.text,self.cFameView.selfDay.inputLabel.text],
                          @"GemeIslife":[self.cFameView.liveNowLabel.inputLabel.text isEqualToString:@"是"]?@"1":@"0",
                          @"Po":self.cFameView.parnName.text,
                          @"IsEnt":self.cFameView.diXiView.marked?@"1":@"0",
                          @"DsList":genDsListDic};
        
//    NSLog(@"Create--%@", dic);
    

    
    //查询我的家谱
//    NSDictionary *dic1 = @{@"query":@"王氏家谱",
//                           @"type":@"MyGen",
//                           };
//    NSDictionary *dic2 = @{@"geid":@"4"};
//    
//    NSDictionary *dic3 = @{@"query":@"王氏家谱",@"type":@"Same"};
    
//    [TCJPHTTPRequestManager POSTWithParameters:dic requestID:GetUserId requestcode:kRequestCodecreategen success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
//        if (succe) {
//            
//             NSLog(@"%@", jsonDic[@"data"]);
//            
//        }
//    } failure:^(NSError *error) {
//        
//    }];
    
    NSMutableArray *arr = [@[@"1",@"2",@"3"] mutableCopy];
    arr[0] = @"2";
    
    NSLog(@"%@", arr);
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.view endEditing:YES];
}

@end
