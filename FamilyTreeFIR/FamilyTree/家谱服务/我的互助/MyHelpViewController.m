//
//  MyHelpViewController.m
//  FamilyTree
//
//  Created by 姚珉 on 16/7/28.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "MyHelpViewController.h"
#import "ScrollerView.h"
#import "MyHelpOrAttentionTableViewCell.h"
#import "AddPostViewController.h"

typedef enum : NSUInteger {
        MyPost,
        MyAttention,
} MyPostOrAttention;

@interface MyHelpViewController ()<UITableViewDataSource,UITableViewDelegate>
/** 滚动图*/
@property (nonatomic, strong) ScrollerView *bannerScrollView;
/** 切换栏白色背景*/
@property (nonatomic, strong) UIView *changeWhiteBackV;
/** 分段控件*/
@property (nonatomic, strong) UISegmentedControl *changeSC;
/** 信息表*/
@property (nonatomic, strong) UITableView *infoTB;
/** 新增发布按钮*/
@property (nonatomic, strong) UIButton *addPostBtn;
@end

@implementation MyHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self getData:MyPost];
}



#pragma mark - 视图初始化
-(void)initUI{
    [self.view addSubview:self.bannerScrollView];
    [self.view addSubview:self.changeWhiteBackV];
    self.changeWhiteBackV.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.bannerScrollView,0).heightIs(45);
    [self.changeWhiteBackV addSubview:self.changeSC];
    self.changeSC.sd_layout.centerXEqualToView(self.changeWhiteBackV).centerYEqualToView(self.changeWhiteBackV).heightIs(25).widthIs(175);
    [self.view addSubview:self.infoTB];
    self.infoTB.sd_layout.topSpaceToView(self.changeWhiteBackV,0).bottomSpaceToView(self.view,49).leftSpaceToView(self.view,0).rightSpaceToView(self.view,0);
    [self.view addSubview:self.addPostBtn];
    self.addPostBtn.sd_layout.rightSpaceToView(self.self.view,0).bottomSpaceToView(self.view,60).widthIs(45).heightIs(45);
    self.addPostBtn.sd_cornerRadius = @22.5;
}
#pragma mark - getData
-(void)getData:(MyPostOrAttention)type{
    NSDictionary *logDic = @{@"userId":GetUserId,@"type":type?@"WDGZ":@"WDFB"};
    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:GetUserId requestcode:@"querymyzqlist" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        MYLog(@"%@",jsonDic);
        if (succe) {
            
        }
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - 点击方法
-(void)changePostOrAttention:(UISegmentedControl *)seg{
    NSInteger index = seg.selectedSegmentIndex;
    switch (index) {
        case 0:
            MYLog(@"%ld",index);
            [self getData:index];
            break;
        case 1:
            MYLog(@"%ld",index);
            [self getData:index];
            break;
        default:
            break;
    }
}

-(void)clickAddPostBtn{
    AddPostViewController *addPostVC = [[AddPostViewController alloc]initWithTitle:@"新增发布" image:nil];
    [self.navigationController pushViewController:addPostVC animated:YES];
}


#pragma mark - UITableViewDateSource And UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyHelpOrAttentionCell"];
    if (!cell) {
        cell = [[MyHelpOrAttentionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyHelpOrAttentionCell"];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



#pragma mark - lazyLoad
-(ScrollerView *)bannerScrollView{
    if (!_bannerScrollView) {
        _bannerScrollView = [[ScrollerView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, 175) images:nil];
    }
    return _bannerScrollView;
}

-(UIView *)changeWhiteBackV{
    if (!_changeWhiteBackV) {
        _changeWhiteBackV = [[UIView alloc]init];
        _changeWhiteBackV.backgroundColor = [UIColor whiteColor];
    }
    return _changeWhiteBackV;
}

-(UISegmentedControl *)changeSC{
    if (!_changeSC) {
        _changeSC = [[UISegmentedControl alloc]initWithItems:@[@"我的发布",@"我的关注"]];
        _changeSC.tintColor = LH_RGBCOLOR(75, 88, 91);
        [_changeSC addTarget:self action:@selector(changePostOrAttention:) forControlEvents:UIControlEventValueChanged];
        [_changeSC setSelectedSegmentIndex:0];
    }
    return _changeSC;
}

-(UITableView *)infoTB{
    if (!_infoTB) {
        _infoTB = [[UITableView alloc]init];
        _infoTB.delegate = self;
        _infoTB.dataSource = self;
    }
    return _infoTB;
}

-(UIButton *)addPostBtn{
    if (!_addPostBtn) {
        _addPostBtn  = [[UIButton alloc]init];
        _addPostBtn.backgroundColor = [UIColor grayColor];
        [_addPostBtn setTitle:@"新增发布" forState:UIControlStateNormal];
        _addPostBtn.titleLabel.font = MFont(10);
        [_addPostBtn addTarget:self action:@selector(clickAddPostBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addPostBtn;
}
@end
