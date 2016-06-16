//
//  EditPersonalInfoView.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/15.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "EditPersonalInfoView.h"
#import "EditPersonalInfoTableViewCell.h"

@interface EditPersonalInfoView()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
/** 滚动背景图*/
@property (nonatomic, strong) UIImageView *BgIV;
/** 左侧一根线*/
@property (nonatomic, strong) UIView *leftLineView;
/** 左侧第一个圆*/
@property (nonatomic, strong) UIImageView *leftFirstCircle;
/** 左侧第二个圆*/
@property (nonatomic, strong) UIImageView *leftSecondCircle;
/** 账户信息表*/
@property (nonatomic, strong) UITableView *accountInfoTB;
/** 个人信息表*/
@property (nonatomic, strong) UITableView *personalInfoTB;
/** 账户信息标题数组*/
@property (nonatomic, strong) NSArray *accountInfoTitleArr;
/** 账户信息详细数组*/
@property (nonatomic, strong) NSArray *accountInfoDetailArr;
/** 个人信息标题数组*/
@property (nonatomic, strong) NSArray *personalInfoTitleArr;
/** 个人信息详细数组*/
@property (nonatomic, strong) NSArray *personalInfoDetailArr;

@end

@implementation EditPersonalInfoView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.contentSize = CGSizeMake(Screen_width, 656);
        self.bounces = NO;
        [self addSubview:self.BgIV];
        //左侧竖线
        self.leftLineView = [[UIView alloc]initWithFrame:CGRectMake(0.0680*CGRectW(self.BgIV), 30, 1, 610)];
        self.leftLineView.backgroundColor = LH_RGBCOLOR(129, 127, 135);
        [self.BgIV addSubview:self.leftLineView];
        //左侧两个圆
        [self.BgIV addSubview:self.leftFirstCircle];
        [self.BgIV addSubview:self.leftSecondCircle];
        //账户信息 个人信息
        [self initAccountInfoLBAndPersonalInfoLB];
        //账户信息表
        [self initAccountInfoTB];
        //个人信息表
        [self initPersonalInfoTB];
    }
    return self;
}

#pragma mark - lazyLoad
-(UIImageView *)BgIV{
    if (!_BgIV) {
        _BgIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0.91875*Screen_width, self.contentSize.height)];
        _BgIV.image = MImage(@"geran_background_s");
    }
    return _BgIV;
}

-(UIImageView *)leftFirstCircle{
    if (!_leftFirstCircle) {
        _leftFirstCircle = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectX(self.leftLineView)-10, 14.6, 20, 20)];
        _leftFirstCircle.image = MImage(@"geran_red");
    }
    return _leftFirstCircle;
}

-(UIImageView *)leftSecondCircle{
    if (!_leftSecondCircle) {
        _leftSecondCircle = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectX(self.leftLineView)-10, 224, 20, 20)];
        _leftSecondCircle.image = MImage(@"geran_ccc");
    }
    return _leftSecondCircle;
}

-(NSArray *)accountInfoTitleArr{
    if (!_accountInfoTitleArr) {
        _accountInfoTitleArr = @[@"ID:",@"账号:",@"密码:",@"手机:",@"邮箱:"];
    }
    return _accountInfoTitleArr;
}

-(NSArray *)accountInfoDetailArr{
    if (!_accountInfoDetailArr) {
        _accountInfoDetailArr = @[@"001021",@"ay001",@"******",@"158****8888",@"client@tcjp.com"];
    }
    return _accountInfoDetailArr;
}

-(NSArray *)personalInfoTitleArr{
    if (!_personalInfoTitleArr) {
        _personalInfoTitleArr = @[@"姓名:",@"昵称:",@"国籍:",@"地区:",@"性别:",@"生日:",@"证件:",@"证件末6位:",@"职业:",@"学历:",@"爱好:",@"个人签名:",@"经历:"];
    }
    return _personalInfoTitleArr;
}

-(NSArray *)personalInfoDetailArr{
    if (!_personalInfoDetailArr) {
        _personalInfoDetailArr = @[@"陈安一",@"阿一",@"中国",@"安徽怀宁",@"男",@"1999年09月09日09时",@"身份证",@"******",@"律师",@"本科",@"",@"",@""];
    }
    return _personalInfoDetailArr;
}



#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offSetY = scrollView.contentOffset.y;
    if (offSetY > 40) {
        self.leftFirstCircle.image = MImage(@"geran_ccc");
        self.leftSecondCircle.image = MImage(@"geran_red");
    }else{
        self.leftFirstCircle.image = MImage(@"geran_red");
        self.leftSecondCircle.image = MImage(@"geran_ccc");
    }
}

