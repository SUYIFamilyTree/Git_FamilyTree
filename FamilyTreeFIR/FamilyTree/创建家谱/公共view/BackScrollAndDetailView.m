//
//  BackScrollAndDetailView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "BackScrollAndDetailView.h"

#define GapOfView 15

#define InputView_height 40

@interface BackScrollAndDetailView()
@property (nonatomic,strong) UIScrollView *backView; /*滚动背景*/
@property (nonatomic,strong) UIView *whiteBack; /*半透明背景*/

@property (nonatomic,strong) UIButton *createBtn; /*创建按钮*/

@property (nonatomic,strong) InputView *birthLabel; /*生辰年*/

@property (nonatomic,strong) InputView *monthLabel; /*月*/

@property (nonatomic,strong) InputView *dayLabel; /*日*/


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
        
        self.birthLabel = [self creatLabelTextWithTitle:@"生辰:" TitleFrame:CGRectMake(20, GapOfView+CGRectYH(self.selecProtrai), 50, InputView_height) inputViewLength:0.13*Screen_width dataArr:@[@"1990",@"1992",@"1992"] inputViewLabel:@"1990" FinText:@"年" withStar:NO];
        [self.backView addSubview:self.birthLabel];
        
        self.monthLabel = [self creatLabelTextWithTitle:@"" TitleFrame:CGRectMake(CGRectXW(self.birthLabel)+25, GapOfView+CGRectYH(self.selecProtrai), 0, InputView_height) inputViewLength:0.13*Screen_width dataArr:@[@"1",@"22",@"3"] inputViewLabel:@"不详" FinText:@"月" withStar:NO];
        [self.backView addSubview:self.monthLabel];
        
        self.dayLabel = [self creatLabelTextWithTitle:@"" TitleFrame:CGRectMake(CGRectXW(self.monthLabel)+25, GapOfView+ CGRectYH(self.selecProtrai), 0, InputView_height) inputViewLength:0.13*Screen_width dataArr:@[@"1",@"22"] inputViewLabel:@"不详" FinText:@"日" withStar:YES];
        [self.backView addSubview:self.dayLabel];
        
        
       
    }
    return self;
}

#pragma mark *** events ***
-(void)respondsToCreatBtn:(UIButton *)sender{
    MYLog(@"创建！");
}

#pragma mark *** getters ***

-(UIScrollView *)backView{
    if (!_backView) {
        _backView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height)];
        _backView.contentSize = CGSizeMake(Screen_width, Screen_height*2);
        _backView.bounces = NO;
        _backView.backgroundColor = [UIColor colorWithPatternImage:MImage(@"cratebg.png")];
    }
    return _backView;
}
-(UIButton *)createBtn{
    if (!_createBtn) {
        _createBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.backView.bounds)*2-50-64, Screen_width-20, 40)];
        [_createBtn setTitle:@"创 建" forState:0];
        _createBtn.backgroundColor = LH_RGBCOLOR(74, 81, 97);
        [_createBtn addTarget:self action:@selector(respondsToCreatBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _createBtn;
}
-(UIView *)whiteBack{
    if (!_whiteBack) {
        _whiteBack = [[UIView alloc] initWithFrame:CGRectMake(10, 15, Screen_width-20, Screen_height*2-40-50-64)];
        _whiteBack.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    }
    return _whiteBack;
}

//创建labelText
-(InputView *)creatLabelTextWithTitle:(NSString *)title TitleFrame:(CGRect)frame inputViewLength:(NSInteger)length dataArr:(NSArray *)dataArr inputViewLabel:(NSString *)labelText FinText:(NSString *)finStr withStar:(BOOL)star{
    UILabel *theLabel = [[UILabel alloc] initWithFrame:frame];
    theLabel.text = title;
    [self.backView addSubview:theLabel];
    
    InputView *inputView = [[InputView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(theLabel.frame), theLabel.frame.origin.y, length+10, InputView_height) Length:length+10 withData:dataArr];
    inputView.inputLabel.text = labelText;
    
    UILabel *finLabel = [UILabel new];
    finLabel.text = finStr;
    [self.backView addSubview:finLabel];
    
    finLabel.sd_layout.leftSpaceToView(inputView,5).topEqualToView(theLabel).bottomEqualToView(theLabel).widthIs(20);
    
    if (star) {
        UILabel *starLabel = [UILabel new];
        starLabel.font = MFont(10);
        starLabel.text = @"*";
        starLabel.textColor = [UIColor redColor];
        [self.backView addSubview:starLabel];
        starLabel.sd_layout.leftSpaceToView(finLabel,5).widthIs(10).heightIs(InputView_height);
    }
    return inputView;
}


-(InputView *)inputView{
    if (!_inputView) {
        
        UILabel *theLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 80, InputView_height)];
        theLabel.text = @"是否结婚:";
        [self.backView addSubview:theLabel];
        
        _inputView = [[InputView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(theLabel.frame), theLabel.frame.origin.y, 70, InputView_height) Length:50 withData:@[@" 是",@" 否"]];
        _inputView.inputLabel.text = @" 否";
        
    }
    return _inputView;
}
-(UITextField *)parnName{
    if (!_parnName) {
        UILabel *theLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectYH(self.inputView)+GapOfView, 0.34*Screen_width, InputView_height)];
        theLabel.text = @"输入配偶姓名:";
        [self.backView addSubview:theLabel];
        _parnName = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(theLabel.frame), theLabel.frame.origin.y, 0.5*Screen_width, InputView_height)];
        _parnName.backgroundColor = [UIColor whiteColor];
        _parnName.layer.borderWidth = 1.0f;
        _parnName.layer.borderColor = BorderColor;
        _parnName.placeholder = @"第一（原）配姓名";
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
        [seletBtn setTitleColor:[UIColor blackColor] forState:0];
        seletBtn.layer.borderWidth = 1.0f;
        seletBtn.layer.borderColor = BorderColor;
        seletBtn.backgroundColor = [UIColor whiteColor];
        [self.backView addSubview:seletBtn];
        
    }
    return _selecProtrai;
}
@end
