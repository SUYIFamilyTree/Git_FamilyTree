//
//  EditPersonalInfoTableViewCell.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/15.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "EditPersonalInfoTableViewCell.h"

@implementation EditPersonalInfoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithCustomStyle:(EditPersonalInfoTableViewCellCustomStyle)EditPersonalInfoTableViewCellCustomStyle{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5];
        //虚线
        self.dashLineLB = [[UILabel alloc]init];
        self.dashLineLB.text = @"---------------------------------------------------------";
        self.dashLineLB.textColor = [UIColor blackColor];
        [self addSubview:self.dashLineLB];
        self.dashLineLB.sd_layout.leftSpaceToView(self,8).bottomSpaceToView(self,0).rightSpaceToView(self,8).heightIs(2);
        //标题
        self.customTitleLB = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, 100, 26)];
        [self addSubview:self.customTitleLB];
        self.customDetailLB = [[UILabel alloc]init];
        [self addSubview:self.customDetailLB];
        self.customDetailLB.sd_layout.leftSpaceToView(self.customTitleLB,5).topSpaceToView(self,0).bottomSpaceToView(self,0).widthIs(200);
        //根据不同样式设置不同按钮
        if (EditPersonalInfoTableViewCellCustomStyle == EditPersonalInfoTableViewCellStyleEdit) {
            self.editBtn = [[UIButton alloc]init];
            [self.editBtn setTitle:@"更改" forState:UIControlStateNormal];
            [self.editBtn setTitleColor:LH_RGBCOLOR(233, 124, 135) forState:UIControlStateNormal];
            self.editBtn.titleLabel.font = MFont(10);
            self.editBtn.layer.borderColor = LH_RGBCOLOR(233, 124, 135).CGColor;
            self.editBtn.layer.borderWidth = 1;
            self.editBtn.layer.cornerRadius = 3.0;
            [self addSubview:self.editBtn];
            self.editBtn.sd_layout.topSpaceToView(self,6).bottomSpaceToView(self,6).rightSpaceToView(self,10).widthIs(35);
        }else if(EditPersonalInfoTableViewCellCustomStyle == EditPersonalInfoTableViewCellStyleArrow){
            self.editBtn = [[UIButton alloc]init];
            [self.editBtn setImage:MImage(@"geren_jiao") forState:UIControlStateNormal];
            [self addSubview:self.editBtn];
            self.editBtn.sd_layout.topSpaceToView(self,6).bottomSpaceToView(self,6).rightSpaceToView(self,10).widthIs(35);
            self.editBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        }
    }
    return self;
}


@end