-(void)initAccountInfoLBAndPersonalInfoLB{
    UILabel *accountInfoLB = [[UILabel alloc]initWithFrame:CGRectMake(0.1565*CGRectW(self.BgIV), 15, 0.2789*CGRectW(self.BgIV), 25)];
    accountInfoLB.text = @"账户信息";
    [self.BgIV addSubview:accountInfoLB];
    UILabel *PersonalInfoLB = [[UILabel alloc]initWithFrame:CGRectMake(0.1565*CGRectW(self.BgIV), 220, 0.2789*CGRectW(self.BgIV), 25)];
    PersonalInfoLB.text = @"个人信息";
    [self.BgIV addSubview:PersonalInfoLB];
}

-(void)initAccountInfoTB{
    self.accountInfoTB = [[UITableView alloc]initWithFrame:CGRectMake(0.1327*CGRectW(self.BgIV), 56, 0.8197*CGRectW(self.BgIV), 130)];
    self.accountInfoTB.bounces = NO;
    self.accountInfoTB.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5];
    self.accountInfoTB.layer.borderColor = LH_RGBCOLOR(226, 226, 226).CGColor;
    self.accountInfoTB.layer.borderWidth = 1;
    self.accountInfoTB.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.accountInfoTB.dataSource = self;
    self.accountInfoTB.delegate = self;
    self.accountInfoTB.tag = 1001;
    [self.BgIV addSubview:self.accountInfoTB];
}

-(void)initPersonalInfoTB{
    self.personalInfoTB = [[UITableView alloc]initWithFrame:CGRectMake(0.1327*CGRectW(self.BgIV), 265, 0.8197*CGRectW(self.BgIV), 375)];
    self.personalInfoTB.bounces = NO;
    self.personalInfoTB.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5];
    self.personalInfoTB.layer.borderColor = LH_RGBCOLOR(226, 226, 226).CGColor;
    self.personalInfoTB.layer.borderWidth = 1;
    self.personalInfoTB.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.personalInfoTB.dataSource = self;
    self.personalInfoTB.delegate = self;
    self.personalInfoTB.tag = 1002;
    [self.BgIV addSubview:self.personalInfoTB];

}

#pragma mark - UITableViewDataSource,UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 1001) {
        return 5;
    }
        return 13;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1001) {
        EditPersonalInfoTableViewCell *accountInfoCell = [tableView dequeueReusableCellWithIdentifier:@"accoutInfoCell"];
        if (!accountInfoCell) {
            if (indexPath.row == 0||indexPath.row == 1) {
                accountInfoCell = [[EditPersonalInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"accoutInfoCell" WithCustomStyle:EditPersonalInfoTableViewCellStyleNone];
                
            }else{
                accountInfoCell = [[EditPersonalInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"accoutInfoCell" WithCustomStyle:EditPersonalInfoTableViewCellStyleEdit];
            }
            accountInfoCell.customTitleLB.text = self.accountInfoTitleArr[indexPath.row];
            [self labelWidthToFit:accountInfoCell.customTitleLB andFrame:CGRectMake(8, 0, 100, 26)];
            accountInfoCell.customDetailLB.text = self.accountInfoDetailArr[indexPath.row];
        }
        return accountInfoCell;
    }
    
    EditPersonalInfoTableViewCell *personalInfoCell = [tableView dequeueReusableCellWithIdentifier:@"personalInfoCell"];
        if (!personalInfoCell) {
            switch (indexPath.row) {
                case 0:
                case 1:
                case 7:
                    personalInfoCell = [[EditPersonalInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"personalInfoCell" WithCustomStyle:EditPersonalInfoTableViewCellStyleEdit];
                    break;
                case 2:
                case 3:
                case 4:
                case 5:
                case 6:
                case 8:
                case 9:
                    personalInfoCell = [[EditPersonalInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"personalInfoCell" WithCustomStyle:EditPersonalInfoTableViewCellStyleArrow];
                    break;
                default:
                    personalInfoCell = [[EditPersonalInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"personalInfoCell" WithCustomStyle:EditPersonalInfoTableViewCellStyleNone];
                    break;
            }
            personalInfoCell.customTitleLB.text = self.personalInfoTitleArr[indexPath.row];
            [self labelWidthToFit:personalInfoCell.customTitleLB andFrame:CGRectMake(8, 0, 100, 26)];
            personalInfoCell.customDetailLB.text = self.personalInfoDetailArr[indexPath.row];
            if (indexPath.row == 11) {
                CGRect frame = personalInfoCell.dashLineLB.frame;
                frame.origin.y = 63;
                personalInfoCell.dashLineLB.frame = frame;
            }
        }
    return personalInfoCell;
    
}
    
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1002 && indexPath.row == 10) {
        return 63;
    }
    return 26;
}


//宽度自适应
-(void)labelWidthToFit:(UILabel *)label andFrame:(CGRect)frame{
    label.numberOfLines = 1;//根据最大行数需求来设置
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(400, 26);//labelsize的最大值
    //关键语句
    CGSize expectSize = [label sizeThatFits:maximumLabelSize];
    label.frame = CGRectMake(frame.origin.x,frame.origin.y,expectSize.width, frame.size.height);
    
}



@end
