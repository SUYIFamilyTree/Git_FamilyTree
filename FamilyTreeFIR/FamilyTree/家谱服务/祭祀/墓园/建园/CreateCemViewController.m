
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
    MYLog(@"%ld",self.CeId);
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
    if (self.creatOrEditStr) {
        label.text = @"添加墓园照片";
    }else{
        label.text = @"修改墓园照片";
    }
    
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
    
    NSArray *titleArr = @[@"墓园名称：",@"墓主人：",@"墓志铭：",@"生辰忌日：",@"生平简介："];
    
    self.cemName = [self createLabelAndTextViewWithFrame:AdaptationFrame(74, 40, 130, 50) title:titleArr[0] toView:whiteView];
  
    self.cemMaster = [self createLabelAndTextViewWithFrame:AdaptationFrame(74, 40+1*75, 130, 50) title:titleArr[1] toView:whiteView];
    self.cemSaying = [self createLabelAndTextViewWithFrame:AdaptationFrame(74, 40+2*75, 130, 50) title:titleArr[2] toView:whiteView];
    self.cemBirDead = [self createLabelAndTextViewWithFrame:AdaptationFrame(74, 40+3*75, 130, 50) title:titleArr[3] toView:whiteView];
    self.cemIntro = [self createLabelAndTextViewWithFrame:AdaptationFrame(74, 40+4*75, 130, 50) title:titleArr[4] toView:whiteView];
    
    
    
}

-(void)createCemBtn{
    //创建btn
    UIButton *createCemBtn = [[UIButton alloc] initWithFrame:AdaptationFrame(25, 854, 675, 90)];
    createCemBtn.backgroundColor = LH_RGBCOLOR(74, 88, 91);
    createCemBtn.layer.cornerRadius = 3;
    if (self.creatOrEditStr) {
        [createCemBtn setTitle:@"建园" forState:0];
    }else{
        [createCemBtn setTitle:@"确认修改" forState:0];
    }
    [createCemBtn addTarget:self action:@selector(respondsToCreateCemBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backScroView addSubview:createCemBtn];
}
#pragma mark *** events ***
-(void)respondsToCreateCemBtn:(UIButton *)sender{
    MYLog(@"建园");
    NSLog(@"%@",_cemName.text);
    if (self.creatOrEditStr) {
        NSDictionary *dic = @{@"CeName":self.cemName.text,
                              @"CeMaster":self.cemMaster.text,
                              @"CeEpitaph":self.cemSaying.text,
                              @"CeDeathday":self.cemBirDead.text,
                              @"CeBrief":self.cemIntro.text,
                              @"CeType":@"PRI",
                              @"CeMeid":GetUserId
                              };
        [TCJPHTTPRequestManager POSTWithParameters:dic requestID:GetUserId requestcode:kRequestCodecreatecemetery success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                NSDictionary *dic = [NSDictionary DicWithString:jsonDic[@"data"]];
                MYLog(@"%@", dic[@"CeId"]);
                [self uploadWorshipImageWithID:[dic[@"CeId"] intValue]];
                [SXLoadingView showAlertHUD:@"创建成功" duration:0.5];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            MYLog(@"失败");
        }];
        
    }
    
    else{
        //修改墓园信息
        NSDictionary *dic = @{@"CeName":self.cemName.text,
                              @"CeMaster":self.cemMaster.text,
                              @"CeEpitaph":self.cemSaying.text,
                              @"CeDeathday":self.cemBirDead.text,
                              @"CeBrief":self.cemIntro.text,
                              @"CeId":@(self.CeId)
                              };
        [TCJPHTTPRequestManager POSTWithParameters:dic requestID:GetUserId requestcode:kRequestCodeEditCemetery success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                
                [self uploadWorshipImageWithID:self.CeId];
                [SXLoadingView showAlertHUD:@"修改成功" duration:0.5];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            MYLog(@"失败");
        }];

        
        
    }
    
}

//上传or修改墓园图片
-(void)uploadWorshipImageWithID:(NSInteger)CeId{
    UIImage *cemeteryImage = self.addCemBtn.imageView.image;
    NSData *imageData = UIImageJPEGRepresentation(cemeteryImage, 0.5);
    NSString *encodeimageStr =[imageData base64Encoding];
    NSDictionary *params =@{@"userid":GetUserId,@"imgbt":encodeimageStr,@"uploadtype":@"ZP",@"ceid":@(CeId)};
    [TCJPHTTPRequestManager POSTWithParameters:params requestID:GetUserId requestcode:kRequestCodeUploadCefm success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            
            MYLog(@"墓园图片上传成功%@", jsonDic[@"data"]);
        }
    } failure:^(NSError *error) {
        
    }];
    
    
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
    textField.text = @"";
    [backView addSubview:textField];
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

//关键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
