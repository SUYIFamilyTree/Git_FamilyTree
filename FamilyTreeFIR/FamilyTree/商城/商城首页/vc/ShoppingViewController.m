//
//  ShoppingViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/24.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "ShoppingViewController.h"
#import "WShopSearchViewController.h"
#import "GoodsCommentViewController.h"

#import "ShoppingTypeView.h"
#import "HotActiveView.h"
#import "NeedRushView.h"
#import "GuessLikeView.h"
@interface ShoppingViewController ()<TopSearchViewDelegate,ShoppingTypeViewDelegate,HotActiveViewDelegate,NeedRushViewDelegate,GuessLikeViewDelegate>

@property (nonatomic,strong) TopSearchView *topSearchView; /*顶部搜索*/
@property (nonatomic,strong) ScrollerView *scrollerView; /*滚动图*/

/**
 *  商城种类视图
 */
@property (strong,nonatomic) ShoppingTypeView *shoppingTypeV;
/**
 *  热门活动
 */
@property (strong,nonatomic) HotActiveView *hotActiveV;
/**
 *  必抢
 */
@property (strong,nonatomic) NeedRushView *needRushView;
/**
 *  喜欢
 */
@property (strong,nonatomic) GuessLikeView *guessLikeV;

/**购物车*/
@property (nonatomic,strong) UIButton *cartButton;
/**购物车界面*/
@property (nonatomic,strong) WShopCartView *shopCartView;

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = LH_RGBCOLOR(236, 236, 236);
    self.navigationController.navigationBarHidden = YES;
    
    [self postGetSyntypeWhileComplete:^() {
        [self initView];
        [self postGoodsListWithGoodsName:@"" WhileComplete:^{
            
        }];
    }];

}
- (void)initView{
    UIScrollView *backV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight-50)];
    [self.view addSubview:backV];
    backV.backgroundColor = LH_RGBCOLOR(220, 220, 220);
    backV.scrollEnabled = YES;
    
    backV.contentSize = CGSizeMake(__kWidth, __kWidth*3/2+540);
    
    [self.view addSubview:self.topSearchView];
    [backV addSubview:self.scrollerView];
    
    _shoppingTypeV = [[ShoppingTypeView alloc]initWithFrame:CGRectMake(0, CGRectYH(self.scrollerView), __kWidth, __kWidth/4)];
    [backV addSubview:_shoppingTypeV];
    _shoppingTypeV.delegate=self;
    
    UIView *hotV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectYH(_shoppingTypeV)+4, __kWidth, (__kWidth)*11/36+30)];
    [backV addSubview:hotV];
    hotV.backgroundColor = [UIColor whiteColor];
    
    UIImageView *hotIV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 75, 20)];
    [hotV addSubview:hotIV];
    hotIV.contentMode = UIViewContentModeScaleAspectFit;
    hotIV.image = MImage(@"doing");
    
    _hotActiveV = [[HotActiveView alloc]initWithFrame:CGRectMake(0, CGRectYH(hotIV), __kWidth, (__kWidth)*11/36)];
    [hotV addSubview:_hotActiveV];
    _hotActiveV.delegate = self;
    
    _needRushView = [[NeedRushView alloc]initWithFrame:CGRectMake(0, CGRectYH(hotV)+4, __kWidth, __kWidth*13/36+40)];
    [backV addSubview:_needRushView];
    _needRushView.delegate = self;
    
    _guessLikeV = [[GuessLikeView alloc]initWithFrame:CGRectMake(0, CGRectYH(_needRushView)+4, __kWidth, __kWidth*5/9+190)];
    [backV addSubview:_guessLikeV];
    _guessLikeV.delegate = self;
    
    //购物车btn
    [self.view addSubview:self.cartButton];

    
}

#pragma mark -GuessLikeViewDelegate
- (void)selectCellLike:(NSIndexPath *)index{
    NSLog(@"跳转到猜你喜欢商品%ld详情页",index.row);
}

#pragma mark -NeedRushView Delegate
-(void)selectCellRush:(NSIndexPath *)index{
    NSLog(@"跳转到商品%ld详情页",index.row);
}

#pragma mark -HotActiveViewDelegate
-(void)selectCellIndexPath:(NSIndexPath *)index{
    NSLog(@"跳转到热门商品详情页%ld",index.row);
}


#pragma mark -ShoppingTypeView Delegate
-(void)pushView:(NSInteger)sender{
    switch (sender) {
        case 0:
        {
            NSLog(@"实物物品");
        }
            break;
        case 1:
        {
            NSLog(@"虚拟物品");
        }
            break;
        case 2:
        {
            NSLog(@"同城热卖");
        }
            break;
        case 3:
        {
            NSLog(@"优惠专区");
        }
            break;
        default:
            break;
    }
}

#pragma mark *** TopSearchViewDelegate ***

-(void)TopSearchViewDidTapView:(TopSearchView *)topSearchView{
    MYLog(@"商城搜索栏");
    WShopSearchViewController *searchVc = [[WShopSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];
}
-(void)TopSearchView:(TopSearchView *)topSearchView didRespondsToMenusBtn:(UIButton *)sender{
    MYLog(@"商城右菜单");
    GoodsCommentViewController *pingjia = [[GoodsCommentViewController alloc] init];
    [self.navigationController pushViewController:pingjia animated:YES];
    
}

#pragma mark *** 网络请求 ***
-(void)postGetSyntypeWhileComplete:(void (^)())back{
    [TCJPHTTPRequestManager POSTWithParameters:@{@"typeval":@"SPFL"} requestID:GetUserId requestcode:kRequestCodeGetsyntype success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSLog(@"--%@",[NSString jsonArrWithArr:jsonDic[@"data"]]);
            
            NSArray *arr = [NSString jsonArrWithArr:jsonDic[@"data"]];
            NSMutableDictionary *alldic = [NSMutableDictionary dictionary];
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dic = arr[idx];
                [alldic setObject:dic[@"syntypeval"] forKey:dic[@"syntype"]];
            }];
            [WShopCommonModel shareWShopCommonModel].typeIdDic = alldic;
            back();
        }
    } failure:^(NSError *error) {
        
    }];
}
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
                                                         back();
                                                     }
                                                 } failure:^(NSError *error) {
                                                     
                                                 }];
}
#pragma mark *** btnEvents ***
-(void)respondsToCartBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.view addSubview:self.shopCartView];
    }
}
#pragma mark *** getters ***
-(TopSearchView *)topSearchView{
    if (!_topSearchView) {
        _topSearchView = [[TopSearchView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, StatusBar_Height+NavigationBar_Height)];
        _topSearchView.searchLabel.placeholder = @"输入关键词";
        _topSearchView.delegate = self;
        
    }
    return _topSearchView;
}
-(ScrollerView *)scrollerView{
    if (!_scrollerView) {
        _scrollerView = [[ScrollerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topSearchView.frame), Screen_width, 210) images:nil];
        
    }
    return _scrollerView;
}
-(UIButton *)cartButton{
    if (!_cartButton) {
        _cartButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)-45, 350, 45, 30)];
        [_cartButton setImage:MImage(@"car") forState:0];
        [_cartButton addTarget:self action:@selector(respondsToCartBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cartButton;
}
-(WShopCartView *)shopCartView{
    if (!_shopCartView) {
        _shopCartView = [[WShopCartView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, HeightExceptNaviAndTabbar)];
        
    }
    return _shopCartView;
}

@end
