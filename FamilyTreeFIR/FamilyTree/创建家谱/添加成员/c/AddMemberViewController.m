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
    
  
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = false;
}

#pragma mark *** BackScrollAndDetailViewDelegate ***
/*@property (nonatomic,strong) DiscAndNameView *name;
@property (nonatomic,strong) InputView *fatheView;
@property (nonatomic,strong) InputView *motherView;

@property (nonatomic,strong) InputView *sexInView;

@property (nonatomic,strong) InputView *idView;

@property (nonatomic,strong) ClickRoundView *famousPerson;

@property (nonatomic,strong) InputView *gennerNum;

@property (nonatomic,strong) InputView *rankingView; */
-(void)BackScrollAndDetailViewDidTapCreateButton{
    MYLog(@"add");
    
    NSArray *createModel = @[self.AddFameView.name.titleLabel.text,self.AddFameView.fatheView.inputLabel.text,self.AddFameView.motherView.inputLabel.text,self.AddFameView.sexInView.inputLabel.text,self.AddFameView.idView.inputLabel.text,[NSNumber numberWithBool:self.AddFameView.famousPerson.marked],self.AddFameView.gennerNum.inputLabel.text,self.AddFameView.rankingView.inputLabel.text,self.AddFameView.inputView.inputLabel.text,self.AddFameView.parnName.text,self.AddFameView.selecProtrai.image,self.AddFameView.birtime.inputLabel.text,self.AddFameView.monthLabel.inputLabel.text,self.AddFameView.dayLabel.inputLabel.text,self.AddFameView.birtime.inputLabel.text,self.AddFameView.liveNowLabel.inputLabel.text,self.AddFameView.selfYear.inputLabel.text,self.AddFameView.selfMonth.inputLabel.text,self.AddFameView.selfDay.inputLabel.text,self.AddFameView.generationLabel.inputLabel.text,self.AddFameView.gennerationNex.text,self.AddFameView.moveCity.text];
    
    NSLog(@"%@", createModel);
}
@end
