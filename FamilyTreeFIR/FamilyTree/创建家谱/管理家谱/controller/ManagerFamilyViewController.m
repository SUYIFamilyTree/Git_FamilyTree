//
//  ManagerFamilyViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/15.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "ManagerFamilyViewController.h"
#import "WRollDetailView.h"
#import "WSwitchDetailFamView.h"
#import "WAddJPPersonView.h"
@interface ManagerFamilyViewController ()<WswichDetailFamViewDelegate,WAddJPPersonViewDelegate>
{
    BOOL _selectedRollView;//是否选择了某个卷谱
//    BOOL _selectedSwithBtn;
    NSMutableArray *_titleArr;//卷谱名array
    
    NSMutableDictionary *_addJPDic;/** 添加卷谱信息里面的，名字--成员id 键值对 */
    
    /** 有多少种卷谱1-5为一种，5-9为一种，9-13为一种 */
    NSMutableArray *_JPTypeArr;
    /** 每种卷 */
}
@property (nonatomic,strong) UIScrollView *backScrollView; /*背景滚动图*/

@property (nonatomic,strong) UIImageView *famImage; /*家谱名字图腾*/
@property (nonatomic,strong) UILabel *famName; /*家谱名*/


@property (nonatomic,strong) UIButton *switchFam; /*切换家谱*/

@property (nonatomic,strong) WRollDetailView *detailView; /*具体人数等*/

@property (nonatomic,strong) WSwitchDetailFamView *switchDetailView; /*点击切换家谱之后的显示*/

@property (nonatomic,strong) CreateFamModel *famModel; /*家谱信息model*/




/**添加卷谱按钮*/
@property (nonatomic,strong) UIButton *addJPBtn;



@end

@implementation ManagerFamilyViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initData];
    [self initUI];
    
    
    
//    //进去请求当前id的家谱
//    [SXLoadingView showProgressHUD:@"正在加载家谱..." duration:0.5];
//    [self posGetDetailFamInfoWithID:[WFamilyModel shareWFamilModel].myFamilyId callBack:^(id respondsDic) {
//  
//        WK(weakSelf)
//        //将点击家谱名，获取到id，再根据id获取到的家谱详情传到famModel里
//        weakSelf.famModel = [CreateFamModel modelWithJSON:respondsDic[@"data"]];
//        
//        NSLog(@"???%@", respondsDic[@"data"]);
//        
//        [self reloadUI];
//        
//        [SXLoadingView hideProgressHUD];
//        
//    }];
    
    [self getAllFamJPCallBackJPDetailArray:^(NSArray<NSDictionary *> *JPArray) {
        NSLog(@"卷谱LIST%@", JPArray);
        
        NSArray *textArr = @[@"111",@"22",@"22",@"22",@"22",@"22",@"33",@"33",@"33",@"44",@"55",@"66",@"77",@"88",@"88"];
        
//        [_JPTypeArr removeAllObjects];
        
        NSMutableArray *JpTypeGenArr = [@[] mutableCopy];

//        for (int idx = 1; idx<textArr.count; idx++) {
//           
//            if ([textArr[idx-1] isEqualToString:textArr[idx]] ) {
//                [JpTypeGenArr addObject:textArr[idx-1]];
//                
//                if (idx==textArr.count-1) {
//                    [JpTypeGenArr addObject:textArr[idx]];
//                    NSArray *arr = [NSArray arrayWithArray:JpTypeGenArr];
//                    
//                    [_JPTypeArr addObject:arr];
//                }
//                
//            }else{
//                [JpTypeGenArr addObject:textArr[idx-1]];
//                
//                NSArray *arr = [NSArray arrayWithArray:JpTypeGenArr];
//                
//                [_JPTypeArr addObject:arr];
//                
//                [JpTypeGenArr removeAllObjects];
//                
//                if (idx==textArr.count-1) {
//                    [JpTypeGenArr addObject:textArr[idx]];
//                    NSArray *arr = [NSArray arrayWithArray:JpTypeGenArr];
//                    
//                    [_JPTypeArr addObject:arr];
//                }
//                
//            }
//        }
        
        for (int idx = 1; idx<JPArray.count; idx++) {
            
            if ([[NSString stringWithFormat:@"%@",JPArray[idx][@"maxlevel"]]
                 isEqualToString:
                 [NSString stringWithFormat:@"%@",JPArray[idx-1][@"maxlevel"]]] ) {
                
                [JpTypeGenArr addObject:JPArray[idx-1]];
                
                if (idx==JPArray.count-1) {
                    [JpTypeGenArr addObject:JPArray[idx]];
                    NSArray *arr = [NSArray arrayWithArray:JpTypeGenArr];
                    
                    [_JPTypeArr addObject:arr];
                }
                
            }else{
                [JpTypeGenArr addObject:JPArray[idx-1]];
                
                NSArray *arr = [NSArray arrayWithArray:JpTypeGenArr];
                
                [_JPTypeArr addObject:arr];
                
                [JpTypeGenArr removeAllObjects];
                
                if (idx==JPArray.count-1) {
                    [JpTypeGenArr addObject:JPArray[idx]];
                    NSArray *arr = [NSArray arrayWithArray:JpTypeGenArr];
                    
                    [_JPTypeArr addObject:arr];
                }
                
            }
        }
//        for (int idx = 1; idx<JPArray.count; idx++) {
//            if (1) {
//              
//                if ([[NSString stringWithFormat:@"%@",JPArray[idx][@"maxlevel"]]
//                     isEqualToString:
//                     [NSString stringWithFormat:@"%@",JPArray[idx-1][@"maxlevel"]]]) {
//
//                    NSLog(@"相同");
//                    
//                    [JpTypeGenArr addObject:JPArray[idx-1]];
//                    
//                    
//                }else{
//                    [JpTypeGenArr addObject:JPArray[idx-1]];
//                    [_JPTypeArr addObject:JpTypeGenArr];
//                    
//                    [JpTypeGenArr removeAllObjects];
//                }
//                
//            }
//            
//            
//        }
        NSLog(@"看看----%@", _JPTypeArr);
       
            
       
        
        
        
    }];

    
}

