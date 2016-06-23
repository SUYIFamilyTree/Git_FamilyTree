//
//  BackScrollAndDetailView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//
enum{
    UPloadImageTag,
    UPloadVideoTag
};
#import "BackScrollAndDetailView.h"

#define ScrollContentHeight 1150

#define FirstViewFrameOfheight 315+GapOfView


@interface BackScrollAndDetailView()

@end

@implementation BackScrollAndDetailView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backView];
        [self.backView addSubview:self.createBtn];
        [self.backView addSubview:self.whiteBack];
      
        [self.backView addSubview:self.inputView];
        [self.backView addSubview:self.parnName];
        [self.backView addSubview:self.selecProtrai];
 
        [self initUI];
        
        //设置font
        
       
    }
    return self;
}

#pragma mark *** events ***
-(void)respondsToBackScrlCreatBtn:(UIButton *)sender{
    MYLog(@"创建！");
    if (_delegate && [_delegate respondsToSelector:@selector(BackScrollAndDetailViewDidTapCreateButton)]) {
        [_delegate BackScrollAndDetailViewDidTapCreateButton];
    };
}

#pragma mark *** UI ***

-(void)initUI{
    
    NSMutableArray *yearArr = [@[] mutableCopy];
    for (int idx = 2016; idx>=1900; idx--) {
        NSString *str = [NSString stringWithFormat:@"%d",idx];
        [yearArr addObject:str];
    }
    NSMutableArray *dayArr = [@[] mutableCopy];
    for (int idx = 1; idx<32; idx++) {
        if (idx<10) {
            [dayArr addObject:[NSString stringWithFormat:@"0%d",idx]];
        }else{
            [dayArr addObject:[NSString stringWithFormat:@"%d",idx]];
        }
    }
   
    
    //配偶年月日
    self.birthLabel = [self creatLabelTextWithTitle:@"生辰:" TitleFrame:CGRectMake(20, GapOfView+CGRectYH(self.selecProtrai), 50, InputView_height) inputViewLength:0.15*Screen_width dataArr:yearArr inputViewLabel:@"1990" FinText:@"年" withStar:NO];
    [self.backView addSubview:self.birthLabel];
    
    
    self.monthLabel = [self creatLabelTextWithTitle:@"" TitleFrame:CGRectMake(CGRectXW(self.birthLabel)+25, GapOfView+CGRectYH(self.selecProtrai), 0, InputView_height) inputViewLength:0.13*Screen_width dataArr:@[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"] inputViewLabel:@"不详" FinText:@"月" withStar:NO];
    [self.backView addSubview:self.monthLabel];
    
    self.dayLabel = [self creatLabelTextWithTitle:@"" TitleFrame:CGRectMake(CGRectXW(self.monthLabel)+25, GapOfView+ CGRectYH(self.selecProtrai), 0, InputView_height) inputViewLength:0.13*Screen_width dataArr:dayArr inputViewLabel:@"不详" FinText:@"日" withStar:false];
    [self.backView addSubview:self.dayLabel];
    
    [self.backView addSubview:self.birtime];
    
    
    //自己年月日
    
    self.liveNowLabel = [self creatLabelTextWithTitle:@"是否健在:" TitleFrame:CGRectMake(20, CGRectYH(self.birtime)+GapOfView, 90, InputView_height) inputViewLength:50 dataArr:@[@"是",@"否"] inputViewLabel:@"否" FinText:@"" withStar:NO];
    [self.backView addSubview:self.liveNowLabel];
    
    
    
    self.selfYear  = [self creatLabelTextWithTitle:@"" TitleFrame:CGRectMake(20, CGRectYH(self.liveNowLabel)+GapOfView, 0, InputView_height) inputViewLength:0.15*Screen_width dataArr:yearArr inputViewLabel:@"1990" FinText:@"年" withStar:NO];
    self.selfMonth = [self creatLabelTextWithTitle:@"" TitleFrame:CGRectMake(CGRectXW(self.selfYear)+25, CGRectYH(self.liveNowLabel)+GapOfView, 0, InputView_height) inputViewLength:0.13*Screen_width dataArr:@[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"] inputViewLabel:@"" FinText:@"月" withStar:NO];
    
  
    
    self.selfDay = [self creatLabelTextWithTitle:@"" TitleFrame:CGRectMake(CGRectXW(self.selfMonth)+25, CGRectYH(self.liveNowLabel)+GapOfView, 0, InputView_height) inputViewLength:0.13*Screen_width dataArr:dayArr inputViewLabel:@"01" FinText:@"日" withStar:true];
    
    [self.backView addSubview:self.selfYear];
    [self.backView addSubview:self.selfMonth];
    [self.backView addSubview:self.selfDay];
    
    //字辈
    
    NSMutableArray *allGenNum = [@[] mutableCopy];
    
    for (int idx = 1; idx<1000; idx++) {
        NSString *str = [NSString stringWithFormat:@"第%d代",idx];
        [allGenNum addObject:str];
    }
    
    self.generationLabel = [self creatLabelTextWithTitle:@"字辈:" TitleFrame:CGRectMake(20, CGRectYH(self.selfYear)+GapOfView, 0.15*Screen_width, InputView_height) inputViewLength:0.23*Screen_width dataArr:allGenNum inputViewLabel:@" 第一代" FinText:@"" withStar:NO];
    
    [self.backView addSubview:self.generationLabel];
    [self.backView addSubview:self.gennerationNex];
    
    
    
    //个人简介
    [self.backView addSubview:self.selfTextView];
    self.selfTextView.sd_layout.leftSpaceToView(self.backView,20).rightSpaceToView(self.backView,20).topSpaceToView(self.gennerationNex,GapOfView).heightIs(100);
    
    //上传图片和影音
    [self.backView addSubview:self.uploadImageBtn];
    self.uploadImageBtn.sd_layout.leftEqualToView(self.selfTextView).topSpaceToView(self.selfTextView,GapOfView).heightIs(InputView_height).widthIs(0.4*Screen_width);
    
    UIButton *videoBtn = [UIButton new];
    [videoBtn setTitle:@"上传影音资料" forState:0];
    videoBtn.titleLabel.font = WFont(32);
    [videoBtn setTitleColor:[UIColor blackColor] forState:0];
    videoBtn.layer.borderWidth = 1.0f;
    videoBtn.layer.borderColor = BorderColor;
    videoBtn.tag = UPloadVideoTag;
    [videoBtn addTarget:self action:@selector(respondsToUploadbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backView addSubview:videoBtn];
    videoBtn.sd_layout.leftSpaceToView(self.uploadImageBtn,10).rightSpaceToView(self.backView,20).heightIs(InputView_height).topSpaceToView(self.selfTextView,GapOfView);
    
    //迁移着居住地
    UITextField *textF = [UITextField new];
    textF.layer.borderWidth = 1.0f;
    textF.layer.borderColor = BorderColor;
    textF.placeholder = @"迁移者填居住地";
    textF.textAlignment  = 1;
    self.moveCity = textF;
    [self.backView addSubview:self.moveCity];
    
    self.moveCity.sd_layout.leftEqualToView(self.selfTextView).rightEqualToView(self.selfTextView).topSpaceToView(self.uploadImageBtn,GapOfView).heightIs(InputView_height);
    
    //层级关系改变
    [self.backView bringSubviewToFront:self.generationLabel];
    [self.backView bringSubviewToFront:self.selfYear];
    [self.backView bringSubviewToFront:self.selfMonth];
    [self.backView bringSubviewToFront:self.selfDay];
    [self.backView bringSubviewToFront:self.liveNowLabel];
    [self.backView bringSubviewToFront:self.birtime];
    [self.backView bringSubviewToFront:self.dayLabel];
    [self.backView bringSubviewToFront:self.monthLabel];
    [self.backView bringSubviewToFront:self.birthLabel];
    [self.backView bringSubviewToFront:self.inputView];
    
}


//创建labelText
-(InputView *)creatLabelTextWithTitle:(NSString *)title TitleFrame:(CGRect)frame inputViewLength:(NSInteger)length dataArr:(NSArray *)dataArr inputViewLabel:(NSString *)labelText FinText:(NSString *)finStr withStar:(BOOL)star{
    
    UILabel *theLabel = [[UILabel alloc] initWithFrame:frame];
    theLabel.text = title;
    theLabel.font = WFont(33);
    [self.backView addSubview:theLabel];
    
    InputView *inputView = [[InputView alloc] initWithFrame:CGRectMake(CGRectXW(theLabel), theLabel.frame.origin.y, length+10, InputView_height) Length:length+10 withData:dataArr];

    
    UILabel *finLabel = [UILabel new];
    finLabel.text = finStr;
    [self.backView addSubview:finLabel];
    
    finLabel.sd_layout.leftSpaceToView(inputView,5).topEqualToView(theLabel).bottomEqualToView(theLabel).widthIs(20);
    
    if (star) {
        UILabel *starLabel = [UILabel new];
        starLabel.font = MFont(16);
        starLabel.text = @"*";
        starLabel.textColor = [UIColor redColor];
        [self.backView addSubview:starLabel];
        starLabel.sd_layout.leftSpaceToView(finStr?finLabel:inputView,5).widthIs(10).heightIs(InputView_height).topEqualToView(inputView);
    }
    return inputView;
}





#pragma mark *** BtnEvents ***

-(void)respondsToUploadbtn:(UIButton *)sender{
    MYLog(@"上传图片");
    switch (sender.tag) {
        case UPloadImageTag:
        {
            
        }
            break;
        case UPloadVideoTag:
        {
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark *** getters ***

-(UIScrollView *)backView{
    if (!_backView) {
        _backView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height)];
        _backView.contentSize = CGSizeMake(Screen_width, ScrollContentHeight);
        _backView.bounces = NO;
        _backView.backgroundColor = [UIColor colorWithPatternImage:MImage(@"cratebg.png")];
        
    }
    return _backView;
}
-(UIButton *)createBtn{
    if (!_createBtn) {
        _createBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, ScrollContentHeight-50-64, Screen_width-20, 40)];
        [_createBtn setTitle:@"创 建" forState:0];
        _createBtn.backgroundColor = LH_RGBCOLOR(74, 81, 97);
        [_createBtn addTarget:self action:@selector(respondsToBackScrlCreatBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _createBtn;
}
-(UIView *)whiteBack{
    if (!_whiteBack) {
        _whiteBack = [[UIView alloc] initWithFrame:CGRectMake(10, 15, Screen_width-20, ScrollContentHeight-40-50-64)];
        _whiteBack.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
        
        UILabel *redLabel = [UILabel new];
        redLabel.font  = MFont(13);
        redLabel.textColor = [UIColor redColor];
        redLabel.text = @"注:*";
        [_whiteBack addSubview:redLabel];
        redLabel.sd_layout.leftSpaceToView(_whiteBack,10).topSpaceToView(_whiteBack,10).heightIs(20).widthIs(25);
        
        UILabel *remLabel = [UILabel new];
        remLabel.font = MFont(13);
        remLabel.textColor = [UIColor blackColor];
        remLabel.text = @"为必填项";
        [_whiteBack addSubview:remLabel];
        remLabel.sd_layout.leftSpaceToView(redLabel,0).topEqualToView(redLabel).heightIs(20).widthIs(100);
    }
    return _whiteBack;
}


-(InputView *)birtime{
    if (!_birtime) {
        _birtime = [[InputView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.birthLabel.frame), CGRectYH(self.birthLabel)+GapOfView, 0.34*Screen_width, InputView_height) Length:0.34*Screen_width withData:@[@"0:00-2:00",@"2:00-4:00",@"4:00-6:00",@"6:00-8:00",@"8:00-10:00",@"10:00-12:00",@"12:00-14:00",@"14:00-16:00",@"16:00-18:00",@"18:00-20:00",@"20:00-22:00",@"22:00-00:00"]];
        
        UILabel *starLabel = [UILabel new];
        starLabel.font = MFont(16);
        starLabel.text = @"*";
        starLabel.textColor = [UIColor redColor];
        [self.backView addSubview:starLabel];
        starLabel.sd_layout.leftSpaceToView(_birtime,5).widthIs(10).heightIs(InputView_height).topEqualToView(_birtime);
        
    }
    return _birtime;
}

//第一个控件是否结婚
-(InputView *)inputView{
    if (!_inputView) {
        
        UILabel *theLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, FirstViewFrameOfheight, 90, InputView_height)];
        theLabel.text = @"是否结婚:";
        theLabel.font = WFont(35);
        [self.backView addSubview:theLabel];
        
        _inputView = [[InputView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(theLabel.frame), theLabel.frame.origin.y, 70, InputView_height) Length:50 withData:@[@"是",@"否"]];
        _inputView.inputLabel.backgroundColor = [UIColor whiteColor];
        
    }
    return _inputView;
}
-(UITextField *)parnName{
    if (!_parnName) {
        UILabel *theLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectYH(self.inputView)+GapOfView, 0.34*Screen_width, InputView_height)];
        theLabel.text = @"输入配偶姓名:";
        theLabel.font = WFont(35);
        [self.backView addSubview:theLabel];
        _parnName = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(theLabel.frame), theLabel.frame.origin.y, 0.5*Screen_width, InputView_height)];
        _parnName.backgroundColor = [UIColor whiteColor];
        _parnName.layer.borderWidth = 1.0f;
        _parnName.layer.borderColor = BorderColor;
        _parnName.placeholder = @"第一（原）配姓名";
        _parnName.textAlignment = 1;
    }
    return _parnName;
}

