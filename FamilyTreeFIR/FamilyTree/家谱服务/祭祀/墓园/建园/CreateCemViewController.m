
//
//  CreateCemViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/14.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "CreateCemViewController.h"

@interface CreateCemViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *_imagePickerController;
}

@property (nonatomic,strong) UIScrollView *backScroView; /*背景滚动*/

@property (nonatomic,strong) UIButton *addCemBtn; /*添加墓园照片*/


@property (nonatomic,strong) UITextField *cemName; /*墓园名称*/
@property (nonatomic,strong) UITextField *cemMaster; /*墓主人*/
@property (nonatomic,strong) UITextField *cemSaying; /*墓志铭*/
@property (nonatomic,strong) UITextField *cemBirDead; /*生辰忌日*/
@property (nonatomic,strong) UITextField *cemIntro; /*生平简介*/

@end

@implementation CreateCemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
}
#pragma mark *** 初始化数据 ***
-(void)initData{
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
}
#pragma mark *** 初始化界面 ***
-(void)initUI{
    [self.view addSubview:self.backScroView];
    [self addCemImage];
    [self addFiveLabelTextView];
    [self createCemBtn];
    
}

//添加墓园照片
-(void)addCemImage{
    
    UIView *whiteView = [[UIView alloc] initWithFrame:AdaptationFrame(0, 0, Screen_width/AdaptationWidth(), 375)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.backScroView addSubview:whiteView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:AdaptationFrame(269, 70, 178, 178)];
    [btn setImage:MImage(@"xinJianMuYuan_add") forState:0];
    [btn addTarget:self action:@selector(respondsToAddCemImage:) forControlEvents:UIControlEventTouchUpInside];
    self.addCemBtn = btn;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectX(btn), CGRectYH(btn)+20*AdaptationWidth(), btn.bounds.size.width, 40*AdaptationWidth())];
    label.text = @"添加墓园照片";
    label.textAlignment = 1;
    label.font = MFont(28*AdaptationWidth());
    
    [self.backScroView addSubview:btn];
    [self.backScroView addSubview:label];
    
}
//添加5个控件 墓园名称--生平简介
-(void)addFiveLabelTextView{
    UIView *whiteView = [[UIView alloc] initWithFrame:AdaptationFrame(0, 390, Screen_width/AdaptationWidth(), 440)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.backScroView addSubview:whiteView];
    
    self.cemName = [UITextField new];
    self.cemMaster = [UITextField new];
    self.cemSaying = [UITextField new];
    self.cemBirDead = [UITextField new];
    self.cemIntro = [UITextField new];
    NSArray *fieldArr = @[self.cemName,self.cemMaster,self.cemSaying,self.cemBirDead,self.cemIntro];
    NSArray *titleArr = @[@"墓园名称：",@"墓主人：",@"墓志铭：",@"生辰忌日：",@"生平简介："];
    
    [fieldArr enumerateObjectsUsingBlock:^(UITextField *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj = [self createLabelAndTextViewWithFrame:AdaptationFrame(74, 40+idx*75, 130, 50) title:titleArr[idx] toView:whiteView];
        [whiteView addSubview:obj];
    }];
    
}

-(void)createCemBtn{
    //创建btn
    UIButton *createCemBtn = [[UIButton alloc] initWithFrame:AdaptationFrame(25, 854, 675, 90)];
    createCemBtn.backgroundColor = LH_RGBCOLOR(74, 88, 91);
    createCemBtn.layer.cornerRadius = 3;
    [createCemBtn setTitle:@"建园" forState:0];
    [createCemBtn addTarget:self action:@selector(respondsToCreateCemBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backScroView addSubview:createCemBtn];
}
#pragma mark *** events ***
-(void)respondsToCreateCemBtn:(UIButton *)sender{
    MYLog(@"建园");
}
-(void)respondsToAddCemImage:(UIButton *)sender{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        _imagePickerController.mediaTypes = @[mediaTypes[0]];
        _imagePickerController.allowsEditing = YES;
        
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }
}
#pragma mark *** UIImagePickerControllerDelegate ***

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [self.addCemBtn setImage:info[UIImagePickerControllerEditedImage] forState:0];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//创建label+边框textView
-(UITextField *)createLabelAndTextViewWithFrame:(CGRect)frame title:(NSString *)title toView:(UIView *)backView{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = NSTextAlignmentRight;
    label.text = title;
    label.font = MFont(25*AdaptationWidth());
    
    [backView addSubview:label];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectXW(label), frame.origin.y, 350*AdaptationWidth(), 50*AdaptationWidth())];
    textField.layer.borderColor = BorderColor;
    textField.layer.borderWidth = 1.0f;
    
    return textField;
}

-(UIScrollView *)backScroView{
    if (!_backScroView) {
        _backScroView= [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, HeightExceptNaviAndTabbar)];
        _backScroView.backgroundColor = LH_RGBCOLOR(236, 236, 236);
        _backScroView.contentSize = CGSizeMake(Screen_width, 700);
    }
    return _backScroView;
}
@end