#pragma mark *** 初始化数据 ***
-(void)initData{
    _titleArr = [@[@"段正淳1|5代卷谱",@"段志兴6|9代卷谱",@"段志兴6 | 9代卷谱",@"段志兴10|15代卷谱",@"段志兴10|15代卷谱",@"段志兴10|15代卷谱"] mutableCopy];
    _addJPDic = [NSMutableDictionary dictionary];
    _JPTypeArr = [@[] mutableCopy];
}
#pragma mark *** 初始化界面 ***
-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.backScrollView];
    [self.view addSubview:self.switchFam];
    [self initAllRollView];
    [self.backScrollView addSubview:self.famImage];
    
    [self.view bringSubviewToFront:self.switchFam];
}
//初始化所有家眷
-(void)initAllRollView{
    
    NSArray *frameArrY = @[[NSNumber numberWithFloat:(383)],
                          [NSNumber numberWithFloat:(380)],
                          [NSNumber numberWithFloat:(565)],
                          [NSNumber numberWithFloat:(381)],
                          [NSNumber numberWithFloat:(190)],
                          [NSNumber numberWithFloat:(0)]];
    
    NSArray *frameArrX = @[[NSValue valueWithCGPoint:CGPointMake(383, 30)],
                           [NSValue valueWithCGPoint:CGPointMake(380, 438)],
                           [NSValue valueWithCGPoint:CGPointMake(565, 438)],
                           [NSValue valueWithCGPoint:CGPointMake(381, 851)],
                           [NSValue valueWithCGPoint:CGPointMake(190, 851)],
                           [NSValue valueWithCGPoint:CGPointMake(0, 851)]];
    
    
    
    for (int idx = 0; idx<_titleArr.count; idx++) {
        CGPoint potRect = [frameArrX[idx] CGPointValue];
        
        RollView *rollView = [[RollView alloc] initWithFrame:AdaptationFrame(ZeroContentOffset+potRect.x, potRect.y, 131, 358) withTitle:_titleArr[idx] rollType:idx>1?RollViewTypeDecade:RollViewTypeUnitsDigit];
        rollView.tag = idx;
        //添加手势
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondsToRooTapGes:)];
        
        [rollView addGestureRecognizer:tapGes];
        
        [self.backScrollView addSubview:rollView];
        
    }
    
}

