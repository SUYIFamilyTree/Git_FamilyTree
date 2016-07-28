//
//  WShopCartView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/7/27.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "WShopCartView.h"
#import "WCartTableViewCell.h"
#import "WCartTableHeaderView.h"
#import "WCartTableFooterView.h"
static NSString *const kReusableCartCellIdentifier = @"WCartTableViewCell.h";

@interface WShopCartView()<UITableViewDataSource,UITableViewDelegate,WCartTableHeaderDelegate>
{
    BOOL _isSelectedEditBtn;
}

/**白色背景图*/
@property (nonatomic,strong) UIView *whiteView;

/**table*/
@property (nonatomic,strong) UITableView *tableView;

@end
@implementation WShopCartView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initUI];
    }
    return self;
}
#pragma mark *** 初始化数据 ***
-(void)initData{
    
}
#pragma mark *** 初始化界面 ***
-(void)initUI{
    UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.5;
    [self addSubview:backView];
    [self addSubview:self.tableView];
}
#pragma mark *** UITableViewDelegate ***
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableCartCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[WCartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kReusableCartCellIdentifier];
    }
    return  cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WCartTableHeaderView *headView = [[WCartTableHeaderView alloc] initWithFrame:AdaptationFrame(0, 0, self.tableView.bounds.size.width/AdaptationWidth(), 66)];
    [CALayer drawBottomBorder:headView];
    
    headView.delegate = self;
    return headView;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    WCartTableFooterView *footerView = [[WCartTableFooterView alloc] initWithFrame:AdaptationFrame(0, 0, self.tableView.bounds.size.width/AdaptationWidth(), 93)];
    [CALayer drawTopBorder:footerView];
    [CALayer drawBottomBorder:footerView];
    return footerView;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPat{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isSelectedEditBtn) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleInsert | UITableViewCellEditingStyleDelete;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"删除了--%@", NSStringFromSelector(_cmd));
}
#pragma mark *** WCartTableHeaderViewDelegate ***
-(void)WcartTableHeaderView:(WCartTableHeaderView *)headerView didSeletedButtion:(UIButton *)sender{
    NSLog(@"%@", sender.titleLabel.text);
    if ([sender.titleLabel.text isEqualToString:@"编辑"]) {
        _isSelectedEditBtn = !_isSelectedEditBtn;
        //触发改变编辑样式
        _tableView.editing = !_tableView.editing;
        _tableView.editing = true;
    }
}
#pragma mark *** getters ***
-(UIView *)whiteView{
    if (!_whiteView) {
        _whiteView = [[UIView alloc] initWithFrame:CGRectMake(45, 0, self.bounds.size.width, self.bounds.size.height)];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(45, 0, self.bounds.size.width-45, self.bounds.size.height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[WCartTableViewCell class] forCellReuseIdentifier:kReusableCartCellIdentifier];
        _tableView.rowHeight = 300*AdaptationWidth();
        _tableView.sectionHeaderHeight = 66*AdaptationWidth();
        _tableView.sectionFooterHeight = 93*AdaptationWidth();
        _tableView.editing = true;

    }
    return _tableView;
}
@end