-(UIImageView *)selecProtrai{
    if (!_selecProtrai) {
        _selecProtrai = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectYH(self.parnName)+GapOfView, 70, 40)];
        _selecProtrai.image = MImage(@"man");
        _selecProtrai.contentMode = UIViewContentModeScaleAspectFit;
        _selecProtrai.layer.borderColor = self.parnName.layer.borderColor;
        _selecProtrai.layer.borderWidth = 1.0f;
        
        UIButton *seletBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectXW(_selecProtrai)+20, _selecProtrai.frame.origin.y, 0.5*Screen_width, InputView_height)];
        [seletBtn setTitle:@"选择头像" forState:0];
        seletBtn.titleLabel.font = WFont(35);
        [seletBtn setTitleColor:[UIColor blackColor] forState:0];
        seletBtn.layer.borderWidth = 1.0f;
        seletBtn.layer.borderColor = BorderColor;
        seletBtn.backgroundColor = [UIColor whiteColor];
        [self.backView addSubview:seletBtn];
        
    }
    return _selecProtrai;
}

-(UITextField *)gennerationNex{
    if (!_gennerationNex) {
        _gennerationNex = [[UITextField alloc] initWithFrame:CGRectMake(CGRectXW(self.generationLabel)+10, CGRectYH(self.selfYear)+GapOfView, 0.45*Screen_width, InputView_height)];
        _gennerationNex.text = @"琚";
        _gennerationNex.font = WFont(35);
        _gennerationNex.backgroundColor = [UIColor whiteColor];
        _gennerationNex.layer.borderWidth = 1.0f;
        _gennerationNex.textAlignment = 1;
        _gennerationNex.layer.borderColor = BorderColor;
        
        
    }
    return _gennerationNex;
}

