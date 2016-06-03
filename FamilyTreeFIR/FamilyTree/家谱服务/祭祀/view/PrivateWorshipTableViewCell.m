//
//  PrivateWorshipTableViewCell.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "PrivateWorshipTableViewCell.h"


@interface PrivateWorshipTableViewCell()

@end

@implementation PrivateWorshipTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initImageView];
        //添加编辑删除按钮
        [self initEditAndDeleteBtn];
        //添加若干标签
        [self initLBs];
    }
    return self;
}

-(void)initImageView{
    self.cemeterialImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 120, 70)];
    self.cemeterialImageView.image = MImage(@"mcGuanli_mudi");
    [self addSubview:self.cemeterialImageView];
    
    CGRect frame = [self frame];
    frame.size.height = 70+10;
    self.frame = frame;
}

-(void)initEditAndDeleteBtn{
    self.editBtn = [[UIButton alloc]initWithFrame:CGRectMake(Screen_width/6*5, 10, Screen_width/8, 25)];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn setTitleColor:LH_RGBCOLOR(128, 205, 145) forState:UIControlStateNormal];
    self.editBtn.titleLabel.font = MFont(12);
    self.editBtn.layer.borderWidth = 1;
    self.editBtn.layer.borderColor = LH_RGBCOLOR(128, 205, 145).CGColor;
    self.editBtn.layer.cornerRadius = 25/5.0f;
    [self.editBtn addTarget:self action:@selector(clickEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.editBtn.hidden = YES;
    [self addSubview:self.editBtn];
    
    self.deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(Screen_width/6*5, 10+30+5, Screen_width/8, 25)];
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:LH_RGBCOLOR(241, 154, 162) forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = MFont(12);
    self.deleteBtn.layer.borderWidth = 1;
    self.deleteBtn.layer.borderColor = LH_RGBCOLOR(241, 154, 162).CGColor;
    self.deleteBtn.layer.cornerRadius = 25/5.0f;
    [self.deleteBtn addTarget:self action:@selector(clickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.deleteBtn.hidden = YES;
    [self addSubview:self.deleteBtn];
}

-(void)initLBs{
    //祭陵名字
    UILabel *cemeterialNameLB = [[UILabel alloc]init];
    cemeterialNameLB.textAlignment = NSTextAlignmentLeft;
    cemeterialNameLB.text = @"某某某之祭陵";
    cemeterialNameLB.font = MFont(12);
    [self addSubview:cemeterialNameLB];
    cemeterialNameLB.sd_layout.leftSpaceToView(self.cemeterialImageView,8).topSpaceToView(self,8).heightIs(20).widthIs(100);
    
    //园号
    UILabel *cemeterialIDLB = [[UILabel alloc]init];
    cemeterialIDLB.textAlignment = NSTextAlignmentLeft;
    cemeterialIDLB.text = @"园号123456";
    cemeterialIDLB.font = MFont(10);
    [self addSubview:cemeterialIDLB];
    cemeterialIDLB.sd_layout.leftSpaceToView(self.cemeterialImageView,8).topSpaceToView(cemeterialNameLB,2).heightIs(10).widthIs(60);
    //浏览人数
    UILabel *visitorNumberLB = [[UILabel alloc]init];
    visitorNumberLB.textAlignment = NSTextAlignmentLeft;
    visitorNumberLB.font = MFont(10);
    self.visitorNumber = @"58963人浏览";
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.visitorNumber];
    NSRange blueRange = NSMakeRange(0, [[noteStr string] rangeOfString:@"人"].location);
    [noteStr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(19, 154, 219) range:blueRange];
    [visitorNumberLB setAttributedText:noteStr];
    [self addSubview:visitorNumberLB];
    visitorNumberLB.sd_layout.leftSpaceToView(cemeterialIDLB,5).topSpaceToView(cemeterialNameLB,2).heightIs(10).widthIs(80);

    //某某扫墓
    UILabel *cemeterialPeopleLB =[[UILabel alloc]init];
    cemeterialPeopleLB.textAlignment = NSTextAlignmentLeft;
    cemeterialPeopleLB.text = @"某某扫墓";
    cemeterialPeopleLB.font = MFont(10);
    cemeterialPeopleLB.textColor = [UIColor redColor];
    [self addSubview:cemeterialPeopleLB];
    cemeterialPeopleLB.sd_layout.leftSpaceToView(self.cemeterialImageView,8).topSpaceToView(cemeterialIDLB,4).widthIs(40).heightIs(10);
    
    //酒水
    UILabel *drinkLB =[[UILabel alloc]init];
    drinkLB.textAlignment = NSTextAlignmentLeft;
    drinkLB.text = @"酒水";
    drinkLB.font = MFont(10);
    drinkLB.textColor = [UIColor redColor];
    [self addSubview:drinkLB];
    drinkLB.sd_layout.leftSpaceToView(cemeterialPeopleLB,5).topSpaceToView(cemeterialIDLB,4).widthIs(40).heightIs(10);
    
    //时间
    UILabel *timeLB =[[UILabel alloc]init];
    timeLB.textAlignment = NSTextAlignmentLeft;
    timeLB.text = @"2015-5-10 10:11:21";
    timeLB.font = MFont(10);
    timeLB.textColor = [UIColor redColor];
    [self addSubview:timeLB];
    timeLB.sd_layout.leftSpaceToView(self.cemeterialImageView,8).topSpaceToView(cemeterialPeopleLB,4).widthIs(100).heightIs(10);

}

-(void)clickEditBtn:(UIButton *)sender{
    MYLog(@"编辑");
    [self.delegate cemeterialDidEdit:self];
}

-(void)clickDeleteBtn:(UIButton *)sender{
    MYLog(@"删除");
    [self.delegate cemeterialDidDelete:self];
}


@end
