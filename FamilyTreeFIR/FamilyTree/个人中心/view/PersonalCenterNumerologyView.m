//
//  PersonalCenterNumerologyView.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/4.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "PersonalCenterNumerologyView.h"
#import "CALayer+drawborder.h"

@interface PersonalCenterNumerologyView()
/** 生辰*/
@property (nonatomic, strong) NSString *birthdateStr;
/** 八字*/
@property (nonatomic, strong) NSString *characterStr;
/** 五行数组*/
@property (nonatomic, strong) NSArray *wuXingArr;
/** 命理说明*/
@property (nonatomic, strong) NSString *numerlogyStr;

@end

@implementation PersonalCenterNumerologyView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //左侧五行图
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 0.4156*CGRectW(self), 0.8114*CGRectH(self))];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = MImage(@"human_wuxingImg");
        [self addSubview:imageView];
        //生辰八字
        self.birthdateStr = @"甲  壬  辛  丁";
        self.characterStr = @"申  酉  亥  庚";
        [self initBirthdateAndCharacter];
        
        //五行和数
        self.wuXingArr = @[@2,@0,@6,@1,@1];
        [self initWuXing];
        
        
        //命理说明
        self.numerlogyStr = @"金命，五行缺水，阳气太旺，阳盛阴衰";
        [self initNumerlogyLB];
    

    }
    return self;
}

-(void)initBirthdateAndCharacter{
    //生辰
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0.525*Screen_width, 24, 0.075*CGRectW(self), 19)];
    label1.text = @"生辰";
    label1.font = MFont(12);
    label1.textColor = LH_RGBCOLOR(139, 139, 139);
    [self addSubview:label1];
    
    UILabel *birthdateLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(label1)+5, 24, 105, 19)];
    birthdateLB.backgroundColor = LH_RGBCOLOR(230, 248, 253);
    birthdateLB.text = self.birthdateStr;
    birthdateLB.textAlignment = NSTextAlignmentCenter;
    birthdateLB.font = MFont(15);
    [self addSubview:birthdateLB];
    
    //八字
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0.525*Screen_width, 43, 0.075*CGRectW(self), 19)];
    label2.text = @"八字";
    label2.font = MFont(12);
    label2.textColor = LH_RGBCOLOR(139, 139, 139);
    [self addSubview:label2];
    
    UILabel *characterLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(label2)+5, 43, 105, 19)];
    characterLB.backgroundColor = LH_RGBCOLOR(254, 240, 223);
    characterLB.text = self.characterStr;
    characterLB.textAlignment = NSTextAlignmentCenter;
    characterLB.font = MFont(15);
    [self addSubview:characterLB];

}

-(void)initWuXing{
    for (int i = 0; i < 5; i++) {
        UIImageView *wuXingIV = [[UIImageView alloc]initWithFrame:CGRectMake(0.5*CGRectW(self)+0.1563*CGRectW(self)*i-0.1563*CGRectW(self)*3*(i/3), 0.4286*CGRectH(self)+(0.0857*CGRectH(self)+5)*(i/3), 0.0781*CGRectW(self), 0.0857*CGRectH(self))];
        wuXingIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"gr_ct_%d",i]];
        wuXingIV.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:wuXingIV];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(wuXingIV)+5,CGRectY(wuXingIV)+2,10,10)];
        label.text = [NSString stringWithFormat:@"%@",self.wuXingArr[i]];
        label.font = MFont(13);
        [self addSubview:label];
    }
}

-(void)initNumerlogyLB{
    UILabel *numerlogyLB = [[UILabel alloc]initWithFrame:CGRectMake(0.5*CGRectW(self), 0.6786*CGRectH(self), 0.4563*CGRectW(self), 0.2*CGRectH(self))];
    numerlogyLB.text = self.numerlogyStr;
    numerlogyLB.numberOfLines = 0;
    numerlogyLB.font = MFont(12);
    [self addSubview:numerlogyLB];
}
@end
