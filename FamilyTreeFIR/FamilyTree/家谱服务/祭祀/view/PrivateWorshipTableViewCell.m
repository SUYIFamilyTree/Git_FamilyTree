//
//  PrivateWorshipTableViewCell.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/1.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "PrivateWorshipTableViewCell.h"
#import "CemeterialModel.h"

@interface PrivateWorshipTableViewCell()

@end

@implementation PrivateWorshipTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.editBtn.hidden = !_CellEdit;
//        self.deleteBtn.hidden = !_CellEdit;
        [self initImageView];
        //添加编辑删除按钮
        [self initEditAndDeleteBtn];
    }
    return self;
}

-(void)initImageView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, CGRectW(self)/3, CGRectH(self)*2-10)];
    imageView.image = MImage(@"mcGuanli_mudi");
    [self addSubview:imageView];
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
    //self.editBtn.hidden = !self.CellEdit;
    [self addSubview:self.editBtn];
    
    self.deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(Screen_width/6*5, 15+30+5, Screen_width/8, 25)];
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:LH_RGBCOLOR(241, 154, 162) forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = MFont(12);
    self.deleteBtn.layer.borderWidth = 1;
    self.deleteBtn.layer.borderColor = LH_RGBCOLOR(241, 154, 162).CGColor;
    self.deleteBtn.layer.cornerRadius = 25/5.0f;
    [self.deleteBtn addTarget:self action:@selector(clickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    //self.deleteBtn.hidden = !self.CellEdit;
    [self addSubview:self.deleteBtn];
}

-(void)setEditBtn:(UIButton *)editBtn{
    _editBtn = editBtn;
//    _editBtn.hidden = !_cellEdit;
}

-(void)setDeleteBtn:(UIButton *)deleteBtn{
    _deleteBtn = deleteBtn;
//    _deleteBtn.hidden = !_cellEdit;
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
