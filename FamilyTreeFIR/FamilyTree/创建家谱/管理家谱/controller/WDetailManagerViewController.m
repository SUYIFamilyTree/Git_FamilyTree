//
//  WDetailManagerViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/21.
//  Copyright © 2016年 王子豪. All rights reserved.
//
enum{
    ADDmemberBtnTag,
    ADDmanagerBtnTag
};
#import "WDetailManagerViewController.h"

@interface WDetailManagerViewController ()
@property (nonatomic,strong) UIScrollView *backScrollView; /*背景滚动图*/
@property (nonatomic,strong) RollView *rollView; /*多少代卷谱*/
@property (nonatomic,strong) RollDetailView *rollDetail; /*具体某人*/

@property (nonatomic,strong) UIButton *addMemberBtn;/*新增成员*/
@property (nonatomic,strong) UIButton *addManagerBtn; /*新增管理*/


@end

@implementation WDetailManagerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initData];
    [self initUI];
    
}

#pragma mark *** 初始化数据 ***
-(void)initData{
    
}
#pragma mark *** 初始化界面 ***
-(void)initUI{
    [self.view addSubview:self.backScrollView];
    [self.backScrollView addSubview:self.rollView];
    [self.backScrollView addSubview:self.rollDetail];
    [self initAllDetailManagerDetailView];
}


//初始化所有具体图
-(void)initAllDetailManagerDetailView{
    
    NSArray *titleArr = @[@"姓名：",@"名族：",@"出生地：",@"妻子：",@"养子："];
    
    NSArray *subDetaiArr = @[@[@"段正淳",@"白族",@"大理",@"刀白凤",@"段誉"],@[@"段誉",@"白族",@"大理",@"段正淳",@"刀白凤"],@[@"段正淳",@"白族",@"大理",@"刀白凤",@"段誉"],@[@"段正淳",@"白族",@"大理",@"刀白凤",@"段誉"],@[@"段智兴",@"白族",@"大理",@"刀白凤",@"段誉"],@[@"段智商",@"白族",@"大理",@"刀白凤",@"段誉"]];
    NSArray *genNum = @[@"第一代",@"第二代",@"第三代",@"第三代",@"第四代",@"第四代"];
    
    NSArray *frameArr = @[[NSValue valueWithCGPoint:CGPointMake(30+ZeroContentOffset, 30)],[NSValue valueWithCGPoint:CGPointMake(270, 270)],[NSValue valueWithCGPoint:CGPointMake(195, 510)],[NSValue valueWithCGPoint:CGPointMake(195, 750)],[NSValue valueWithCGPoint:CGPointMake(121, 990)],[NSValue valueWithCGPoint:CGPointMake(121, 1230)],];
    
    for (int idx = 0; idx<subDetaiArr.count; idx++) {
        CGPoint potRect = [frameArr[idx] CGPointValue];
        
        RollDetailView *rollView = [[RollDetailView alloc] initWithFrame:AdaptationFrame(potRect.x, potRect.y, 500, 200) leftViewDataArr:titleArr rightViewDataArr:subDetaiArr[idx]];
        rollView.genLabel.text = [NSString verticalStringWith:genNum[idx]];
//        rollView.tag = idx;
        
//        //添加手势
//        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondsToRooTapGes:)];
//        
//        [rollView addGestureRecognizer:tapGes];
        
        [self.backScrollView addSubview:rollView];
        
        [self.view addSubview:self.addMemberBtn];
        [self.view  addSubview:self.addManagerBtn];
        
    }
}

#pragma mark *** events ***
-(void)respondsToMemberAndManagerBtn:(UIButton *)sender{
    NSLog(@"%@", sender.titleLabel.text);
    if ([sender.titleLabel.text isEqualToString:@"新增成员"]) {
        AddMemberViewController *addMenVc = [[AddMemberViewController alloc] initWithTitle:@"添加成员" image:nil];
        [self.navigationController pushViewController:addMenVc animated:YES];
    }
}
#pragma mark *** getters ***
-(UIScrollView *)backScrollView{
    if (!_backScrollView) {
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, HeightExceptNaviAndTabbar)];
        _backScrollView.contentSize = AdaptationSize(1040, 1500);
        _backScrollView.contentOffset = AdaptationCenter(ZeroContentOffset, 0);
        _backScrollView.bounces = false;
        UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _backScrollView.contentSize.width, _backScrollView.contentSize.height)];
        backView.image = MImage(@"gljp_bg");
        [_backScrollView addSubview:backView];
        
    }
    return _backScrollView;
}
-(RollView *)rollView{
    if (!_rollView) {
        _rollView = [[RollView alloc] initWithFrame:AdaptationFrame(558+ZeroContentOffset, 30, 135, 360) withTitle:@"段正淳1|5带卷谱" rollType:RollViewTypeUnitsDigit];
        
    }
    return _rollView;
}

-(UIButton *)addMemberBtn{
    if (!_addMemberBtn) {
        _addMemberBtn = [[UIButton alloc] initWithFrame:AdaptationFrame(self.view.bounds.size.width/AdaptationWidth()-146, 727, 146, 63)];
        [_addMemberBtn setTitle:@"新增成员" forState:0];
        _addMemberBtn.backgroundColor = [UIColor blackColor];
        _addMemberBtn.alpha =0.8;
        _addMemberBtn.titleLabel.font = WFont(30);
        _addMemberBtn.layer.cornerRadius = 2;
        _addMemberBtn.clipsToBounds = YES;
        _addMemberBtn.tag = ADDmemberBtnTag;
        [_addMemberBtn addTarget:self action:@selector(respondsToMemberAndManagerBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addMemberBtn;
}
-(UIButton *)addManagerBtn{
    if (!_addManagerBtn) {
        _addManagerBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.addMemberBtn.frame.origin.x, CGRectYH(self.addMemberBtn)+3, self.addMemberBtn.frame.size.width, self.addMemberBtn.frame.size.height)];
        [_addManagerBtn setTitle:@"新增管理" forState:0];
        _addManagerBtn.backgroundColor = self.addMemberBtn.backgroundColor;
        _addManagerBtn.alpha = 0.8;
        _addManagerBtn.titleLabel.font = self.addMemberBtn.titleLabel.font;
        _addManagerBtn.layer.cornerRadius = 2;
        _addManagerBtn.clipsToBounds = YES;
        _addManagerBtn.tag = ADDmanagerBtnTag;
        [_addManagerBtn addTarget:self action:@selector(respondsToMemberAndManagerBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _addManagerBtn;
}
@end
