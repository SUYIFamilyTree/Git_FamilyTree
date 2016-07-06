//
//  CemeteryViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/13.
//  Copyright © 2016年 王子豪. All rights reserved.
//

enum {
    BTNIntroTag,
    BTNJishiTag,
    BTNMianhuaiTag
};

#import "CemeteryViewController.h"
#import "CemDetailView.h"
#import "CemIntroViewController.h"
#import "CemGoodsShopView.h"
#import "InputCherishView.h"
#import "CemeteryModel.h"
#import "BarrageListModel.h"
#import "FlyBarrageTextView.h"

#define bacheight (Screen_height-self.tabBarController.tabBar.bounds.size.height-64)
@interface CemeteryViewController ()<InputCherishViewDelegate,UITextViewDelegate>
{
    BOOL _selectedMianhuaiBtn;
}
@property (nonatomic,strong) UIScrollView *scrollView; /*背景滚动图*/

@property (nonatomic,strong) UIImageView *cemImageView; /*背景图*/

@property (nonatomic,strong) CemDetailView *detailView; /*详细墓碑内容*/

@property (nonatomic,strong) CemGoodsShopView *goodsView; /*祭祀商品*/

@property (nonatomic,copy) NSMutableArray *goodsImagesArr; /*买的祭祀商品数组*/

@property (nonatomic,strong) InputCherishView *inputView; /*输入缅怀语*/


/** 墓园详情模型*/
@property (nonatomic, strong) CemeteryModel *cemeteryModel;
/** 墓园弹幕模型(包括祭品)*/
@property (nonatomic, strong) BarrageListModel *barrageListModel;
/** 弹幕数组*/
@property (nonatomic, strong) NSMutableArray *barragesArr;
/** 弹幕颜色数组*/
@property (nonatomic, strong) NSArray *colorArray;
@end

@implementation CemeteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
    [self getCemeteryData];
    [self getCemeteryBarrageList];
    [self getCemeteryJSData];
}

-(void)getCemeteryData{
    NSDictionary *logDic = @{@"CeId":@(self.CeId)};
    WK(weakSelf)
    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:GetUserId requestcode:kRequestCodeCemeterDetail success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            weakSelf.cemeteryModel = [CemeteryModel modelWithJSON:jsonDic[@"data"]];
            weakSelf.detailView.cemeteryModel = weakSelf.cemeteryModel;
            
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)getCemeteryBarrageList{
    NSDictionary *logDic = @{@"CeId":@(self.CeId)};
    WK(weakSelf);
    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:GetUserId requestcode:kRequestCodeBarrageList success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        //MYLog(@"%@",jsonDic[@"data"]);
        if (succe) {
            weakSelf.barrageListModel = [BarrageListModel modelWithJSON:jsonDic[@"data"]];
            for (int i = 0; i < weakSelf.barrageListModel.dm.count; i++) {
                [weakSelf.barragesArr addObject:weakSelf.barrageListModel.dm[i].BaContent];
            }
            [weakSelf makeBarrageListAnimation:weakSelf.barragesArr];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)getCemeteryJSData{
    NSDictionary *logDic = @{
                             @"pagenum":@1,
                             @"pagesize":@1999,
                             @"type":@"",
                             @"label":@"",
                             @"coname":@"",
                             @"qsj":@"",
                             @"jwj":@"",
                             @"shoptype":@"JS"
                             };
    //WK(weakSelf);
    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:GetUserId requestcode:@"getcomlist" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        MYLog(@"数据%@",jsonDic[@"data"]);
        if (succe) {
            
        }
    } failure:^(NSError *error) {
        
    }];

}

//弹幕动画效果
-(void)makeBarrageListAnimation:(NSMutableArray *)barragesArray{
    self.colorArray = @[[UIColor redColor],[UIColor blackColor],[UIColor greenColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor purpleColor],[UIColor magentaColor],[UIColor brownColor]];
    for(int i = 0 ; i < barragesArray.count; i++){
        float   tempNum     = 64 +arc4random()%200;//高
        int     tempI       = arc4random()%barragesArray.count;
        int     sleepTime   = arc4random()%8;
        int     colorNum    = arc4random()%8;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(sleepTime);
            dispatch_async(dispatch_get_main_queue(), ^{
                FlyBarrageTextView * flyView = [[FlyBarrageTextView alloc] initWithY:tempNum AndText:barragesArray[tempI] AndWordSize:12];
                flyView.textColor = self.colorArray[colorNum];
                [self.view addSubview:flyView];
            });
        });
    }
}
//单条弹幕加入滚动
-(void)makeOneBarrageAnimation:(NSString *)str{
    float   tempNum     = 64 +arc4random()%200;
    int     colorNum    = arc4random()%8;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            FlyBarrageTextView * flyView = [[FlyBarrageTextView alloc] initWithY:tempNum AndText:str AndWordSize:12];
            flyView.textColor = self.colorArray[colorNum];
            [self.view addSubview:flyView];
        });
    });

}

#pragma mark *** 初始化数据 ***
-(void)initData{
    
}
#pragma mark *** 初始化界面 ***
-(void)initUI{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.cemImageView];
    [self initXiangLu];
    [self.scrollView addSubview:self.detailView];
    [self allGoodsdisplay];
    [self initRightBtn];
    
    
    
    
}
//香炉
-(void)initXiangLu{
    
    for (int idx = 0; idx<2; idx++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:AdaptationFrame((0.7*bacheight-Screen_width/2)/AdaptationWidth()+50+idx*(350+140), 520, 126, 226)];
        image.image = MImage(@"my_name_xiangLu");
        
        [self.scrollView addSubview:image];
    }
    
}

