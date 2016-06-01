
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
static NSString *const kReuserableUITableViewCell = @"UITableViewCell";






@interface FamilyHelpViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *dataSource; /*数据源*/

@property (nonatomic,assign) NSInteger selectedBtnNum; /*选择的第几个btn*/



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
    
    _selectedBtnNum = 0;
    
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
    
    //tableView
    [self.view addSubview:self.tableView];
    
    self.tableView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.myLabel,0.3*Screen_height+20).bottomSpaceToView(self.tabBarController.tabBar,0);
    
}

#pragma mark *** Events ***
-(void)respondsToAllBtn:(UIButton *)sender{
    MYLog(@"%ld",sender.tag);
    _selectedBtnNum = sender.tag;
   
    [self.tableView reloadData];
    
}

#pragma mark *** tableDataSource ***
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_selectedBtnNum==0) {
        return 5;
    }
    
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中第产品众筹
    if (_selectedBtnNum == 0) {
        HelpTableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableCellIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[HelpTableTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kReusableCellIdentifier];
        }
        
        cell.leftImageView.image = MImage(@"sj_bg");
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuserableUITableViewCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kReuserableUITableViewCell];
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectedBtnNum == 0) {
        return 0.2*Screen_width+10;
    }
    return 40;
}

#pragma mark *** getters ***
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HelpTableTableViewCell class] forCellReuseIdentifier:kReusableCellIdentifier];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuserableUITableViewCell];
    }
    return _tableView;
}

-(NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[@"怀宁陈氏陈大大80搜眼成功在合肥举行",@"安寝护士呼啸而预估三娘在上海举办虎离成功",@"西安网师办教育修船成功",@"昨天但是大量数据库大力加快速度"];
        
    }
    
    return _dataSource;
}

@end
