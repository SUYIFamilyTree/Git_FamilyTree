//
//  HeadLuckView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/4.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "HeadLuckView.h"
#define LucyFont MFont(14)
#define LucyLabelHeight 25
#define PortraitsSize 0.16*Screen_width
@interface HeadLuckView()


@end
@implementation HeadLuckView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
         [self initDate];
        [self initUI];
        [self initHeadProtriaits];
       
    }
    return self;
}


#pragma mark *** 初始化界面 ***
//多少号星期几

-(void)initDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *dateComs = [[NSDateComponents alloc] init];
    dateComs = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    UILabel *monLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.22*Screen_width, 0.02*Screen_height, 0.3*Screen_width, 30)];
    monLabel.text = [NSString stringWithFormat:@"%ld.%ld      星期%@",[dateComs month] ,[dateComs day],[self changeWithComsdateWeek:[dateComs weekday]]];
    self.todayDate = monLabel;
    [self addSubview:monLabel];
    
    
    
}

//生肖图

-(void)initHeadProtriaits{
 
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectYH(self.todayDate)-20, PortraitsSize, PortraitsSize)];
    headView.layer.cornerRadius = PortraitsSize/2;
    headView.layer.borderWidth = 1.0f;
    headView.layer.borderColor = BorderColor;
    headView.layer.masksToBounds = YES;
//    headView.image = MImage(@"todayYS_touxiang");
//    self.headPortraits = headView;
    [self addSubview:headView];
    UIImageView *imageview = [UIImageView new];
    imageview.image = MImage(@"todayYS_touxiang");
    self.headPortraits = imageview;
    [headView addSubview:self.headPortraits];
    self.headPortraits.sd_layout.leftSpaceToView(headView,PortraitsSize/8).rightSpaceToView(headView,PortraitsSize/8).topSpaceToView(headView,PortraitsSize/4).bottomSpaceToView(headView,0);
    
    //时间范围
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectX(headView), CGRectYH(headView)+10, PortraitsSize, 12)];;
    label.text = @"3.21-4.19";
    label.textAlignment = 1;
    label.font = MFont(10);
    [self addSubview:label];
    
    
    self.headPorTime = label;
  
}

//各种指数
-(void)initUI{
    self.lucyNum = [self creatLabelWithFrameX:CGRectX(self.todayDate) FrameY:CGRectYH(self.todayDate) Height:LucyLabelHeight Title:@"健康指数：" content:@"95%"];
    [self addSubview:self.lucyNum];
    self.chatNum = [self creatLabelWithFrameX:CGRectXW(self.lucyNum)+0.07*Screen_width FrameY:self.lucyNum.frame.origin.y Height:LucyLabelHeight Title:@"商谈指数：" content:@"94%"];
    [self addSubview:self.chatNum];
    self.lucyColor = [self  creatLabelWithFrameX:self.lucyNum.frame.origin.x-LucyFont.pointSize*5 FrameY:CGRectYH(self.lucyNum) Height:LucyLabelHeight Title:@"幸运颜色：" content:@"墨绿色"];
    [self addSubview:self.lucyColor];
    self.lucyNum = [self creatLabelWithFrameX:self.chatNum.frame.origin.x-LucyFont.pointSize*5 FrameY:CGRectYH(self.chatNum) Height:LucyLabelHeight Title:@"幸运数：" content:@"5"];
    [self addSubview:self.lucyNum];
    self.coupleAite = [self creatLabelWithFrameX:CGRectX(self.lucyColor)-LucyFont.pointSize*5 FrameY:CGRectYH(self.lucyColor) Height:LucyLabelHeight Title:@"速配星座：" content:@"处女座"];
    [self addSubview:self.coupleAite];
}
//星期转换
-(NSString *)changeWithComsdateWeek:(NSInteger)week{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    
    NSString *finStr = [formatter stringFromNumber:[NSNumber numberWithInteger:week-1]];
    
    if ([finStr isEqualToString:@"七"]) {
        finStr = @"日";
    }
    
    return finStr;
    
}

-(UILabel *)creatLabelWithFrameX:(CGFloat)frameX FrameY:(CGFloat)frameY Height:(CGFloat)height Title:(NSString *)title content:(NSString *)cont{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(frameX, frameY, title.length*LucyFont.pointSize, height)];
    titleLabel.text = title;
    titleLabel.font = LucyFont;
    
    [self addSubview:titleLabel];
    
    UILabel *contLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectXW(titleLabel), titleLabel.frame.origin.y, cont.length*LucyFont.pointSize, height)];
    
    contLabel.font = LucyFont;
    contLabel.text = cont;
    
    
    
    return contLabel;
}

#pragma mark *** getters ***


@end
