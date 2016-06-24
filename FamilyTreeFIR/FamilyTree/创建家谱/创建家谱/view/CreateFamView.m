//
//  CreateFamView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/2.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "CreateFamView.h"
@interface CreateFamView()



@end

@implementation CreateFamView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initCreatUI];
    }
    
    return self;
}

#pragma mark *** 初始化界面 ***
-(void)initCreatUI{
    
    [self.backView addSubview:self.famousPerson];
    [self.backView addSubview:self.famName];
    [self.backView addSubview:self.famfarName];
//
    NSMutableArray *allGenNum = [@[] mutableCopy];
    
    for (int idx = 1; idx<100; idx++) {
        NSString *str = [NSString stringWithFormat:@"第%d代",idx];
        [allGenNum addObject:str];
    }
    
    self.gennerNum = [self creatLabelTextWithTitle:@"祖宗是家族第几代:" TitleFrame:CGRectMake(20, CGRectYH(self.famfarName)+GapOfView, 0.4*Screen_width, InputView_height) inputViewLength:0.2*Screen_width dataArr:allGenNum inputViewLabel:@"第1代" FinText:nil withStar:YES];
    [self.backView addSubview:self.gennerNum];
    
    [self.backView addSubview:self.famBookName];
    
    self.famBookName.sd_layout.leftSpaceToView(self.backView,20).topSpaceToView(self.famName,GapOfView*3+2*InputView_height).heightIs(InputView_height).rightSpaceToView(self.backView,20);
    
    [self.backView addSubview:self.sexInpuView];
    
    [self.backView addSubview:self.diXiView];
    
    [self.backView bringSubviewToFront:self.gennerNum];
    
}

-(DiscAndNameView *)famName{
    if (!_famName) {
        _famName = [[DiscAndNameView alloc] initWithFrame:CGRectMake(20,40+GapOfView, 0.6*Screen_width+10, InputView_height) title:@"家族名称:" detailCont:@"" isStar:YES];
    }
    return _famName;
}

-(DiscAndNameView *)famfarName{
    if (!_famfarName) {
        _famfarName = [[DiscAndNameView alloc] initWithFrame:CGRectMake(20, CGRectYH(self.famName)+GapOfView, self.famName.bounds.size.width, InputView_height) title:@"祖宗姓名（字）:" detailCont:@"" isStar:true];
        
    }
    return _famfarName;
}

-(UITextField *)famBookName{
    if (!_famBookName) {
        _famBookName = [UITextField new];
        [_famBookName setText:@"收卷家谱名称：段正淳（1-5）带卷普"];
        _famBookName.font = WFont(35);
        [_famBookName setTextColor:[UIColor blackColor] ];
        _famBookName.backgroundColor = [UIColor whiteColor];
        _famBookName.layer.borderColor = BorderColor;
        _famBookName.layer.borderWidth = 1.0f;
        _famBookName.textAlignment = 1;
        
    }
    return _famBookName;
}
-(InputView *)sexInpuView{
    if (!_sexInpuView) {
        _sexInpuView = [[InputView alloc] initWithFrame:CGRectMake(20, CGRectYH(self.famfarName)+GapOfView*3+InputView_height*2, 50, InputView_height) Length:50 withData:@[@"男",@"女"]];
        _sexInpuView.inputLabel.text = @"  男";
        
    }
    return _sexInpuView;
}
-(ClickRoundView *)diXiView{
    if (!_diXiView) {
        _diXiView = [[ClickRoundView alloc] initWithFrame:CGRectMake(CGRectXW(self.sexInpuView)+0.1*Screen_width-20, self.sexInpuView.frame.origin.y, 50, InputView_height) withTitle:@"嫡系" isStar:false];
    }
    return _diXiView;
}
-(ClickRoundView *)famousPerson{
    if (!_famousPerson) {
        _famousPerson = [[ClickRoundView alloc] initWithFrame:CGRectMake(CGRectXW(self.diXiView)+0.1*Screen_width, self.diXiView.frame.origin.y, 60, 40) withTitle:@"家族名人" isStar:YES];
    }
    return _famousPerson;
}

@end
