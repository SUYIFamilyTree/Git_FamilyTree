
//
//  FamilyHelpViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/31.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "FamilyHelpViewController.h"
#import "HelpTableTableViewCell.h"
#define BtnWidth 50
#define GapToleft 15
static NSString *const kReusableCellIdentifier = @"cellIdentifier";


@interface FamilyHelpViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UILabel *myLabel; /*label*/
@property (nonatomic,strong) UITableView *tableView; /*table*/


@end

@implementation FamilyHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];

}


#pragma mark *** 初始化界面 ***
-(void)initUI{
    NSArray *topTitles = @[@"产品众筹",@"赏金寻亲",@"捐款圆梦",@"我提供",@"我需要"];
    NSArray *imageNames = @[@"sj_icon_1",@"sj_icon_2",@"sj_icon_3",@"sj_icon_4",@"sj_icon_5"];
    for (int idx = 0; idx<topTitles.count; idx++) {
        
        //按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = idx;
        [btn addTarget:self action:@selector(respondsToAllBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:MImage(imageNames[idx]) forState:0];

        [self.view addSubview:btn];
        
        btn.sd_layout.topSpaceToView(self.comNavi,10).leftSpaceToView(self.view,GapToleft+idx*(BtnWidth+(Screen_width-GapToleft*2-topTitles.count*BtnWidth)/(topTitles.count-1))).widthIs(BtnWidth).heightIs(BtnWidth);
        
        //文字
        UILabel *label = [UILabel new];
        label.font = MFont(12);
        label.textAlignment = 1;
        label.text = topTitles[idx];
        [self.view addSubview:label];
        self.myLabel = label;
        
        label.sd_layout.topSpaceToView(btn,5).widthIs(BtnWidth).leftEqualToView(btn).heightIs(15);
        
    }
    //滚动图
    
    NSMutableArray *arr = [@[@"sj_bg",@"sj_icon_1",@"sj_icon_2"] mutableCopy];
    
    ScrollerView *scroView = [[ScrollerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myLabel.frame), Screen_width, 0.3*Screen_height) images:arr];
    [self.view addSubview:scroView];
    
    scroView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.myLabel,10);
    
}

#pragma mark *** Events ***
-(void)respondsToAllBtn:(UIButton *)sender{
    
}

#pragma mark *** tabledelegate ***
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpTableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[HelpTableTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kReusableCellIdentifier];
    }
    
    return cell;
}

#pragma mark *** getters ***
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HelpTableTableViewCell class] forCellReuseIdentifier:kReusableCellIdentifier];
    }
    return _tableView;
}

@end
