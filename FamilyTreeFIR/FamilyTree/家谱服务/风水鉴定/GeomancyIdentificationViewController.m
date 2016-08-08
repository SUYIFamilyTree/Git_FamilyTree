//
//  GeomancyIdentificationViewController.m
//  FamilyTree
//
//  Created by 姚珉 on 16/8/5.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "GeomancyIdentificationViewController.h"
#import "GeoTableViewCell.h"
#import "NSString+YJudgeValidateNumber.h"
@interface GeomancyIdentificationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
/** 底部滚动视图*/
@property (nonatomic, strong) UIScrollView *backSV;
/** 首块白色背景*/
@property (nonatomic, strong) UIView *firstBackV;
/** 鉴定类型按钮*/
@property (nonatomic, strong) UIButton *identificationTypeBtn;
/** 年按钮*/
@property (nonatomic, strong) UIButton *yearBtn;
/** 月按钮*/
@property (nonatomic, strong) UIButton *monthBtn;
/** 日按钮*/
@property (nonatomic, strong) UIButton *dayBtn;
/** 第二个白色背景*/
@property (nonatomic, strong) UIView *secondBackV;
/** 联系人文本*/
@property (nonatomic, strong) UITextField *linkManTF;
/** 电话文本*/
@property (nonatomic, strong) UITextField *telTF;
/** 鉴定类型表*/
@property (nonatomic, strong) UITableView *identificationTypeTB;
/** 年表*/
@property (nonatomic, strong) UITableView *yearTB;
/** 月表*/
@property (nonatomic, strong) UITableView *monthTB;
/** 日表*/
@property (nonatomic, strong) UITableView *dayTB;
/** 鉴定类型数组*/
@property (nonatomic, strong) NSArray *identificationTypeArr;
/** 年份数组*/
@property (nonatomic, strong) NSArray *yearArr;
/** 鉴定类型id*/
@property (nonatomic, assign) NSInteger identificationID;
@end

@implementation GeomancyIdentificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.identificationID = 0;
    [self initUI];
}

