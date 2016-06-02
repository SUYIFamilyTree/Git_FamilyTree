//
//  PrivateWorshipView.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "PrivateWorshipView.h"
#import "PrivateWorshipTableViewCell.h"

@interface PrivateWorshipView()<UITableViewDataSource>

@end

@implementation PrivateWorshipView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加标题和管理
        [self initTitleAndManager];
        [self initMyTableView];
    }
    return self;
}

-(void)initTitleAndManager{
    UILabel *titleLB = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, Screen_width/2, 25)];
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
    self.MyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 25, Screen_width, (CGRectH(self)-50)/2) style:UITableViewStylePlain];
    self.MyTableView.dataSource = self;
    self.MyTableView.rowHeight = CGRectH(self.MyTableView)/2;
    self.MyTableView.bounces = NO;
    [self addSubview:self.MyTableView];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PrivateWorshipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"privateWorshipCell"];
    if (!cell) {
        cell = [[PrivateWorshipTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"privateWorshipCell"];
    }
    cell.cellEdit = self.PrivateWorshipEdit;
    return cell;
}


-(void)clickEditBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.PrivateWorshipEdit = sender.selected;
    //进入编辑状态
    [self.delegate PrivateWorshipView:self didSelect:sender.selected];
    
}




@end
