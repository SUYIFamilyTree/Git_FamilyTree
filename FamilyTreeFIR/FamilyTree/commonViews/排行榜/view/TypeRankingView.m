//
//  TypeRankingView.m
//  ListV
//
//  Created by imac on 16/7/20.
//  Copyright © 2016年 imac. All rights reserved.
//

#import "TypeRankingView.h"
#import "RankingTableViewCell.h"
#import "ChooseBtnView.h"

@interface TypeRankingView()<UITableViewDelegate,UITableViewDataSource,ChooseBtnViewDelegate>

@property (strong,nonatomic) UITableView *listtableView;

@property (strong,nonatomic) ChooseBtnView *chooseBtnV;

@end

@implementation TypeRankingView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView{
    CGFloat w =self.frame.size.width;
    CGFloat h = self.frame.size.height;

    _chooseBtnV = [[ChooseBtnView alloc]initWithFrame:CGRectMake(0, 0, w, 34)];
    [self addSubview:_chooseBtnV];
    _chooseBtnV.backgroundColor = [UIColor clearColor];
    _chooseBtnV.delegate = self;

    _listtableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, w, h-30)];
    [self addSubview:_listtableView];
    _listtableView.delegate = self;
    _listtableView.dataSource = self;
    _listtableView.backgroundColor = [UIColor clearColor];

}

-(void)chooseType:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            NSLog(@"活跃榜");
        }
            break;
        case 2:
        {
            NSLog(@"人数榜");
        }
            break;
        case 3:
        {
            NSLog(@"众筹榜");
        }
            break;
        case 4:
        {
            NSLog(@"基金榜");
        }
            break;
        default:
            break;
    }

}


#pragma mark -UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RankingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankingTableViewCell"];
    if (!cell) {
        cell = [[RankingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RankingTableViewCell"];
    }
    cell.numberLb.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    cell.nameLb.text = @"陈一";
    cell.familyLb.text = @"怀宁陈氏";
    cell.activenessLb.text = [NSString stringWithFormat:@"%ld",(100-indexPath.row)];
    cell.rewardLb.text = @"20券";
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 38)];
    sectionV.backgroundColor = LH_RGBCOLOR(230, 230, 230);
    NSArray *ListArr = @[@"排名",@"用户",@"家族",@"活跃度",@"奖励"];
    for (int i =0; i<5; i++) {
        UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0+self.frame.size.width/5*i, 12, self.frame.size.width/5, 20)];
        [sectionV addSubview:titleLb];
        titleLb.backgroundColor = [UIColor clearColor];
        titleLb.font = MFont(14);
        titleLb.textAlignment = NSTextAlignmentCenter;
        titleLb.text = ListArr[i];
    }

    return sectionV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 34;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 38;
}



@end