#pragma mark - 视图初始化
-(void)initUI{
    [self.view addSubview:self.backSV];
    [self.backSV addSubview:self.firstBackV];
    //风水鉴定说明
    UITextView *geoInfoTX = [[UITextView alloc]initWithFrame:CGRectMake(15, 10, Screen_width-30, 95)];
    geoInfoTX.attributedText = [NSString getLineSpaceStr:@"葬者，乘生气也，气乘风则散，界水则止，古人聚之使不散，行之使有止，故谓之风水，风水之法，得水为上，藏风次之。\n阳宅、墓地、祠堂、厂址的风水大全。"];
    geoInfoTX.font = MFont(13);
    geoInfoTX.editable = NO;
    geoInfoTX.userInteractionEnabled = NO;
    [self.firstBackV addSubview:geoInfoTX];
    //鉴定类型
    UILabel *identificationTypeLB = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectYH(geoInfoTX)+5, 65, 30)];
    identificationTypeLB.text = @"鉴定类型:";
    identificationTypeLB.font = MFont(13);
    //identificationTypeLB.backgroundColor = [UIColor random];
    [self.firstBackV addSubview:identificationTypeLB];
    //鉴定类型按钮
    self.identificationTypeBtn = [self creatCustomBtnWithFrame:CGRectMake(CGRectXW(identificationTypeLB), CGRectY(identificationTypeLB), 90, CGRectH(identificationTypeLB))];
    [self.identificationTypeBtn setTitle:@"阳宅" forState:UIControlStateNormal];
    self.identificationTypeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    self.identificationTypeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0);
    self.identificationTypeBtn.tag = 111+0;
    [self.firstBackV addSubview:self.identificationTypeBtn];
    //鉴定时间
    UILabel *identificationTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectYH(identificationTypeLB)+5, 65, 30)];
    identificationTimeLB.text = @"鉴定时间:";
    identificationTimeLB.font = MFont(13);
    //identificationTimeLB.backgroundColor = [UIColor random];
    [self.firstBackV addSubview:identificationTimeLB];
    
    //年
    self.yearBtn = [self creatCustomBtnWithFrame:CGRectMake(CGRectXW(identificationTimeLB), CGRectY(identificationTimeLB), 45, 30)];
    [self.yearBtn setTitle:@"2016" forState:UIControlStateNormal];
    self.yearBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    self.yearBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 35, 0, 0);
    self.yearBtn.tag = 111+1;
    [self.firstBackV addSubview:self.yearBtn];
    
    UILabel *yearLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(self.yearBtn), CGRectY(self.yearBtn), 20, CGRectH(self.yearBtn))];
    yearLB.text = @"年";
    yearLB.font = MFont(13);
    yearLB.textAlignment = NSTextAlignmentCenter;
    [self.firstBackV addSubview:yearLB];
    //月
    self.monthBtn = [self creatCustomBtnWithFrame:CGRectMake(CGRectXW(yearLB), CGRectY(identificationTimeLB), 45, 30)];
    [self.monthBtn setTitle:@"1" forState:UIControlStateNormal];
    self.monthBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    self.monthBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 35, 0, 0);
    self.monthBtn.tag = 111+2;
    [self.firstBackV addSubview:self.monthBtn];
    
    UILabel *monthLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(self.monthBtn), CGRectY(self.monthBtn), 20, CGRectH(self.monthBtn))];
    monthLB.text = @"月";
    monthLB.font = MFont(13);
    monthLB.textAlignment = NSTextAlignmentCenter;
    [self.firstBackV addSubview:monthLB];
    //日
    self.dayBtn = [self creatCustomBtnWithFrame:CGRectMake(CGRectXW(monthLB), CGRectY(identificationTimeLB), 45, 30)];
    [self.dayBtn setTitle:@"1" forState:UIControlStateNormal];
    self.dayBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    self.dayBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 35, 0, 0);
    self.dayBtn.tag = 111+3;
    [self.firstBackV addSubview:self.dayBtn];
    
    UILabel *dayLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(self.dayBtn), CGRectY(self.dayBtn), 20, CGRectH(self.dayBtn))];
    dayLB.text = @"日";
    dayLB.font = MFont(13);
    dayLB.textAlignment = NSTextAlignmentCenter;
    [self.firstBackV addSubview:dayLB];
    
    [self.backSV addSubview:self.secondBackV];
    //联系人
    UILabel *linkManLB = [[UILabel alloc]initWithFrame:CGRectMake(30, 20, 55, 30)];
    linkManLB.text = @"联系人:";
    linkManLB.font = MFont(13);
    [self.secondBackV addSubview:linkManLB];
    
    self.linkManTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectXW(linkManLB), CGRectY(linkManLB), CGRectX(dayLB)-CGRectXW(identificationTimeLB), 30)];
    self.linkManTF.layer.borderColor = LH_RGBCOLOR(215, 215, 215).CGColor;
    self.linkManTF.layer.borderWidth = 1;
    [self.secondBackV addSubview:self.linkManTF];
    //电话
    UILabel *telLB = [[UILabel alloc]initWithFrame:CGRectMake(40, CGRectYH(linkManLB)+15, 45, 30)];
    telLB.text = @"电话:";
    telLB.font = MFont(13);
    [self.secondBackV addSubview:telLB];
    
    self.telTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectXW(telLB), CGRectY(telLB), CGRectW(self.linkManTF), 30)];
    self.telTF.layer.borderColor = LH_RGBCOLOR(215, 215, 215).CGColor;
    self.telTF.layer.borderWidth = 1;
    self.telTF.delegate = self;
    [self.secondBackV addSubview:self.telTF];
    
    //提交按钮
    UIButton *postBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectYH(self.secondBackV)+10, Screen_width-20, 39)];
    postBtn.backgroundColor = LH_RGBCOLOR(74, 88, 92);
    [postBtn setTitle:@"提交" forState:UIControlStateNormal];
    [postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    postBtn.titleLabel.font = MFont(15);
    [postBtn addTarget:self action:@selector(clickToPost) forControlEvents:UIControlEventTouchUpInside];
    [self.backSV addSubview:postBtn];
}