#pragma mark *** 更新UI ***
-(void)reloadUI{
    
    [self.backScrollView removeAllSubviews];
    
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _backScrollView.contentSize.width, _backScrollView.contentSize.height)];
    
    backView.image = MImage(@"gljp_bg");
    [self.backScrollView addSubview:backView];
    [self.backScrollView addSubview:self.famImage];
    
    _famName.text = [NSString verticalStringWith:self.famModel.data.GeName];
    
    [_titleArr removeAllObjects];
    [_titleArr addObject:self.famModel.data.GeJpname];
    
    [self initAllRollView];
    
}

#pragma mark *** events ***
//每个视图的手势事件
-(void)respondsToRooTapGes:(UITapGestureRecognizer *)gesture{
 
    _selectedRollView = !_selectedRollView;
    if (_selectedRollView) {
        
        WRollDetailView * detailView = [[WRollDetailView alloc] initWithFrame:AdaptationFrame(CGRectGetMinX(gesture.view.frame)/AdaptationWidth()-271, gesture.view.frame.origin.y/AdaptationWidth(), 271, 355)];
        self.detailView = detailView;
        [self.backScrollView addSubview:self.detailView];
        
        [self getZBInfowhileComplete:^{
            [detailView updateUI];
        }];
        
    }else{
       [self.detailView removeFromSuperview];
    }

}
//切换家谱事件
-(void)respondsToSwitchFam:(UIButton *)sender{
    
        [self.view addSubview:self.switchDetailView];
        [self.view bringSubviewToFront:self.switchDetailView];
        self.switchFam.hidden = YES;
    
    
}
/** 点击添加按钮出现人名 */
-(void)respondsToAddJpBtn:(UIButton *)sender{
    
    NSArray <WJPInfoDatas *>*arr = [WDetailJPInfoModel sharedWDetailJPInfoModel].datalist[4].datas;
    
    NSMutableArray *fatherArr = [@[] mutableCopy];
    [_addJPDic removeAllObjects];
    for (int idx = 0; idx<arr.count; idx++) {
        
        [fatherArr addObject:arr[idx].name];
        
        [_addJPDic setObject:@(arr[idx].gemeid) forKey:arr[idx].name];
        
    }

    WAddJPPersonView *addPer = [[WAddJPPersonView alloc] initWithFrame:AdaptationFrame(sender.frame.origin.x/AdaptationWidth()-162, sender.frame.origin.y/AdaptationWidth()+5, 162, 211) forPersonArr:fatherArr];
    addPer.userInteractionEnabled = true;
    addPer.delegate = self;
    [self.view addSubview:addPer];
    
}

#pragma mark *** WAddJPPersonViewDelegate ***
//添加卷谱
-(void)WAddJPPersonViewDelegate:(WAddJPPersonView *)addView didSelectedBtn:(UIButton *)sender{
    NSLog(@"%@", sender.titleLabel.text);
    NSString *clickName = sender.titleLabel.text;
    
    [TCJPHTTPRequestManager POSTWithParameters:@{@"GeId":[WFamilyModel shareWFamilModel].myFamilyId,@"GemeId":_addJPDic[clickName],@"IsJp":@"1"} requestID:GetUserId requestcode:kRequestCodechangejp success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSLog(@"???----%@", jsonDic[@"data"]);
        }
    } failure:^(NSError *error) {
        
    }];
   
    
}
#pragma mark *** WswithDelegate ***

