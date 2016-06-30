//
//  CreateFamViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "CreateFamViewController.h"
#import "BackScrollAndDetailView.h"
#import "CreateFamView.h"



@interface CreateFamViewController ()<BackScrollAndDetailViewDelegate>
@property (nonatomic,strong) CreateFamView *cFameView; /*创建家谱view*/

@end

@implementation CreateFamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.automaticallyAdjustsScrollViewInsets=false;
    self.tabBarController.tabBar.hidden = YES;
    
    [self initUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = true;

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = false;
}


#pragma mark *** BackScrollAndDetailViewDelegate ***
-(void)BackScrollAndDetailViewDidTapCreateButton{
    [self postCreateFamWithBlock:^(BOOL back,NSString *genID) {
        if (back) {
            
            
//            NSData *imageData = UIImageJPEGRepresentation(self.cFameView.famTotem.image, 1.0);
//            NSString *encodeImageData = [imageData base64EncodedString];
//            
//            [self postUploadheadImageWithGeID:genID base64CodeStr:encodeImageData];
        }
    }];
    
    
}
//请求创建家谱
-(void)postCreateFamWithBlock:(void (^)(BOOL back,NSString *genID))callBack{
    //创建家谱
    NSMutableDictionary *genDsListDic = [NSMutableDictionary dictionary];
    
    [self.cFameView.gennerNexArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (![obj isEqualToString:@""]) {
            [genDsListDic setValue:@[obj] forKey:[NSString stringWithFormat:@"%ld",idx+1]];
        }
        
    }];
    //    NSLog(@"1111---%@", genDsListDic);
    //截取代数
    NSString *genNumber = [self.cFameView.gennerNum.inputLabel.text stringByReplacingOccurrencesOfString:@"第" withString:@""];
    NSString *genNumberF = [genNumber stringByReplacingOccurrencesOfString:@"代" withString:@""];
    
    //首卷家谱空值处理
    if ([self.cFameView.famBookName.text isEqualToString:@""]) {
        self.cFameView.famBookName.text = @"";
    }
    NSLog(@"famName---%@", self.cFameView.famName.detailLabel.text);
    if ([self.cFameView.famName.detailLabel.text isEqualToString:@""]||self.cFameView.famName.titleLabel.text.length == 0) {
        [SXLoadingView showAlertHUD:@"家谱名称不能为空" duration:0.5];
        return;
    }
    if ([self.cFameView.famfarName.detailLabel.text isEqualToString:@""]||self.cFameView.famfarName.titleLabel.text.length == 0) {
        [SXLoadingView showAlertHUD:@"祖宗姓名不能为空" duration:0.5];
        return;
    }
    
    //结婚对象空处理
    if ([self.cFameView.parnName.text isEqualToString:@""]) {
        self.cFameView.parnName.text = @"";
    }
    
    NSString *parName = [self.cFameView.inputView.inputLabel.text isEqualToString:@""]?self.cFameView.parnName.text:@"";
    
    NSDictionary *dic = @{@"Ds":genNumberF,
                          @"GeSurname":@"",
                          @"JpName":self.cFameView.famBookName.text,
                          @"GeName":self.cFameView.famName.detailLabel.text,
                          @"GePhoto":@"",
                          @"Photo":@"",
                          @"Grjl":self.cFameView.selfTextView.text,
                          @"Jzd":self.cFameView.moveCity.text,
                          @"GemeSurname":@"",
                          @"GemeName":self.cFameView.famfarName.detailLabel.text,
                          @"GemeSex":[self.cFameView.sexInpuView.inputLabel.text isEqualToString:@"女"]?@"0":@"1",
                          @"GemeIsfamous":self.cFameView.famousPerson.marked?@"1":@"0",
                          
                          @"GemeYear":self.cFameView.birthLabel.inputLabel.text,
                          @"GemeMonth":self.cFameView.monthLabel.inputLabel.text,
                          @"GemeDay":self.cFameView.dayLabel.inputLabel.text,
                          @"GemeHour":self.cFameView.birtime.inputLabel.text,
                          @"GemeDeathtime":[self.cFameView.liveNowLabel.inputLabel.text isEqualToString:@"是"]?@"":[NSString stringWithFormat:@"%@-%@-%@",self.cFameView.selfYear.inputLabel.text,self.cFameView.selfMonth.inputLabel.text,self.cFameView.selfDay.inputLabel.text],
                          @"GemeIslife":[self.cFameView.liveNowLabel.inputLabel.text isEqualToString:@"是"]?@"1":@"0",
                          @"Po":parName,
                          @"IsEnt":self.cFameView.diXiView.marked?@"1":@"0",
                          @"DsList":genDsListDic};
    
    [SXLoadingView showProgressHUD:@"正在创建家谱..."];
    [TCJPHTTPRequestManager POSTWithParameters:dic requestID:GetUserId requestcode:kRequestCodecreategen success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        
        if (succe) {
            
//            NSLog(@"%@", jsonDic[@"data"]);
            
            NSDictionary *JTdic = [NSString jsonDicWithDic:jsonDic[@"data"]];
            
//            NSLog(@"dididi--%@", JTdic);
            callBack(succe,JTdic[@"geid"]);
            [SXLoadingView showProgressHUD:@"创建成功！" duration:0.5];
            //通知创建完成更新页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCodeManagerFam object:nil];
            
        }else{
            [SXLoadingView showProgressHUD:jsonDic[@"创建失败.."] duration:0.5];
        }
    } failure:^(NSError *error) {
        MYLog(@"失败");
    }];
}
//请求上传家谱图像
-(void)postUploadheadImageWithGeID:(NSString *)genID base64CodeStr:(NSString *)baseCode{
    
    [TCJPHTTPRequestManager POSTWithParameters:@{@"genid":genID,@"imgbt":baseCode} requestID:GetUserId requestcode:kRequestCodeuploadgenan success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSLog(@"%@", jsonDic);
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark *** 初始化界面 ***
-(void)initUI{
    
    CreateFamView *creFamView = [[CreateFamView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height)];
    creFamView.delegate = self;
    self.cFameView = creFamView;
    [self.view addSubview:self.cFameView];
    
    [self.view bringSubviewToFront:self.comNavi];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
