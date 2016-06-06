//
//  PersonalCenterInfoView.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/4.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "PersonalCenterInfoView.h"

@interface PersonalCenterInfoView()
/** 头像视图*/
@property (nonatomic, strong) UIImageView *headIV;
/** 信息数组*/
@property (nonatomic, strong) NSArray *infoArr;
/** 族谱名*/
@property (nonatomic, strong) NSString *familyTreeStr;
@end

@implementation PersonalCenterInfoView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor whiteColor];
        //头像
        [self initHeadIV];
        //5个信息标签
        self.infoArr = @[@"",@"排\n行\n1",@"字\n辈\n安",@"第\n1\n3\n8\n代",@"陈\n安\n一"];
        [self initFiveLBs];
        //切换家谱
        self.familyTreeStr = @"怀\n宁\n陈\n氏";
        [self initFamilyTreeNameView];
    }
    return self;
}

-(void)initHeadIV{
    self.headIV = [[UIImageView alloc]initWithFrame:CGRectMake(0.0557*Screen_width, 0.2029*CGRectH(self), 0.2424*Screen_width, 0.4*CGRectH(self))];
    self.headIV.image = MImage(@"human_bg_touxiang");
    [self addSubview:self.headIV];
    UIImageView *headHeadIV = [[UIImageView alloc]initWithFrame:CGRectMake(0.2175*CGRectW(self.headIV), CGRectH(self.headIV)/9+2, 0.5278*CGRectH(self.headIV),0.5278*CGRectH(self.headIV))];
    headHeadIV.layer.cornerRadius = 0.5278*CGRectH(self.headIV)/2;
    headHeadIV.image = MImage(@"human_toux");
    [self.headIV addSubview:headHeadIV];
    
}

-(void)initFiveLBs{
    
    for (int i = 0; i < 5; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.3245*Screen_width+(0.0808*Screen_width+2)*i, 0.1013*CGRectH(self), 0.0808*Screen_width, 0.7873*CGRectH(self))];
        imageView.image = MImage(@"human_zhuQian");
        [self addSubview:imageView];
        //准备工作(文本自适应高度)
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = [UIFont systemFontOfSize:16];
        textLabel.text = self.infoArr[i];
        textLabel.numberOfLines = 0;//根据最大行数需求来设置
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maximumLabelSize = CGSizeMake(100, 9999);//labelsize的最大值
        //关键语句
        CGSize expectSize = [textLabel sizeThatFits:maximumLabelSize];
        textLabel.frame = CGRectMake(0, 0.1770*CGRectH(imageView), CGRectW(imageView), expectSize.height);
        [imageView addSubview:textLabel];
    }
}

-(void)initFamilyTreeNameView{
    UIImageView *familyTreeNameIV = [[UIImageView alloc]initWithFrame:CGRectMake(0.7611*CGRectW(self), 0.1013*CGRectH(self), 0.1643*CGRectW(self), 0.7873*CGRectH(self))];
    familyTreeNameIV.image = MImage(@"human_zhuQian_jiaPu");
    [self addSubview:familyTreeNameIV];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectW(familyTreeNameIV)*0.1167, 0.2759*CGRectH(familyTreeNameIV), 0.3083*CGRectW(familyTreeNameIV), 0.4271*CGRectH(familyTreeNameIV))];
    label.text = self.familyTreeStr;
    label.numberOfLines = 0;
    label.font = MFont(14);
    label.textColor = [UIColor whiteColor];
    [familyTreeNameIV addSubview:label];
    
}
@end
