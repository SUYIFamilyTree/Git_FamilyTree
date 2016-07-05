//
//  AddMenberView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/3.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "AddMenberView.h"

@interface AddMenberView()

@end

@implementation AddMenberView
- (instancetype)initWithFrame:(CGRect)frame
{
    //改变某是否结婚控件的位置
    _inputViewDown = YES;
    self.backView.hidden = YES;
    
    self = [super initWithFrame:frame];
    if (self) {

        [self getAllDetailDataCallBack:^{
            [self initAddUI];
            self.backView.hidden = false;
        }];
        
        
    }
    return self;
}
-(void)initAddUI{
    
    
    self.generationLabel.frame = CGRectMake(-100, CGRectYH(self.selfYear), 0, 0);
    
    self.gennerationNex.frame = CGRectMake(CGRectXW(self.generationLabel)+10, CGRectYH(self.selfYear), 0, 0);
    
    [self.backView addSubview:self.name];
    
    
    
    
    self.fatheView = [self creatLabelTextWithTitle:@"父亲:" TitleFrame:CGRectMake(20, CGRectYH(self.name)+GapOfView, 55, InputView_height) inputViewLength:75 dataArr:[[WIDModel sharedWIDModel].fatherDic allKeys] inputViewLabel:@"郭祖宗" FinText:nil withStar:false];
    [self.backView addSubview:self.fatheView];
    
    self.motherView = [self creatLabelTextWithTitle:@"母亲:" TitleFrame:CGRectMake(Screen_width-350*AdaptationWidth(), CGRectYH(self.name)+GapOfView, 55, InputView_height) inputViewLength:75 dataArr:@[@"郭小妹",@"郭二妹",@"速度"] inputViewLabel:@"不详" FinText:nil withStar:YES];
    [self.backView addSubview:self.motherView];
    [self.backView addSubview:self.sexInView];
    
    
    
    
    self.idView = [self creatLabelTextWithTitle:@"身份:" TitleFrame:CGRectMake(CGRectXW(self.sexInView)+20*AdaptationWidth(), self.sexInView.frame.origin.y, 50, InputView_height) inputViewLength:50 dataArr:[[WIDModel sharedWIDModel].idDic allKeys] inputViewLabel:@"嫡出" FinText:nil withStar:NO];
    
    [self.backView addSubview:self.idView];
    [self.backView addSubview:self.famousPerson];
    

    //字辈代数和排行
    NSMutableArray *allGenNum = [@[] mutableCopy];
    NSMutableArray *allPaihang = [@[] mutableCopy];
    for (int idx = 1; idx<[[WIDModel sharedWIDModel].ds allKeys].count+1; idx++) {
        NSString *str = [NSString stringWithFormat:@"第%d代",idx];
        [allGenNum addObject:str];
        [allPaihang addObject:[NSString stringWithFormat:@"%d",idx]];
    }
    
    self.gennerNum   = [self creatLabelTextWithTitle:@"家族第几代:" TitleFrame:CGRectMake(20, CGRectYH(self.sexInView)+GapOfView, 0.25*Screen_width, InputView_height) inputViewLength:0.2*Screen_width dataArr:allGenNum inputViewLabel:@"第1代" FinText:nil withStar:YES];
    self.gennerNum.delegate = self;
    [self.backView addSubview:self.gennerNum];
    
    [self.backView addSubview:self.gennerTextField];
    
    self.rankingView = [self creatLabelTextWithTitle:@"            排行:" TitleFrame:CGRectMake(20, CGRectYH(self.gennerNum)+GapOfView+55, 0.25*Screen_width, InputView_height) inputViewLength:0.2*Screen_width dataArr:allPaihang    inputViewLabel:@"1" FinText:nil withStar:YES];
    self.rankingView.inputLabel.textAlignment = 0;
    
    [self.backView addSubview:self.rankingView];
    
    //改变层级关系
    [self.backView bringSubviewToFront:self.gennerNum];
    [self.backView bringSubviewToFront:self.sexInView];
    [self.backView bringSubviewToFront:self.idView];
    [self.backView bringSubviewToFront:self.fatheView];
    [self.backView bringSubviewToFront:self.motherView];
    
    
}