-(UITextView *)selfTextView{
    if (!_selfTextView) {
        _selfTextView = [UITextView new];
        _selfTextView.layer.borderColor = BorderColor;
        _selfTextView.layer.borderWidth = 1.0f;
        _selfTextView.backgroundColor = [UIColor whiteColor];
        _selfTextView.text = @"个人简介（生平经历传记）";
        
    }
    return _selfTextView;
}
-(UIButton *)uploadImageBtn{
    if (!_uploadImageBtn) {
        _uploadImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectYH(self.selfTextView)+GapOfView, 0.4*Screen_width, InputView_height)];
        _uploadImageBtn.layer.borderColor = BorderColor;
        _uploadImageBtn.layer.borderWidth = 1.0f;
        [_uploadImageBtn addTarget:self action:@selector(respondsToUploadbtn:) forControlEvents:UIControlEventTouchUpInside];
        _uploadImageBtn.tag = UPloadImageTag;
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, _uploadImageBtn.bounds.size.width/2-5, 40)];
        label1.text  = @"上传图片";
        label1.font = WFont(32);
        [_uploadImageBtn addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectXW(label1), 0, _uploadImageBtn.bounds.size.width/2, 40)];
        label2.font = MFont(13);
        label2.text = @"(可为多张)";
        [_uploadImageBtn addSubview:label2];
    }
    return _uploadImageBtn;
}

@end