-(void)WswichDetailFamViewDelegate:(WSwitchDetailFamView *)detaiView didSelectedButton:(UIButton *)sender repeatNameIndex:(NSInteger)repeatIndex{
    
    NSString *searchTitle = sender.titleLabel.text;
    
    if ([searchTitle isEqualToString:@"切换家谱"]) {
        [_switchDetailView removeFromSuperview];
        self.switchFam.hidden = false;
    }else if ([searchTitle isEqualToString:@"创建家谱"]){
        CreateFamViewController *crefa = [[CreateFamViewController alloc] initWithTitle:@"创建家谱" image:nil];
        [self.navigationController pushViewController:crefa animated:YES];
    }else if ([searchTitle isEqualToString:@"新增卷谱"]){
        
        //获取全部卷谱
        [self getAllFamJPCallBackJPDetailArray:^(NSArray<NSDictionary *> *JPArray) {
            [self getAddJPPerWithJPId:JPArray[0][@"genmeid"] whileComplet:^{
                [self.view addSubview:self.addJPBtn];
            }];
        }];
        
    }else if ([searchTitle isEqualToString:@"删除卷谱"]){
        
    }
    else{
        //网络请求家谱详情
        [SXLoadingView showProgressHUD:@"正在加载"];
        [self postGetFamInfoWithtitle:searchTitle callBack:^(NSArray *genIDArr) {
            
            [self posGetDetailFamInfoWithID:genIDArr[repeatIndex] callBack:^(id respondsDic) {
                //设置当前家谱id
                [WFamilyModel shareWFamilModel].myFamilyId = genIDArr[repeatIndex];
                
                WK(weakSelf)
                //将点击家谱名，获取到id，再根据id获取到的家谱详情传到famModel里
                 weakSelf.famModel = [CreateFamModel modelWithJSON:respondsDic[@"data"]];
                
                NSLog(@"管理卷谱点击按钮的详情---%@", respondsDic[@"data"]);
                
                [self reloadUI];
                
                [SXLoadingView hideProgressHUD];
                
                
                
            }];
            
        }];
        
    }
    
    
}

#pragma mark *** 请求家谱信息 ***
/** 根据点击名字获取id，（如果有多个，取点击的第某个）将第一个此家谱名的id */
-(void)postGetFamInfoWithtitle:(NSString *)title callBack:(void (^)(NSArray *genIDArr))callback{
    //网络请求家谱详情
    [TCJPHTTPRequestManager POSTWithParameters:@{@"query":title,@"type":@"MyGen"} requestID:GetUserId requestcode:kRequestCodequerymygen success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSMutableArray *idArr = [@[] mutableCopy];
            for (NSDictionary *dic in [NSString jsonArrWithArr:jsonDic[@"data"]]) {
                
                [idArr addObject:dic[@"Geid"]];
                
            }
            callback(idArr);
        }else{
            [SXLoadingView showAlertHUD:@"???" duration:0.5];
        }
    } failure:^(NSError *error) {
        
    }];
}
/** 请求家谱id */
-(void)posGetDetailFamInfoWithID:(NSString *)genId callBack:(void (^)(id respondsDic))callBack{
    [TCJPHTTPRequestManager POSTWithParameters:@{@"geid":genId} requestID:GetUserId requestcode:kRequestCodeQuerygendata success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            callBack(jsonDic);
        }
    } failure:^(NSError *error) {
        
    }];
}

/** 获取卷谱列表 */
-(void)getAllFamJPCallBackJPDetailArray:(void (^)(NSArray <NSDictionary *>*JPArray))callBack{
    [TCJPHTTPRequestManager POSTWithParameters:@{@"genid":[WFamilyModel shareWFamilModel].myFamilyId} requestID:GetUserId requestcode:kRequestCodequeryjplist success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *sda = [NSString jsonArrWithArr:jsonDic[@"data"]];
            NSLog(@"%@", jsonDic[@"data"]);
            NSLog(@"卷谱列表----%@", sda);
            
            callBack(sda);
        }
    } failure:^(NSError *error) {
        MYLog(@"失败");
    }];
}


/** 查询卷谱的字辈信息 */

-(void)getZBInfowhileComplete:(void(^)())back{
    [self getAllFamJPCallBackJPDetailArray:^(NSArray<NSDictionary *> *JPArray) {
        [self getJPPersonNumWithJPId:JPArray[0][@"genmeid"] complete:^{
            back();
        }];
    }];
    
}