//获取父亲，身份类型，代数字辈

-(void)getAllDetailDataCallBack:(void (^)())back{
    [TCJPHTTPRequestManager POSTWithParameters:@{@"GeId":@"1"} requestID:GetUserId requestcode:kRequestCodegetgenalldata success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSLog(@"%@", [NSString jsonDicWithDic:jsonDic[@"data"]]);
            
            NSDictionary *dic = [NSString jsonDicWithDic:jsonDic[@"data"]];
            
            [[WIDModel sharedWIDModel] setValue:dic[@"sf"] forKey:@"sf"];
            [[WIDModel sharedWIDModel] setValue:dic[@"ds"] forKey:@"ds"];
            [[WIDModel sharedWIDModel] setValue:dic[@"gemedata"] forKey:@"gemedata"];
            
            NSLog(@"%@", [WIDModel sharedWIDModel].gemedata[0][@"GemeName"]);
            
            //存进单例
            NSArray *fathArr = [WIDModel sharedWIDModel].gemedata;
            NSMutableDictionary *fatherDic= [NSMutableDictionary dictionary];
            [fathArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [fatherDic setObject:obj[@"GemeId"] forKey:obj[@"GemeName"]];
            }];
            
            NSArray *sfArr = [WIDModel sharedWIDModel].sf;
            NSMutableDictionary *sfDic = [NSMutableDictionary dictionary];
            [sfArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [sfDic setObject:obj[@"AlId"] forKey:obj[@"AlName"]];
            }];
            
            [WIDModel sharedWIDModel].fatherDic = fatherDic;
            [WIDModel sharedWIDModel].idDic = sfDic;
            [WIDModel sharedWIDModel].genDic = [WIDModel sharedWIDModel].ds;
            
            back();
        }
    } failure:^(NSError *error) {
        NSLog(@"shibai");
    }];
}

#pragma mark *** InputViewDelegate ***

-(void)InputView:(InputView *)inputView didFinishSelectLabel:(UILabel *)inputLabel{
    [super InputView:inputView didFinishSelectLabel:inputLabel];
    
    if (inputView == self.gennerNum) {
        NSString *genNum = [inputLabel.text stringByReplacingOccurrencesOfString:@"第" withString:@""];
        NSString *finStr = [genNum stringByReplacingOccurrencesOfString:@"代" withString:@""];
        
        
        self.gennerTextField.text = [NSArray allItemsStringFromArray:[WIDModel sharedWIDModel].ds[finStr]] ;
        
    }
}


#pragma mark *** getters ***
-(DiscAndNameView *)name{
    if (!_name) {
        _name = [[DiscAndNameView alloc] initWithFrame:CGRectMake(20,40+GapOfView, Screen_width-45, InputView_height) title:@"姓名:" detailCont:@"段正淳" isStar:YES];
        
    }
    return _name;
}
-(UITextField *)gennerTextField{
    if (!_gennerTextField) {
        
        UILabel *theLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectYH(self.gennerNum)+GapOfView, 0.25*Screen_width, 40)];
        theLabel.text = @"字辈:";
        theLabel.font = WFont(33);
        theLabel.textAlignment = 2;
        [self.backView addSubview:theLabel];
        
        _gennerTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectXW(theLabel), CGRectY(theLabel), 100, InputView_height)];
        _gennerTextField.backgroundColor = [UIColor whiteColor];
        _gennerTextField.layer.borderWidth = 1.0;
        _gennerTextField.layer.borderColor = BorderColor;
        _gennerTextField.font = WFont(33);
        [_gennerTextField setEnabled:false];
        NSArray *arr = [WIDModel sharedWIDModel].ds[@"1"];
       __block NSString *firstZibei = @"";
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            firstZibei = [NSString stringWithFormat:@"%@%@",obj,firstZibei];
        }];
        _gennerTextField.text = firstZibei;
        
    }
    return _gennerTextField;
    
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