#pragma mark - 点击方法
-(void)clickToSelect:(UIButton *)sender{
    sender.selected = !sender.selected;
    UITableView *tableView = (UITableView *)[self.view viewWithTag:sender.tag-111+222];
    if (sender.selected) {
        switch (sender.tag-111) {
                //鉴定类型
            case 0:
                [self.view addSubview:self.identificationTypeTB];
                break;
            case 1:
                [self.view addSubview:self.yearTB];
                break;
            case 2:
                [self.view addSubview:self.monthTB];
                break;
            case 3:
                [self.view addSubview:self.dayTB];
                break;
            default:
                break;
        }
    }else{
        [self.dayTB reloadData];
        [tableView removeFromSuperview];
    }
    
}

-(void)clickToPost{
    MYLog(@"提交");
    if (IsNilString(self.linkManTF.text)) {
        [SXLoadingView showAlertHUD:@"联系人不能为空" duration:0.5];
    }else if(IsNilString(self.telTF.text)){
        [SXLoadingView showAlertHUD:@"联系电话不能为空" duration:0.5];
    }else{
        [self postData];
    }
    
}

#pragma mark - 请求
-(void)postData{
    
    NSString *dateTime = [NSString stringWithFormat:@"%@-%02ld-%02ldT00:00:00",self.yearBtn.currentTitle,[self.monthBtn.currentTitle integerValue],[self.dayBtn.currentTitle integerValue]];
    NSDictionary *logDic = @{@"PsId":@0,
                             @"PsMemberid":GetUserId,
                             @"PsType":@"FSJD",
                             @"PsProjecttype":@(self.identificationID),
                             @"PsProjecttime":dateTime,
                             @"PsAreaid":@0,
                             @"PsContacts":self.linkManTF.text,
                             @"PsTel":self.telTF.text,
                             @"PsBudget":@0,
                             @"PsAddress":@"",
                             @"PsState":@"",
                             @"PsCreatetime":@"",
                             @"PsKeepstr01":@"",
                             @"PsKeepstr02":@"",
                             @"PsKeepnum01":@0,
                             @"PsKeepnum02":@0,
                             @"PsKeepdate":@""
                             };
    WK(weakSelf)
    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:GetUserId requestcode:@"fsjdadd" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        //MYLog(@"%@",jsonDic);
        if (succe) {
            [SXLoadingView showAlertHUD:@"提交成功" duration:0.5];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (tableView.tag-222) {
        case 0:
            return self.identificationTypeArr.count;
            break;
        case 1:
            return self.yearArr.count;
            break;
        case 2:
            return 12;
            break;
        case 3:
            {
                switch([self.monthBtn.currentTitle integerValue])
                {
                    case 1:
                    case 3:
                    case 5:
                    case 7:
                    case 8:
                    case 10:
                    case 12:
                        return 31;
                        break;
                    case 4:
                    case 6:
                    case 9:
                    case 11:
                        return 30;
                        break;
                    case 2:
                    {
                        if((([self.yearBtn.currentTitle integerValue]%4==0)&&([self.yearBtn.currentTitle integerValue]%100!=0))||([self.yearBtn.currentTitle integerValue]%400==0))
                        {
                            return 29;
                            break;
                        }
                        else
                        {
                            return 28;
                            break;
                        }
                    }
                    default:
                        break;
                }
            }
            
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GeoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"geoCell"];
    if (!cell) {
                cell = [[GeoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"geoCell"];
            }
            switch (tableView.tag - 222) {
                case 0:
                    cell.customLB.text = self.identificationTypeArr[indexPath.row];
                    break;
                case 1:
                    cell.customLB.text = [NSString stringWithFormat:@"%@",self.yearArr[indexPath.row]];
                    break;
                case 2:
                case 3:
                    cell.customLB.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
                    break;
            
                default:
                    break;
            }

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.identificationTypeTB]) {
        self.identificationID = indexPath.row;
    }
    GeoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIButton *button = (UIButton *)[self.view viewWithTag:111+tableView.tag-222];
    button.selected = !button.selected;
    [button setTitle:cell.customLB.text forState:UIControlStateNormal];
    [self.dayTB reloadData];
    [tableView removeFromSuperview];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return [NSString validateNumber:string];
}

