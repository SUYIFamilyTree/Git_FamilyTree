//
//  PersonalCenterTodayFortuneView.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/6.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "PersonalCenterTodayFortuneView.h"
#import "DrawStarsView.h"


@implementation PersonalCenterTodayFortuneView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5];
        //今日运势
        UILabel *todayFortuneLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,0.4814*CGRectW(self), 0.2047*CGRectH(self))];
        todayFortuneLB.text = @"今日运势";
        todayFortuneLB.textAlignment = NSTextAlignmentCenter;
        todayFortuneLB.font = MFont(14);
        [self addSubview:todayFortuneLB];
        //续时运势
        UIButton *payForFortuneBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(todayFortuneLB), 0.0512*CGRectH(self), 0.3261*CGRectW(self), 0.1085*CGRectW(self))];
        [payForFortuneBtn setTitle:@"续时运势" forState:UIControlStateNormal];
        payForFortuneBtn.backgroundColor = [UIColor redColor];
        payForFortuneBtn.titleLabel.font = MFont(11);
        [payForFortuneBtn addTarget:self action:@selector(payForFortune:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:payForFortuneBtn];
        //线
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0.0311*CGRectW(self), CGRectYH(todayFortuneLB), 0.9378*CGRectW(self), 1)];
        lineView.backgroundColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1];
        [self addSubview:lineView];
        //运势星级
        [self initFortuneStar];
        
        
    }
    return self;
}

-(void)initFortuneStar{
    NSArray *strArr = @[@"综合运势：",@"桃花运：",@"事业运：",@"财富运："];
    NSArray *starNumberArr = @[@3,@3,@4,@2];
    for (int i = 0; i < 4; i++) {
        UILabel *fortuneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0745*CGRectW(self), 0.2515*CGRectH(self)+0.1695*CGRectH(self)*i, 0.3416*CGRectW(self), 0.1695*CGRectH(self))];
        fortuneLabel.font = MFont(12);
        fortuneLabel.backgroundColor = [UIColor redColor];
        fortuneLabel.text = strArr[i];
        fortuneLabel.textAlignment = NSTextAlignmentCenter;
        fortuneLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maximumLabelSize = CGSizeMake(100, 9999);//labelsize的最大值
        CGSize expectSize = [fortuneLabel sizeThatFits:maximumLabelSize];
        fortuneLabel.frame = CGRectMake(0.0745*CGRectW(self), 0.2515*CGRectH(self)+0.1695*CGRectH(self)*i, expectSize.width, 0.1695*CGRectH(self));
        [self addSubview:fortuneLabel];
        
        
    }
}


//点击续时运势
-(void)payForFortune:(UIButton *)sender{
    MYLog(@"点击续时运势");
    [self.delegate clickPayForFortuneBtn];
    
    
}



@end
