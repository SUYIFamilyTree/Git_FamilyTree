//
//  AddMenberView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/3.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "AddMenberView.h"

@interface AddMenberView()
{
    NSMutableDictionary *_idDic;//下拉身份
}
@end

@implementation AddMenberView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self getIdDataCallBackArray:^(NSArray<WIDModel *> *idArray) {
            _idDic = [NSMutableDictionary dictionary];
            [idArray enumerateObjectsUsingBlock:^(WIDModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //身份作value，id作key
                [_idDic setObject:obj.syntypeval forKey:obj.syntype];
                
            }];
            [WIDModel sharedWIDModel].idDic = _idDic;
            
            [self getFatherDataCallBack:^{
                [self initAddUI];
            }];
            
        }];
        
        
    }
    return self;
}
-(void)initAddUI{
    self.generationLabel.frame = CGRectMake(-100, CGRectYH(self.selfYear), 0, 0);
    
    self.gennerationNex.frame = CGRectMake(CGRectXW(self.generationLabel)+10, CGRectYH(self.selfYear), 0, 0);
//    self.backView.contentSize = CGSizeMake(self.backView.contentSize.width, 1150-70);
    
    [self.backView addSubview:self.name];
    
    self.fatheView = [self creatLabelTextWithTitle:@"父亲:" TitleFrame:CGRectMake(20, CGRectYH(self.name)+GapOfView, 55, InputView_height) inputViewLength:75 dataArr:[[WIDModel sharedWIDModel].fatherDic allKeys] inputViewLabel:@"郭祖宗" FinText:nil withStar:false];
    [self.backView addSubview:self.fatheView];
    
    self.motherView = [self creatLabelTextWithTitle:@"母亲:" TitleFrame:CGRectMake(Screen_width-350*AdaptationWidth(), CGRectYH(self.name)+GapOfView, 55, InputView_height) inputViewLength:75 dataArr:@[@"郭小妹",@"郭二妹",@"速度"] inputViewLabel:@"不详" FinText:nil withStar:YES];
    [self.backView addSubview:self.motherView];
    [self.backView addSubview:self.sexInView];
    
    
    
    
    self.idView = [self creatLabelTextWithTitle:@"身份:" TitleFrame:CGRectMake(CGRectXW(self.sexInView)+20*AdaptationWidth(), self.sexInView.frame.origin.y, 50, InputView_height) inputViewLength:50 dataArr:[_idDic allKeys] inputViewLabel:@"嫡出" FinText:nil withStar:NO];
    
    [self.backView addSubview:self.idView];
    [self.backView addSubview:self.famousPerson];
    
    
    
    
    
    
    NSMutableArray *allGenNum = [@[] mutableCopy];
    
    for (int idx = 1; idx<100; idx++) {
        NSString *str = [NSString stringWithFormat:@"第%d代",idx];
        [allGenNum addObject:str];
    }
    
    self.gennerNum   = [self creatLabelTextWithTitle:@"家族第几代:" TitleFrame:CGRectMake(20, CGRectYH(self.sexInView)+GapOfView, 0.25*Screen_width, InputView_height) inputViewLength:0.2*Screen_width dataArr:allGenNum inputViewLabel:@"第1代" FinText:nil withStar:YES];
    [self.backView addSubview:self.gennerNum];
    
    self.rankingView = [self creatLabelTextWithTitle:@"           排行:" TitleFrame:CGRectMake(20, CGRectYH(self.gennerNum)+GapOfView, 0.25*Screen_width, InputView_height) inputViewLength:0.2*Screen_width dataArr:allGenNum    inputViewLabel:@"第1代" FinText:nil withStar:YES];
    self.rankingView.inputLabel.textAlignment = 0;
    
    [self.backView addSubview:self.rankingView];
    
    //改变层级关系
    [self.backView bringSubviewToFront:self.gennerNum];
    [self.backView bringSubviewToFront:self.sexInView];
    [self.backView bringSubviewToFront:self.idView];
    [self.backView bringSubviewToFront:self.fatheView];
    [self.backView bringSubviewToFront:self.motherView];
    
    
}
-(void)getIdDataCallBackArray:(void (^)(NSArray<WIDModel *> *idArray))callBackArray{
    //身份类型
    //    [SXLoadingView showProgressHUD:@""];
    [TCJPHTTPRequestManager POSTWithParameters:@{@"typeval":@"GRSF"} requestID:GetUserId requestcode:kRequestCodeGetsyntype success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            
            NSLog(@"%@", jsonDic[@"data"]);
            NSArray<WIDModel *> *arr = [NSArray modelArrayWithClass:[WIDModel class] json:jsonDic[@"data"]];
            
            callBackArray(arr);
            
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)getFatherDataCallBack:(void (^)())back{
    //获取宗亲
    [SXLoadingView showProgressHUD:@"正在获取"];
    [TCJPHTTPRequestManager POSTWithParameters:@{@"query":@"",@"geid":@"1",@"pagenum":@"1",@"pagesize":@"20",@"sex":@"1"} requestID:GetUserId requestcode:kRequestCodequerygemelist success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        [SXLoadingView hideProgressHUD];
        NSLog(@"--rrrrr-%@", [NSString jsonDicWithDic:jsonDic[@"data"]]);
        NSDictionary *dic = [NSString jsonDicWithDic:jsonDic[@"data"]];
        NSMutableDictionary *fathDic = [NSMutableDictionary dictionary];
        for (NSDictionary *obj in dic[@"datalist"]) {
            [fathDic setObject:obj[@"GemeId"] forKey:obj[@"GemeName"]];
        }
        [WIDModel sharedWIDModel].fatherDic = fathDic;
        back();
        
    } failure:^(NSError *error) {
        MYLog(@"shibai");
    }];
}
#pragma mark *** getters ***
-(DiscAndNameView *)name{
    if (!_name) {
        _name = [[DiscAndNameView alloc] initWithFrame:CGRectMake(20,40+GapOfView, Screen_width-45, InputView_height) title:@"姓名:" detailCont:@"段正淳" isStar:YES];
        
    }
    return _name;
}

-(InputView *)sexInView{
    if (!_sexInView) {
        _sexInView = [[InputView alloc] initWithFrame:CGRectMake(20, CGRectYH(self.fatheView)+GapOfView, 50, InputView_height) Length:50 withData:@[@"男",@"女"]];
        _sexInView.inputLabel.text = @"男";
        
    }
    return _sexInView;
}

-(ClickRoundView *)famousPerson{
    if (!_famousPerson) {
        _famousPerson = [[ClickRoundView alloc] initWithFrame:CGRectMake(CGRectXW(self.idView), self.idView.frame.origin.y, 50, 40) withTitle:@"家族名人" isStar:YES];
    }
    return _famousPerson;
}


@end