#pragma mark - lazyLoad
-(UIScrollView *)backSV{
    if (!_backSV) {
        _backSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height-64-49)];
        _backSV.backgroundColor = LH_RGBCOLOR(235, 236, 237);
        _backSV.contentSize = CGSizeMake(Screen_width, 460);
    }
    return _backSV;
}

-(UIView *)firstBackV{
    if (!_firstBackV) {
        _firstBackV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, 200)];
        _firstBackV.backgroundColor = [UIColor whiteColor];
    }
    return _firstBackV;
}

-(UIView *)secondBackV{
    if (!_secondBackV) {
        _secondBackV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectYH(self.firstBackV)+10, Screen_width, 105)];
        _secondBackV.backgroundColor = [UIColor whiteColor];
    }
    return _secondBackV;
}

-(UITableView *)identificationTypeTB{
    if (!_identificationTypeTB) {
        _identificationTypeTB = [[UITableView alloc]initWithFrame:CGRectMake(CGRectX(self.identificationTypeBtn), CGRectYH(self.identificationTypeBtn)+64, CGRectW(self.identificationTypeBtn), 100)];
        _identificationTypeTB.dataSource = self;
        _identificationTypeTB.delegate = self;
        _identificationTypeTB.tag = 222+0;
        _identificationTypeTB.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _identificationTypeTB;
}

-(UITableView *)yearTB{
    if (!_yearTB) {
        _yearTB = [[UITableView alloc]initWithFrame:CGRectMake(CGRectX(self.yearBtn), CGRectYH(self.yearBtn)+64, CGRectW(self.yearBtn), 100)];
        _yearTB.dataSource = self;
        _yearTB.delegate = self;
        _yearTB.tag = 222+1;
        _yearTB.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _yearTB;
}

-(UITableView *)monthTB{
    if (!_monthTB) {
        _monthTB = [[UITableView alloc]initWithFrame:CGRectMake(CGRectX(self.monthBtn), CGRectYH(self.monthBtn)+64, CGRectW(self.monthBtn), 100)];
        _monthTB.dataSource = self;
        _monthTB.delegate = self;
        _monthTB.tag = 222+2;
        _monthTB.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _monthTB;
}

-(UITableView *)dayTB{
    if (!_dayTB) {
        _dayTB = [[UITableView alloc]initWithFrame:CGRectMake(CGRectX(self.dayBtn), CGRectYH(self.dayBtn)+64, CGRectW(self.dayBtn), 100)];
        _dayTB.dataSource = self;
        _dayTB.delegate = self;
        _dayTB.tag = 222+3;
        _dayTB.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _dayTB;
}

-(NSArray *)identificationTypeArr{
    if (!_identificationTypeArr) {
        _identificationTypeArr = @[@"阳宅",@"墓地",@"祠堂",@"厂址",@"建设"];
    }
    return _identificationTypeArr;
}

-(NSArray *)yearArr{
    if (!_yearArr) {
        NSMutableArray *array = [@[] mutableCopy];
        for (int i = 0; i < 20; i++) {
            [array addObject:[NSString stringWithFormat:@"%d",2016+i]];
        }
        _yearArr = [array copy];
    }
    return _yearArr;
}



//重写个button方法
-(UIButton *)creatCustomBtnWithFrame:(CGRect)frame{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    button.layer.borderColor = LH_RGBCOLOR(215, 215, 215).CGColor;
    button.layer.borderWidth = 1;
    button.titleLabel.font = MFont(13);
    [button setImage:MImage(@"wdhz_jiantou") forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickToSelect:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
