//
//  PrivateWorshipView.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "PrivateWorshipView.h"
#import "PrivateWorshipTableViewCell.h"

@interface PrivateWorshipView()<UITableViewDataSource,UITableViewDelegate, PrivateWorshipTableViewCellDelegate>
/** 墓园数组*/
@property (nonatomic, strong) NSArray<CemeterialModel *> *cemeterialArr;

/** 新增墓园按钮*/
@property (nonatomic, strong) UIButton *addCemeterialBtn;
@end

@implementation PrivateWorshipView
#pragma mark - lazyLoad
-(NSArray<CemeterialModel *> *)cemeterialArr{
    if (!_cemeterialArr) {
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < 2; i++) {
            CemeterialModel *cemeModel = [[CemeterialModel alloc]init];
            [arr addObject:cemeModel];
        }
        _cemeterialArr = [NSArray arrayWithArray:arr];
    }
    return _cemeterialArr;
}




-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加标题和管理
        [self initTitleAndManager];
        [self initMyTableView];
        [self initRankingLB];
        [self initCemeterialListTableView];
        [self initAddCemeterialBtn];
    }
    return self;
}

-(void)initTitleAndManager{
    UILabel *titleLB = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, Screen_width/2, 20)];
    titleLB.textAlignment = NSTextAlignmentLeft;
    titleLB.text = @"我创建的墓园";
    titleLB.font = MFont(12);
    [self addSubview:titleLB];
    UIButton *EditBtn = [[UIButton alloc]initWithFrame:CGRectMake(0.85*Screen_width, 0, 0.15*Screen_width, 25)];
    [EditBtn setTitle:@"管理" forState:UIControlStateNormal];
    [EditBtn setTitle:@"完成" forState:UIControlStateSelected];
    [EditBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [EditBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    EditBtn.titleLabel.font = MFont(12);
    [EditBtn addTarget:self action:@selector(clickEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:EditBtn];
}

-(void)initMyTableView{
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 25, Screen_width, 160) style:UITableViewStylePlain];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.bounces = NO;
    [self addSubview:self.myTableView];
}

-(void)initRankingLB{
    UILabel *rankingLB = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectYH(self.myTableView), Screen_width/2, 20)];
    rankingLB.textAlignment = NSTextAlignmentLeft;
    rankingLB.text = @"墓园排行";
    rankingLB.font = MFont(12);
    [self addSubview:rankingLB];

}

-(void)initCemeterialListTableView{
    self.cemeterialListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectYH(self.myTableView)+20, Screen_width, 160)];
    self.cemeterialListTableView.dataSource = self;
    self.cemeterialListTableView.delegate = self;
    self.cemeterialListTableView.bounces = NO;
    [self addSubview:self.cemeterialListTableView];
}

-(void)initAddCemeterialBtn{
    self.addCemeterialBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectYH(self.cemeterialListTableView)+5, Screen_width, 35)];
    self.addCemeterialBtn.backgroundColor = [UIColor whiteColor];
    [self.addCemeterialBtn setTitle:@"新建墓园" forState:UIControlStateNormal];
    [self.addCemeterialBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.addCemeterialBtn.titleLabel.font = MFont(12);
    [self.addCemeterialBtn setImage:MImage(@"mcGuanli_xinjian.png") forState:UIControlStateNormal];
    self.addCemeterialBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.addCemeterialBtn.hidden = YES;
    [self addSubview:self.addCemeterialBtn];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.myTableView]) {
        return 2;
    }else{
        return 2;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.myTableView]) {
        PrivateWorshipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"privateWorshipCell"];
        if (!cell) {
            cell = [[PrivateWorshipTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"privateWorshipCell"];
        }
        cell.editBtn.hidden = !self.cemeterialArr[indexPath.row].CemeterialModelEdit;
        cell.deleteBtn.hidden = !self.cemeterialArr[indexPath.row].CemeterialModelEdit;
        return cell;
    }else{
        PrivateWorshipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"privateWorshipCell"];
        if (!cell) {
            cell = [[PrivateWorshipTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"privateWorshipCell"];
        }
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.myTableView]){
       return 80;
    }else{
        return 80;
    }
    
}



-(void)clickEditBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    for (int i = 0; i < 2; i++) {
        self.cemeterialArr[i].CemeterialModelEdit = sender.selected;
    }
    [self.myTableView reloadData];
    
    self.addCemeterialBtn.hidden = !sender.selected;
    
    //进入编辑状态
    [self.delegate PrivateWorshipView:self didSelect:sender.selected];
    
    
    
}

#pragma mark - PrivateWorshipTableViewCellDelegate
-(void)cemeterialDidEdit:(PrivateWorshipTableViewCell *)cell{
    //跳转到编辑页面
}

-(void)cemeterialDidDelete:(PrivateWorshipTableViewCell *)cell{
    //删除该行
    
}


@end