/** 根据卷谱id查询可添加的人 */
-(void)getAddJPPerWithJPId:(NSString *)jpId whileComplet:(void (^)())back{
    [TCJPHTTPRequestManager POSTWithParameters:@{@"gemeid":jpId,
                                                 @"geid":[WFamilyModel shareWFamilModel].myFamilyId,
                                                 @"sex":@""} requestID:GetUserId requestcode:kRequestCodequeryzbgemedetaillist success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSLog(@"---%@", [NSString jsonDicWithDic:jsonDic[@"data"]]);
            WDetailJPInfoModel *detailJP = [WDetailJPInfoModel modelWithJSON:jsonDic[@"data"]];
            [WDetailJPInfoModel sharedWDetailJPInfoModel].datalist = detailJP.datalist;
            back();
                        
        }
    } failure:^(NSError *error) {
  
    }];
}
/** 根据卷谱查询卷谱总人数以及各字辈人数 */

-(void)getJPPersonNumWithJPId:(NSString *)jpId complete:(void (^)())callback{
    [TCJPHTTPRequestManager POSTWithParameters:@{@"gemeid":jpId,@"geid":[WFamilyModel shareWFamilModel].myFamilyId} requestID:GetUserId requestcode:kRequestCodequerygezblist success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSLog(@"%@", jsonDic[@"data"]);
            WJPPersonZBNumberModel *theModel = [WJPPersonZBNumberModel modelWithJSON:jsonDic[@"data"]];
            [WJPPersonZBNumberModel sharedWJPPersonZBNumberModel].allcnt = theModel.allcnt;
            [WJPPersonZBNumberModel sharedWJPPersonZBNumberModel].datalist = theModel.datalist;
            callback();
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark *** getters ***
-(UIScrollView *)backScrollView{
    if (!_backScrollView) {
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, HeightExceptNaviAndTabbar)];
        _backScrollView.contentSize = AdaptationSize(1040, 1500);
        _backScrollView.contentOffset = AdaptationCenter(ZeroContentOffset, 0);
        _backScrollView.bounces = false;
        UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _backScrollView.contentSize.width, _backScrollView.contentSize.height)];
        backView.image = MImage(@"gljp_bg");
        [_backScrollView addSubview:backView];
        
    }
    return _backScrollView;
}

-(UIImageView *)famImage{
    if (!_famImage) {
        _famImage = [[UIImageView alloc] initWithFrame:AdaptationFrame(560+ZeroContentOffset, 30, 131, 358)];
        _famImage.image = MImage(@"jp_IMG");
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:AdaptationFrame(0, 15, 131, 325)];
        nameLabel.text = [NSString verticalStringWith:@"云南大理段氏"];
        nameLabel.textAlignment = 1;
        nameLabel.numberOfLines = 0;
        nameLabel.font = WFont(40);
        _famName = nameLabel;
        [_famImage addSubview:_famName];
    }
    return _famImage;
}


-(UIButton *)switchFam{
    if (!_switchFam) {
        _switchFam = [[UIButton alloc] initWithFrame:AdaptationFrame(660, 413+self.comNavi.frame.size.height/AdaptationWidth(), 62, 200)];
        _switchFam.backgroundColor = [UIColor blackColor];
        _switchFam.alpha = 0.7;
        [_switchFam setTitle:@"切换家谱" forState:0];
        _switchFam.titleLabel.numberOfLines = 0;
        _switchFam.titleLabel.font = WFont(33);
        [_switchFam addTarget:self action:@selector(respondsToSwitchFam:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchFam;
}

-(WSwitchDetailFamView *)switchDetailView{
    if (!_switchDetailView) {
        _switchDetailView = [[WSwitchDetailFamView alloc] initWithFrame:AdaptationFrame(self.view.bounds.size.width/AdaptationWidth()-187, 395+143, 187, 600) famNamesArr:[WSelectMyFamModel sharedWselectMyFamModel].myFamArray];
        _switchDetailView.delegate = self;
    }
    return _switchDetailView;
}

-(UIButton *)addJPBtn{
    if (!_addJPBtn) {
        _addJPBtn = [[UIButton alloc] initWithFrame:AdaptationFrame(ZeroContentOffset+50, 600, 131, 358)];
        [_addJPBtn setImage:MImage(@"addJP") forState:0];
        [_addJPBtn addTarget:self action:@selector(respondsToAddJpBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addJPBtn;
}
@end



