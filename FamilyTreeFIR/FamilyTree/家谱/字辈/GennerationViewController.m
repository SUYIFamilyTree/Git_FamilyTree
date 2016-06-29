//
//  GennerationViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/8.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "GennerationViewController.h"
#import "GennerTableViewCell.h"
static NSString *const kGennerCellIdentifier = @"GennercellIdentifier";

@interface GennerationViewController ()<TopSearchViewDelegate,UITableViewDelegate,UITableViewDataSource>

{
    NSMutableArray *_allInfoArr;
    NSMutableArray *_detailInfo;
    NSMutableArray *_genNameArr;
}


@property (nonatomic,strong) TopBackSearch *topView; /*头部搜索带返回键*/
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) WGennerationModel *gennerModel; /*字辈model*/


@end

@implementation GennerationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
    [self PostGennerInfomation];

    
}
#pragma mark *** 初始化数据 ***
-(void)initData{
    _allInfoArr = [@[@[@"杨未一",@"杨未二"],@[@"杨琚一",@"杨琚二",@"杨琚三"],@[@"杨新军",@"杨春华",@"杨春梅"],@[@"杨新军",@"杨春华",@"杨春梅"]] mutableCopy];
    
    _detailInfo = [@[@[@[@"屠夫",@"位置",@"杨拘役"],@[@"屠夫",@"侍郎",@"屠夫"]],
                    @[@[@"宰相",@"杨未一",@"未知"],@[@"侍郎",@"杨未一",@"未知"],@[@"屠夫",@"杨伟二",@"未知"]],
                    @[@[@"中侍郎",@"扬剧二",@"未知"],@[@"屠夫",@"杨军三",@"未知"],@[@"屠夫",@"杨伟三",@"未知"]],
                    @[@[@"中侍郎",@"扬剧二",@"未知"],@[@"屠夫",@"杨军三",@"未知"],@[@"屠夫",@"杨伟三",@"未知"]]]mutableCopy];
    _genNameArr = [@[@"未",@"琚吴",@"新弦春品",@"??"]mutableCopy];
}
#pragma mark *** 初始化界面 ***
-(void)initUI{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark *** 网络请求字辈列表 ***

-(void)PostGennerInfomation{
    [TCJPHTTPRequestManager POSTWithParameters:@{@"geid":@"1",@"query":@"",@"pagenum":@"1",@"pagesize":@"20"} requestID:GetUserId requestcode:kRequestCodequeryzbgemelist success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
//            NSLog(@"--22-%@", jsonDic[@"data"]);
//            NSLog(@"--11-%@", [NSString jsonDicWithDic:jsonDic[@"data"]]);
            WK(weakSelf)
            weakSelf.gennerModel = [WGennerationModel modelWithJSON:jsonDic[@"data"]];
            
            NSLog(@"0-0--%@", self.gennerModel);
            
            NSLog(@"1-1--%@", self.gennerModel.datalist[0].datas[0].name);
            [_genNameArr removeAllObjects];
            [_allInfoArr removeAllObjects];
            [_detailInfo removeAllObjects];
            //更新所有数据源取model里面的数据
            for (int idx = 0; idx<self.gennerModel.datalist.count; idx++) {
                [_genNameArr addObject:self.gennerModel.datalist[idx].zb];
                NSMutableArray *nameArr = [@[] mutableCopy];
                for (int ij = 0; ij<self.gennerModel.datalist[idx].datas.count; ij++) {
                    [nameArr addObject:self.gennerModel.datalist[idx].datas[ij].name];
                }
                [_allInfoArr addObject:nameArr];
                
            }
            
            
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark *** events ***

-(void)respondsToTopSearchView:(UIButton *)sender{
    MYLog(@"返回");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark *** tableViewDataSource,Delegate ***

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.gennerModel.datalist) {
        return self.gennerModel.datalist.count;
    }
    return _allInfoArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GennerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kGennerCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[GennerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kGennerCellIdentifier];
    }
    [CALayer drawTopBorder:cell];
    [CALayer drawBottomBorder:cell];
    
    cell.nameArr = _allInfoArr[indexPath.row];
//    cell.idArr = _detailInfo[indexPath.row];
    [cell initPorInfo];
    cell.generNumber.text = [NSString stringWithFormat:@"第%ld代",indexPath.row+1];
    cell.personNumber.text = [NSString stringWithFormat:@"%ld人",((NSArray *)_allInfoArr[indexPath.row]).count];
    
    cell.perName.text =  [NSString verticalStringWith:_genNameArr[indexPath.row]];
        
    
    return cell;
}
#pragma mark *** TopDelegate ***

-(void)TopSearchViewDidTapView:(TopSearchView *)topSearchView{
    MYLog(@"查询字辈");
}

-(void)TopSearchView:(TopSearchView *)topSearchView didRespondsToMenusBtn:(UIButton *)sender{
    MYLog(@"右菜单");
}
#pragma mark *** getters ***
-(TopBackSearch *)topView{
    if (!_topView) {
        
        _topView = [[TopBackSearch alloc] initWithFrame:CGRectMake(0, 0, Screen_width, StatusBar_Height+NavigationBar_Height)];
        _topView.delegate = self;
        [_topView.backBtn addTarget:self action:@selector(respondsToTopSearchView:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _topView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height-64-self.tabBarController.tabBar.bounds.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[GennerTableViewCell class] forCellReuseIdentifier:kGennerCellIdentifier];
        _tableView.rowHeight = 334*AdaptationWidth();
        _tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
}

@end