//所有买了的贡品
-(void)allGoodsdisplay{
    for (int idx = 0; idx<self.goodsImagesArr.count; idx++) {
        UIImageView *godsIma = [[UIImageView alloc] initWithFrame:AdaptationFrame(idx*105, 740, 105, 80)];
        godsIma.image = MImage(self.goodsImagesArr[idx]);
        [self.scrollView addSubview:godsIma];
    }
    
}


//三个btn
-(void)initRightBtn{
    NSArray *imageArr = @[@"my_name_nav_1",@"my_name_nav_2",@"my_name_nav_3"];
    for (int idx = 0; idx<3; idx++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:AdaptationFrame(Screen_width/AdaptationWidth()-130, 750+idx*130, 114, 114)];
        [btn setImage:MImage(imageArr[idx]) forState:0];
        btn.tag = idx;
        [btn addTarget:self action:@selector(respondsToCemBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}


#pragma mark *** btnEvents ***

-(void)respondsToCemBtn:(UIButton *)sender{
    switch (sender.tag) {
        case BTNIntroTag:
        {
            CemIntroViewController *cemIntro = [[CemIntroViewController alloc] initWithTitle:@"墓园介绍" image:nil];
            cemIntro.cemeteryModel = self.cemeteryModel;
            [self.navigationController pushViewController:cemIntro animated:YES];
        }
            break;
        case BTNJishiTag:
        {
            [self.view addSubview:self.goodsView];
        }
            break;
        case BTNMianhuaiTag:
        {
            _selectedMianhuaiBtn = !_selectedMianhuaiBtn;
            [self.scrollView addSubview:self.inputView];

            if (_selectedMianhuaiBtn) {
                self.inputView.hidden = false;
            }else{
                self.inputView.hidden = true;
            }
        }
            break;
        default:
            break;
    }
}


#pragma mark *** getters ***
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, bacheight)];
        _scrollView.contentSize = CGSizeMake(1.4*bacheight, bacheight);
        _scrollView.bounces = false;
        _scrollView.contentOffset = CGPointMake(0.7*bacheight-Screen_width/2, 0);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
        [_scrollView addGestureRecognizer:tap];
    }
    return _scrollView;
}

-(UIImageView *)cemImageView{
    if (!_cemImageView) {
        _cemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height)];
        _cemImageView.image = MImage(@"my_name_bg.png");
        _cemImageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _cemImageView;
}

-(CemDetailView *)detailView{
    if (!_detailView) {
        _detailView = [[CemDetailView alloc] initWithFrame:AdaptationFrame((0.7*bacheight-Screen_width/2)/AdaptationWidth()+243, 64/AdaptationWidth()+120, 240, 470)];
    }
    return _detailView;
}
-(CemGoodsShopView *)goodsView{
    if (!_goodsView) {
        _goodsView = [[CemGoodsShopView alloc] initWithFrame:CGRectMake(0, 64, Screen_width,Screen_height-64-self.tabBarController.tabBar.bounds.size.height)];
        
    }
    return _goodsView;
}
-(InputCherishView *)inputView{
    if (!_inputView) {
        _inputView = [[InputCherishView alloc] initWithFrame:AdaptationFrame(540, 800, 375, 162)];
        _inputView.textView.delegate = self;
        _inputView.delegate = self;
    }
    return _inputView;
}

-(NSMutableArray *)goodsImagesArr{
    if (!_goodsImagesArr) {
        _goodsImagesArr = [@[@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour"] mutableCopy];
        
    }
    return _goodsImagesArr;
}

-(NSMutableArray *)barragesArr{
    if (!_barragesArr) {
        _barragesArr = [@[] mutableCopy];
    }
    return _barragesArr;
}


#pragma mark - InputCherishViewDelegate
-(void)inputCherishView:(InputCherishView *)inputCherishView withString:(NSString *)str{
    //上传弹幕
    MYLog(@"%@",str);
    NSDictionary *logDic = @{
                             @"BaCeid":@(self.CeId),
                             @"BaMeid":GetUserId,
                             @"BaContent":str
                             };
    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:GetUserId requestcode:kRequestCodeCreateBarrage success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        MYLog(@"%@",jsonDic[@"data"]);
    } failure:^(NSError *error) {
        
    }];
    
    [self makeOneBarrageAnimation:str];
    
}

#pragma mark - UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    MYLog(@"将要开始编辑");
    if (self.scrollView.frame.origin.y == 64) {
        [UIView animateWithDuration:1 animations:^{
            CGRect frame =  self.scrollView.frame;
            frame.origin.y = 64-216+20;
            self.scrollView.frame = frame;
        }];
    }
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    MYLog(@"结束编辑");
    if (self.scrollView.frame.origin.y !=64) {
        [UIView animateWithDuration:1 animations:^{
            CGRect frame =  self.scrollView.frame;
            frame.origin.y = 64;
            self.scrollView.frame = frame;
        }];
    }
}

-(void)closeKeyboard{
    [self.view endEditing:YES];
}


@end
