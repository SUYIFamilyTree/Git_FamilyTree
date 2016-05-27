//
//  TableView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/26.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "TableView.h"
static NSString *const kReusableCellIdentifier = @"cellIdentifier";

@interface TableView()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataSource;
}
@property (nonatomic,strong) UITableView *tableView; /*表格视图*/

@end
@implementation TableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initData];
        
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark *** 初始化数据 ***
-(void)initData{
    _dataSource = @[@"怀宁陈大大",@"安庆呼啸而",@"西安往事",@"开封踩踩踩从",@"举办成功乐乐乐而",@"热卖中弘"];
}
#pragma mark *** 初始化界面 ***
-(void)initUI{
    
}

#pragma mark *** Delegate ***
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kReusableCellIdentifier];
    }
    
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.textLabel.font = MFont(12);
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_delegate tableView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark *** getters ***
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, SelfView_width, SelfView_height-20)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReusableCellIdentifier];
        _tableView.rowHeight = 30;
        _tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
}
@end
