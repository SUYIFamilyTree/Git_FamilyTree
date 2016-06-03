//
//  AddMenberView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/3.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "AddMenberView.h"

@interface AddMenberView()

@property (nonatomic,strong) DiscAndNameView *name; /*性名*/
@property (nonatomic,strong) InputView *fatheView; /*父亲*/
@property (nonatomic,strong) InputView *motherView; /*母亲*/

@property (nonatomic,strong) InputView *sexInView; /*性别*/

@property (nonatomic,strong) InputView *idView; /*身份*/

@property (nonatomic,strong) ClickRoundView *famousPerson; /*家族名人*/

@property (nonatomic,strong) InputView *gennerNum; /*第几代*/

@property (nonatomic,strong) InputView *rankingView; /*排行*/


@end
@implementation AddMenberView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAddUI];
        
    }
    return self;
}
-(void)initAddUI{
    
    [self.backView addSubview:self.name];
    
    self.fatheView = [self creatLabelTextWithTitle:@"父亲:" TitleFrame:CGRectMake(20, CGRectYH(self.name)+GapOfView, 50, InputView_height) inputViewLength:60 dataArr:@[@" 爱的",@" 收到",@" 速度"] inputViewLabel:@" 杜正存" FinText:nil withStar:false];
    [self.backView addSubview:self.fatheView];
    
    self.motherView = [self creatLabelTextWithTitle:@"母亲:" TitleFrame:CGRectMake(Screen_width-0.414*Screen_width, CGRectYH(self.name)+GapOfView, 50, InputView_height) inputViewLength:60 dataArr:@[@" 爱的",@" 收到",@" 速度"] inputViewLabel:@" 不详" FinText:nil withStar:YES];
    [self.backView addSubview:self.motherView];
    [self.backView addSubview:self.sexInView];
    
    self.idView = [self creatLabelTextWithTitle:@"身份:" TitleFrame:CGRectMake(CGRectXW(self.sexInView)+0.1*Screen_width, self.sexInView.frame.origin.y, 50, InputView_height) inputViewLength:50 dataArr:@[@"ss",@"ss",@"ss"] inputViewLabel:@" 嫡出" FinText:nil withStar:NO];
    [self.backView addSubview:self.idView];
    [self.backView addSubview:self.famousPerson];
    
    self.gennerNum   = [self creatLabelTextWithTitle:@"家族第几代:" TitleFrame:CGRectMake(20, CGRectYH(self.sexInView)+GapOfView, 0.25*Screen_width, InputView_height) inputViewLength:0.2*Screen_width dataArr:@[@"  第一代",@"  第二代",@"  地三代"] inputViewLabel:@" 第一代" FinText:nil withStar:YES];
    [self.backView addSubview:self.gennerNum];
    
    self.rankingView = [self creatLabelTextWithTitle:@"            排行:" TitleFrame:CGRectMake(20, CGRectYH(self.gennerNum)+GapOfView, 0.25*Screen_width, InputView_height) inputViewLength:0.2*Screen_width dataArr:@[@"  第一代",@"  第二代",@"  地三代"] inputViewLabel:@" 第一代" FinText:nil withStar:YES];
    self.rankingView.inputLabel.textAlignment = 0;
    
    [self.backView addSubview:self.rankingView];

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
        _sexInView = [[InputView alloc] initWithFrame:CGRectMake(20, CGRectYH(self.fatheView)+GapOfView, 50, InputView_height) Length:50 withData:@[@" 男",@" 女"]];
        _sexInView.inputLabel.text = @" 男";
        
    }
    return _sexInView;
}

-(ClickRoundView *)famousPerson{
    if (!_famousPerson) {
        _famousPerson = [[ClickRoundView alloc] initWithFrame:CGRectMake(CGRectXW(self.idView)+0.1*Screen_width, self.idView.frame.origin.y, 50, 40) withTitle:@"家族名人" isStar:YES];
    }
    return _famousPerson;
}


@end
