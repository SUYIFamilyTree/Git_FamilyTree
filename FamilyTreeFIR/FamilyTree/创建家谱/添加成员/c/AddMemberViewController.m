//
//  AddMemberViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "AddMemberViewController.h"
#import "AddMenberView.h"

@interface AddMemberViewController ()<BackScrollAndDetailViewDelegate>
@property (nonatomic,strong) AddMenberView *AddFameView; /*创建家谱view*/

@end

@implementation AddMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets=false;
    self.tabBarController.tabBar.hidden = YES;
    
    AddMenberView *addM = [[AddMenberView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height)];
    addM.delegate = self;
    self.AddFameView = addM;
    [self.view addSubview:addM];
    
    [self.view bringSubviewToFront:self.comNavi];
    
  
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = false;
}

#pragma mark *** BackScrollAndDetailViewDelegate ***

-(void)BackScrollAndDetailViewDidTapCreateButton{
    MYLog(@"add");
    
    NSArray *createModel = @[self.AddFameView.name.titleLabel.text,
                             self.AddFameView.fatheView.inputLabel.text,
                             self.AddFameView.motherView.inputLabel.text,
                             self.AddFameView.sexInView.inputLabel.text,
                             self.AddFameView.idView.inputLabel.text,
                             [NSNumber numberWithBool:self.AddFameView.famousPerson.marked],
                             self.AddFameView.gennerNum.inputLabel.text,
                             self.AddFameView.rankingView.inputLabel.text,
                             self.AddFameView.inputView.inputLabel.text,
                             self.AddFameView.parnName.text,
                             self.AddFameView.selecProtrai.image,
                             self.AddFameView.birtime.inputLabel.text,
                             self.AddFameView.monthLabel.inputLabel.text,
                             self.AddFameView.dayLabel.inputLabel.text,
                             self.AddFameView.birtime.inputLabel.text,
                             self.AddFameView.liveNowLabel.inputLabel.text,
                             self.AddFameView.selfYear.inputLabel.text,
                             self.AddFameView.selfMonth.inputLabel.text,
                             self.AddFameView.selfDay.inputLabel.text,
                             self.AddFameView.generationLabel.inputLabel.text,
                             self.AddFameView.gennerationNex.text,
                             self.AddFameView.moveCity.text];
    
    
    //获取宗亲
    [SXLoadingView showProgressHUD:@"正在获取"];
    [TCJPHTTPRequestManager POSTWithParameters:@{@"query":@"",@"geid":@"1",@"pagenum":@"1",@"pagesize":@"20",@"sex":@""} requestID:GetUserId requestcode:kRequestCodequerygemelist success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        [SXLoadingView hideProgressHUD];
        NSLog(@"--rrrrr-%@", [ NSString jsonDicWithDic:jsonDic[@"data"]]);
    } failure:^(NSError *error) {
        MYLog(@"shibai");
    }];
    
    
    
    //添加成员
    
    //截取代数
    NSString *genNumber = [self.AddFameView.gennerNum.inputLabel.text stringByReplacingOccurrencesOfString:@"第" withString:@""];
    NSString *genNumberF = [genNumber stringByReplacingOccurrencesOfString:@"代" withString:@""];
    NSDictionary *addDic = @{@"GeId":@"1",
                             @"Zb":@"试",
                             @"Father":self.AddFameView.fatheView.inputLabel.text,
                             @"Ds":genNumberF,
                             @"Sf":self.AddFameView.idView.inputLabel.text,
                             @"Photo":@"",
                             @"Grjl":self.AddFameView.selfTextView.text,
                             @"Jzd":self.AddFameView.moveCity.text,
                             @"GemeSurname":@"",
                             @"GemeName":self.AddFameView.name.titleLabel.text,
                             @"GemeSex":[self.AddFameView.sexInView.inputLabel.text isEqualToString:@"女"]?@"0":@"1",
                             @"GemeIsfamous":self.AddFameView.famousPerson.marked?@"1":@"0",
                             
                             @"GemeYear":self.AddFameView.birthLabel.inputLabel.text,
                             @"GemeMonth":self.AddFameView.monthLabel.inputLabel.text,
                             @"GemeDay":self.AddFameView.dayLabel.inputLabel.text,
                             @"GemeHour":self.AddFameView.birtime.inputLabel.text,
                             @"GemeDeathtime":[self.AddFameView.liveNowLabel.inputLabel.text isEqualToString:@"是"]?@"":[NSString stringWithFormat:@"%@-%@-%@",self.AddFameView.selfYear.inputLabel.text,self.AddFameView.selfMonth.inputLabel.text,self.AddFameView.selfDay.inputLabel.text],
                             @"GemeIslife":[self.AddFameView.liveNowLabel.inputLabel.text isEqualToString:@"是"]?@"1":@"0",
                             @"Po":self.AddFameView.parnName.text,
                             };
    [TCJPHTTPRequestManager POSTWithParameters:addDic requestID:GetUserId requestcode:kRequestCodeaddgeme success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSLog(@"%@", jsonDic[@"data"]);
        }
    } failure:^(NSError *error) {
        MYLog(@"失败");
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
