//
//  GoodsCommentViewController.m
//  ListV
//
//  Created by imac on 16/7/22.
//  Copyright © 2016年 imac. All rights reserved.
//

#import "GoodsCommentViewController.h"
#import "TotalCommentView.h"
#import "CommentCell.h"
#import "CommentPersonModel.h"

@interface GoodsCommentViewController ()<TotalCommentViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
/**
 *  评价上方视图
 */
@property (strong,nonatomic) TotalCommentView *totalCommentV;
/**
 *  获取数据
 */
@property (strong,nonatomic) NSMutableArray *dataArr;
@end

@implementation GoodsCommentViewController

#pragma mark 获取数据
- (void)getData{
    _dataArr = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        CommentPersonModel *comModel =[[CommentPersonModel alloc]init];
        if (i==1) {
            comModel.userName = @"用户testbdb";
            comModel.date = @"2015-12-25";
            comModel.content = @"其实评加多少变化也不是特别的大过还是等吧点多吧嘟比嘟比就达不到看看看看看看那看那看那看那看那看你看看看看看看看看看看看卡";
            comModel.color = @"通用";
            comModel.size = @"L 宝宝1岁3个月";
        }else{
        comModel.userName = @"用户测试";
        comModel.date = @"2015-12-29";
        comModel.content = @"其实评加多少变化也不是特别的大";
        comModel.color = @"通用";
        comModel.size = @"L 宝宝1岁3个月";
        }
        [_dataArr addObject:comModel];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"评价";
    self.view.backgroundColor = [UIColor whiteColor];
    [self getData];
    [self initView];
}

-(void)initView{
    _totalCommentV = [[TotalCommentView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 120)];
    [self.view addSubview:_totalCommentV];
    _totalCommentV.delegate = self;

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight-64)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView=_totalCommentV;
    
}

#pragma mark -UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    if (!cell) {
        cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommentCell"];
    }
    CommentPersonModel *person = _dataArr[indexPath.row];
    cell.headIV.backgroundColor = [UIColor random];
    cell.nameLb.text = person.userName;
    cell.timeLb.text =person.date;
    cell.descLb.text = person.content;
    cell.infoLb.text = [NSString stringWithFormat:@"颜色：%@ 规格：%@",person.color,person.size];
    [cell updateFrame];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentPersonModel *person = _dataArr[indexPath.row];
    CGFloat height = 0.0 ;
    if (person.content.length*14>__kWidth-20) {
        for (int i=1; i<10; i++) {
            if (person.content.length*14>(__kWidth-20)*i&&person.content.length*14<=(__kWidth-20)*(i+1)) {
                height =(i+1)*16.0+105;
            }
        }
        NSLog(@"%f",height);
    }else{
        height = 120;
    }
    return height;
}
#pragma mark -TotalCommentViewDelegate Delegate
-(void)selectCommentType:(UIButton *)sender{
    NSLog(@"%ld",(long)sender.tag);
    NSLog(@"切换数据");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
