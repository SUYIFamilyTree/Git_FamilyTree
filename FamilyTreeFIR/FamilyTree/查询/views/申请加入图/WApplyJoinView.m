//
//  WApplyJoinView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/7/14.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "WApplyJoinView.h"
@interface WApplyJoinView()
/**填写背景图*/
@property (nonatomic,strong) UIImageView *backImageView;
/**姓名*/
@property (nonatomic,strong) UITextField *nameTF;
/**字辈*/
@property (nonatomic,strong) UITextField *zbTF;
/**代数*/
@property (nonatomic,strong) UITextField *genNumTF;
/**父亲*/
@property (nonatomic,strong) UITextField *fatherTF;

/**父亲生日*/
@property (nonatomic,strong) UITextField *fatherBirthTF;

@end
@implementation WApplyJoinView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backImageView];
        [self initFiveItem];
        [self initApplyAndCancelBtn];
    }
    return self;
}
/** 初始化5个控件 */
-(void)initFiveItem{
    NSArray *titleArr = @[@"姓名：",@"字辈：",@"代数：",@"父亲：",@"父亲生日："];

    [titleArr enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = [[UILabel alloc] initWithFrame:AdaptationFrame(30, 145+idx*75, 195, 50)];
        label.textAlignment = 2;
        label.font = WFont(35);
        label.text = obj;
        [self.backImageView addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectXW(label)+5, CGRectY(label), 351*AdaptationWidth(), 50*AdaptationWidth())];
        textField.font = WFont(35);
        textField.layer.borderColor = BorderColor;
        textField.layer.borderWidth = 1.0f;
        textField.placeholder = @"必填";
        textField.text = @"";
        if (idx==2) {
            textField.placeholder = @"选填";
        }
        [self.backImageView addSubview:textField];
        if (idx == 0) {
            self.nameTF = textField;
        }else if(idx==1){
            self.zbTF = textField;
        }else if(idx==2){
            self.genNumTF = textField;
        }else if(idx==3){
            self.fatherTF = textField;
        }else {
            textField.userInteractionEnabled = false;
            self.fatherBirthTF = textField;
            [self.backImageView addSubview:self.fatherBirthTF];
            UIControl *contro = [[UIControl alloc] initWithFrame:self.fatherBirthTF.frame];
            [contro addTarget:self action:@selector(respondsFatherBirTFTapGues) forControlEvents:UIControlEventTouchUpInside];
            
            [self.backImageView addSubview:contro];

        }
        
        
    }];
    
}
/** 初始化申请和退出按钮 */
-(void)initApplyAndCancelBtn{
    NSArray *title = @[@"申请",@"退出"];
    NSArray *colorArr = @[LH_RGBCOLOR(227, 0, 36),LH_RGBCOLOR(75, 88, 91)];
    
    [title enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [[UIButton alloc] initWithFrame:AdaptationFrame(126+230*idx, 550, 160, 67)];
        [btn setTitle:title[idx] forState:0];
        btn.backgroundColor = colorArr[idx];
        [btn addTarget:self action:@selector(respondsToApplyAndCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.backImageView addSubview:btn];
    }];
}
#pragma mark *** events ***
-(void)respondsFatherBirTFTapGues{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
-(void)respondsToApplyAndCancelBtn:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"申请"]) {
        NSArray *arr = @[self.nameTF.text,
                        self.zbTF.text,
                        self.genNumTF.text,
                        self.fatherTF.text,
                        self.fatherBirthTF.text];
        
        [self joinJPWithDataArr:arr whileComplete:^(BOOL apply) {
            if (apply) {
                [SXLoadingView showAlertHUD:@"已申请，请耐心等待" duration:1.0];
                [self removeFromSuperview];
            }
        }];
        
        
    }else{
        [self removeFromSuperview];
    }
}
#pragma mark *** 网络请求 ***

-(void)joinJPWithDataArr:(NSArray *)dataArr whileComplete:(void (^)(BOOL apply))back{
    
    [TCJPHTTPRequestManager POSTWithParameters:@{@"geid":[WSearchModel shardSearchModel].selectedFamilyID,
                                                 @"name":dataArr[0],
                                                 @"father":dataArr[3],
                                                 @"zb":dataArr[1],
                                                 @"ds":dataArr[2],
                                                 @"sr":dataArr[4]
                                                 } requestID:GetUserId requestcode:kRequestCodeapplyjoingen success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            back(true);
        }
    } failure:^(NSError *error) {
        back(false);
    }];
    
}

#pragma mark *** getters ***
-(UIImageView *)backImageView{
    if (!_backImageView) {
        
        //半黑色透明
        UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.6;
        [self addSubview:backView];
        
        _backImageView = [[UIImageView alloc] initWithFrame:AdaptationFrame(30, 150, 660, 720)];
        _backImageView.image = MImage(@"txxx_bg");
        _backImageView.userInteractionEnabled = true;
        UILabel *label = [[UILabel alloc] initWithFrame:AdaptationFrame(96, 72, 530, 50)];
        label.font = WFont(35);
        label.text = @"请填写相关验证信息：";
        label.textAlignment = 0;
        [_backImageView addSubview:label];
        
    }
    return _backImageView;
}

@end
