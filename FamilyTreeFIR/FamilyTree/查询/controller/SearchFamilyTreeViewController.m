//
//  SearchFamilyTreeViewController.m
//  FamilyTree
//
//  Created by 姚珉 on 16/5/27.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "SearchFamilyTreeViewController.h"
#import "SearchTableViewCell.h"

@interface SearchFamilyTreeViewController()<UITableViewDelegate,UITableViewDataSource>
/** 搜索栏*/
@property (nonatomic, strong) UIView *searchView;


@end

@implementation SearchFamilyTreeViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = LH_RGBCOLOR(236, 236, 236);
    //导航栏
    [self initNavi];
    //搜索栏
    [self initSearchBar];
    //添加表格
    [self initTableView];
    
}
//导航栏
-(void)initNavi{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, 64)];
    topView.backgroundColor = LH_RGBCOLOR(75, 88, 91);
    [self.view addSubview:topView];
    
    CGFloat topLabelWidth = 40;
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake((Screen_width-topLabelWidth)/2, StatusBar_Height, topLabelWidth, NavigationBar_Height)];
    topLabel.text = @"查询";
    topLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:topLabel];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 35, 8, 15)];
    [leftButton setBackgroundImage:MImage(@"fanhui.png") forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(Screen_width-38, 32, 20, 20)];
    [rightButton setBackgroundImage:MImage(@"chec.png") forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
}
//搜索栏
-(void)initSearchBar{
    _searchView = [[UIView alloc]initWithFrame:CGRectMake(12, NavigationBar_Height+StatusBar_Height+8, Screen_width-24, 30)];
    _searchView.layer.cornerRadius = 30/2.0f;
    _searchView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_searchView];
    UITextField *searchTF = [[UITextField alloc]initWithFrame:CGRectMake(25, NavigationBar_Height+StatusBar_Height+8, Screen_width-50, 30)];
    searchTF.backgroundColor = [UIColor whiteColor];
    searchTF.placeholder = @"输入关键词";
    searchTF.font = MFont(13);
    [self.view addSubview:searchTF];
    UIImageView *searchImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectXW(searchTF)-8, CGRectY(searchTF)+8, 15, 15)];
    searchImageView.image = MImage(@"search");
    [self.view addSubview:searchImageView];
    UITapGestureRecognizer *searchTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickSearch)];
    [searchImageView addGestureRecognizer:searchTap];
    
}
//添加表格
-(void)initTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectYH(_searchView)+10, Screen_width, 120)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}
//返回按钮
-(void)clickLeftButton{
    [self.navigationController popViewControllerAnimated:YES];
}

//导航栏右侧菜单
-(void)clickRightButton{
    MYLog(@"点击右侧菜单");
}

//点击搜索图标
-(void)clickSearch{
    MYLog(@"搜索开始");
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell"];
    if (!cell) {
        cell = [[SearchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchCell"];
    }
    if (indexPath.row == 0) {
        cell.imageV.image = MImage(@"find");
        cell.titleLB.text = @"同支宗亲";
        cell.detailLB.text = @"查找同支宗亲";
    }else{
        cell.imageV.image = MImage(@"adress");
        cell.titleLB.text = @"附近宗亲";
        cell.detailLB.text = @"查找附近宗亲";
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
