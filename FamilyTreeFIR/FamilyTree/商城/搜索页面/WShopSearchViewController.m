//
//  WShopSearchViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/7/25.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "WShopSearchViewController.h"
#import "WTypeBtnView.h"
#import "WSearchGoodModel.h"
#import "WSearchGoodsCell.h"
#import "WFilterView.h"
static NSString *const kReusableSearchcellIdentifier = @"SearchcellIdentifier";

@interface WShopSearchViewController ()<TopSearchViewDelegate,UITableViewDelegate,UITableViewDataSource,WTypeBtnViewDelegate>
{
    BOOL _selectedFilertBtn;
}
@property (nonatomic,strong) TopSearchView *topSearchView; /*顶部搜索*/
@property (nonatomic,strong) ScrollerView *scrollerView; /*滚动图*/
/**搜索结果TableView*/
@property (nonatomic,strong) UITableView *tableView;
/**返回按钮*/
@property (nonatomic,strong) UIButton *leftBtn;
/**筛选btn*/
@property (nonatomic,strong) UIButton *filterBtn;
/**综合价格人气销量*/
@property (nonatomic,strong) WTypeBtnView *btnView;
/**筛选页面*/
@property (nonatomic,strong) WFilterView *filterView;


@end

@implementation WShopSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    [self.view addSubview:self.topSearchView];
    [self.view addSubview:self.btnView];
    [self.view addSubview:self.tableView];
}


#pragma mark *** UITableViewDadaSourceAndDelegate***
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WSearchGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableSearchcellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[WSearchGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kReusableSearchcellIdentifier];
    }
    
    return cell;
}
#pragma mark *** 网络请求 ***
/**
 *  搜索商品
 *
 *  @param name 商品名
 *  @param back 结束搜索
 */
-(void)postGoodsListWithGoodsName:(NSString *)name WhileComplete:(void (^)())back{
    [TCJPHTTPRequestManager POSTWithParameters:@{@"pagenum":@"1",
                                                @"pagesize":@"20",
                                                @"type":@"",
                                                @"label":@"",
                                                @"coname":name,
                                                @"shoptype":@"GEN",
                                                @"qsj":@"",
                                                @"jwj":@"",
                                                @"px":@"ZH",
                                                @"issx":@"1",
                                                } requestID:GetUserId requestcode:kRequestCodegetcomlist success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
                                                    if (succe) {
                                                        NSLog(@"--goods--%@", [NSString jsonDicWithDic:jsonDic[@"data"]]);
                                                    }
                                                } failure:^(NSError *error) {
                                                    
                                                }];
}



#pragma mark *** TopSearchViewDelegate ***

-(void)TopSearchViewDidTapView:(TopSearchView *)topSearchView{
    
    MYLog(@"点击搜索");
//    [self postGoodsListWithGoodsName:self.topSearchView.searchLabel.text WhileComplete:^{
//        
//    }];
    
}
#pragma mark *** WtypeBtnDelegate ***
-(void)typeBtnView:(WTypeBtnView *)btnView didSelectedTitle:(NSString *)title{
    MYLog(@"%@",title);
}
#pragma mark *** Events ***

-(void)respondsToRightBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    MYLog(@"筛选按钮");
    
       if(sender.selected){
         [self.view addSubview:self.filterView];
    }else{
        [self.filterView removeFromSuperview];
    }
}
-(void)respondsToReturnBtn{
    MYLog(@"返回按钮");
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark *** getters ***
-(TopSearchView *)topSearchView{
    if (!_topSearchView) {
        _topSearchView = [[TopSearchView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, StatusBar_Height+NavigationBar_Height)];
        _topSearchView.searchLabel.placeholder = @"输入关键词";
        _topSearchView.delegate = self;
        
        _topSearchView.searchView.frame = CGRectMake(0.05*Screen_width+20, SearchToTop, 0.8*Screen_width-20, SearchView_Height);
        _topSearchView.searchImage.frame = CGRectMake(CGRectGetMaxX(self.topSearchView.searchView.frame)-4*SearchImage_Size, self.topSearchView.searchView.bounds.size.height/2-SearchImage_Size/2, SearchImage_Size, SearchImage_Size);
        [_topSearchView.menuBtn removeAllTargets];
        [_topSearchView.menuBtn removeFromSuperview];
        [_topSearchView addSubview:self.filterBtn];
        [_topSearchView addSubview:self.leftBtn];
    }
    return _topSearchView;
}
-(UIButton *)filterBtn{
    if (!_filterBtn) {
        _filterBtn = [[UIButton alloc]initWithFrame:CGRectMake(630*AdaptationWidth(), 30, 75*AdaptationWidth(), 24)];
        [_filterBtn setTitle:@"筛选" forState:UIControlStateNormal];
        _filterBtn.titleLabel.font = MFont(12);
        [_filterBtn setImage:MImage(@"sel2") forState:UIControlStateNormal];
        [_filterBtn setImage:MImage(@"sel1") forState:UIControlStateSelected];
        _filterBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_filterBtn.imageView.frame.size.width - _filterBtn.frame.size.width + _filterBtn.titleLabel.frame.size.width, 0, 0);
        _filterBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -_filterBtn.titleLabel.frame.size.width - _filterBtn.frame.size.width + _filterBtn.imageView.frame.size.width);

        _filterBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_filterBtn addTarget:self action:@selector(respondsToRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _filterBtn;
}
-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, StatusBar_Height, 44, 44)];
        [_leftBtn setImage:MImage(@"fanhui") forState:0];
        [_leftBtn addTarget:self action:@selector(respondsToReturnBtn) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _leftBtn;
}
-(WTypeBtnView *)btnView{
    if (!_btnView) {
        _btnView = [[WTypeBtnView alloc] initWithFrame:CGRectMake(0, CGRectYH(self.topSearchView), Screen_width, 70*AdaptationWidth())];
        _btnView.delegate = self;
        
    }
    return _btnView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectYH(self.btnView)+4, Screen_width, HeightExceptNaviAndTabbar-self.btnView.bounds.size.height-4)];
        _tableView.rowHeight = 200*AdaptationWidth();
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[WSearchGoodsCell class] forCellReuseIdentifier:kReusableSearchcellIdentifier];

    }
    return _tableView;
}
-(WFilterView *)filterView{
    if (!_filterView) {
        _filterView = [[WFilterView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, HeightExceptNaviAndTabbar)];
    }
    return _filterView;
}
@end
