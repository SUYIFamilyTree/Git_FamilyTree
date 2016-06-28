//
//  FamilyTreeViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/24.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "FamilyTreeViewController.h"
#import "TCJPHTTPRequestManager.h"
#import "NSDictionary+FromNSString.h"
#import "FamilyTreeTopView.h"
#import "SearchFamilyTreeViewController.h"
#import "ImageAndTextViewController.h"
#import "LineageViewController.h"
#import "CreatFamilyTree.h"
#import "ManagerFamilyViewController.h"
@interface FamilyTreeViewController ()<FamilyTreeTopViewDelegate,CreatFamilyTreeDelegate,SelectMyFamilyViewDelegate>
{
    BOOL _selectedCreatBtn;
    BOOL _selectedMyFam;
    
}
@property (nonatomic,strong) UIButton *creatBtn; /*创建家谱Btn*/

@property (nonatomic,strong) CreatFamilyTree *crtFamTree; /*创建家谱view*/

@property (nonatomic,strong) SelectMyFamilyView *selecMyFamView; /*我的家谱点出来的视图*/



@end

@implementation FamilyTreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    self.navigationController.navigationBarHidden = YES;
    [self initNavi];
    //设置背景图
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, Screen_width , Screen_height-64-49)];
    backImageView.image = MImage(@"bg.png");
    [self.view addSubview:backImageView];
    
    //设置5个button
    [self initFiveButton];
    
    //添加左右两个label
    [self initLeftAndRightLabel];
    
    //图在右侧的view
    [self initRView];
    
    //图在左侧的view
    [self initLView];
    
    //创建家谱按钮
    [self.view addSubview:self.creatBtn];
        
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    //更新数据
    [self getFamInfo];
}
#pragma mark - 视图搭建
//设置导航栏
-(void)initNavi{

    FamilyTreeTopView *topView = [[FamilyTreeTopView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, StatusBar_Height+NavigationBar_Height)];
    topView.delegate = self;
    [self.view addSubview:topView];
}

//设置5个button
-(void)initFiveButton{
    CGFloat widthSpace = 10;
    CGFloat btnWidth = (Screen_width - 10*4-30)/5;
    CGFloat btnHeight = 0.2*Screen_height;
    NSArray *btnImageNames = @[@"kuang1",@"kuang4",@"kuang3",@"kuang2",@"kuang5"];
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15+widthSpace*i+btnWidth*i, 10+64, btnWidth, btnHeight)];
        [btn setImage:MImage(btnImageNames[i]) forState:UIControlStateNormal];
        btn.tag = 1000+i+1;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}


//添加左右两个label
-(void)initLeftAndRightLabel{
    CGFloat btnHeight = 0.2*Screen_height;
    //添加左边label
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 64+10+btnHeight+10, Screen_width/2-15, 30)];
    leftLabel.text = @"已入谱人数123456789人";
    leftLabel.textAlignment = NSTextAlignmentLeft;
    leftLabel.font = MFont(12);
    [self.view addSubview:leftLabel];
    //添加右边label
    UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(Screen_width/2, 64+10+btnHeight+10, Screen_width/2-15, 30)];
    rightLabel.text = @"已入谱99辈";
    rightLabel.textAlignment = NSTextAlignmentRight;
    rightLabel.font=MFont(12);
    [self.view addSubview:rightLabel];

    
}

//图在右侧的view
-(void)initRView{
    CGFloat btnHeight = 0.2*Screen_height;
    //view的宽高
    CGFloat viewWidth = Screen_width - 15*2;
    CGFloat viewHeight = (Screen_height-64-10-btnHeight-30-10-10-5-49)/2;
    
    UIView *RView = [[UIView alloc]initWithFrame:CGRectMake(15,64+10+btnHeight+30+10, viewWidth, viewHeight)];
    RView.backgroundColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.7];
    
    [self.view addSubview:RView];
    
    //设置阴影效果
    UIView *shadowView = [[UIView alloc]initWithFrame:CGRectMake(CGRectX(RView)+CGRectW(RView)/3*2+2, CGRectY(RView)+5+2, CGRectW(RView)/3-5-2, CGRectH(RView)-10-2)];
    shadowView.backgroundColor = [UIColor whiteColor];
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    shadowView.layer.shadowOpacity = 0.5;
    shadowView.layer.shadowRadius = 2.0;
    shadowView.layer.shadowOffset = CGSizeMake(0, 2);
    [self.view addSubview:shadowView];
    
    UIImageView *imageViewR = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectX(RView)+CGRectW(RView)/3*2, CGRectY(RView)+5, CGRectW(RView)/3-5, CGRectH(RView)-10)];
    imageViewR.image = MImage(@"human_1.png");
    imageViewR.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageViewR];
    
    UILabel *LTittleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectX(RView)+5, CGRectY(RView), CGRectW(RView)/3*2, 30)];
    LTittleLabel.text = @"错公";
    LTittleLabel.font = MFont(15);
    LTittleLabel.textColor = LH_RGBCOLOR(227, 139, 46);
    [self.view addSubview:LTittleLabel];
    
    //一条线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(CGRectX(LTittleLabel), CGRectY(LTittleLabel)+CGRectH(LTittleLabel), CGRectW(LTittleLabel)-20, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.2;
    [self.view addSubview:lineView];
    
    UILabel *LContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectX(RView)+5, CGRectY(LTittleLabel)+CGRectH(LTittleLabel), CGRectW(RView)/3*2-20, CGRectH(RView)-CGRectH(LTittleLabel)-5)];
    LContentLabel.text = @"晋公第九世孙，亿公之子。约生於公园425年，殁期无考。               应魏文侯招贤纳士，举家自东都(洛阳)而迁魏都(开封)，后任大将军，大司马。魏文侯26年(公元前370年)武侯卒，二子子莹与公中绶争夺皇位。";
    LContentLabel.numberOfLines = 0;
    LContentLabel.font = MFont(13);
    LContentLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:LContentLabel];
}


//图在左侧的view
-(void)initLView{
    CGFloat btnHeight = 0.2*Screen_height;
    CGFloat viewWidth = Screen_width - 15*2;
    CGFloat viewHeight = (Screen_height-64-10-btnHeight-30-10-10-5-49)/2;
    //图在左侧的view
    UIView *LView = [[UIView alloc]initWithFrame:CGRectMake(15,64+10+btnHeight+30+10+viewHeight+10, viewWidth, viewHeight)];
    LView.backgroundColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.7];
    [self.view addSubview:LView];
    
    //设置阴影效果
    UIView *shadowView = [[UIView alloc]initWithFrame:CGRectMake(CGRectX(LView)+5+2, CGRectY(LView)+5+2, CGRectW(LView)/3-2, CGRectH(LView)-10-2)];
    shadowView.backgroundColor = [UIColor whiteColor];
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    shadowView.layer.shadowOpacity = 0.5;
    shadowView.layer.shadowRadius = 2.0;
    shadowView.layer.shadowOffset = CGSizeMake(0, 2);
    [self.view addSubview:shadowView];

    
    UIImageView *imageViewL = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectX(LView)+5, CGRectY(LView)+5, CGRectW(LView)/3, CGRectH(LView)-10)];
    imageViewL.image = MImage(@"human_2.png");
    imageViewL.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageViewL];
    
    UILabel *RTittleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectX(LView)+CGRectW(imageViewL)+5+5, CGRectY(LView), CGRectW(LView)/3*2, 30)];
    RTittleLabel.text = @"晋公";
    RTittleLabel.font = MFont(15);
    RTittleLabel.textColor = LH_RGBCOLOR(227, 139, 46);
    [self.view addSubview:RTittleLabel];
    
    //一条线
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(CGRectX(RTittleLabel), CGRectY(RTittleLabel)+CGRectH(RTittleLabel), CGRectW(RTittleLabel)-20, 1)];
    lineView1.backgroundColor = [UIColor grayColor];
    lineView1.alpha = 0.2;
    [self.view addSubview:lineView1];
    
    UILabel *RContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectX(RTittleLabel), CGRectY(RTittleLabel)+CGRectH(RTittleLabel), CGRectW(LView)/3*2-20, CGRectH(LView)-CGRectH(RTittleLabel)-5)];
    RContentLabel.text = @"晋公第九世孙，亿公之子。约生於公园425年，殁期无考。               应魏文侯招贤纳士，举家自东都(洛阳)而迁魏都(开封)，后任大将军，大司马。魏文侯26年(公元前370年)武侯卒，二子子莹与公中绶争夺皇位。";
    RContentLabel.numberOfLines = 0;
    RContentLabel.font = MFont(13);
    RContentLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:RContentLabel];

}


#pragma mark *** 网络请求 ***

-(void)getFamInfo{
    [SXLoadingView showProgressHUD:@"正在加载"];
    [TCJPHTTPRequestManager POSTWithParameters:@{@"query":@"",@"type":@"MyGen"} requestID:GetUserId requestcode:kRequestCodequerymygen success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSLog(@"？---%@", jsonDic[@"data"]);
            
            NSString *jsonStr = [NSString stringWithFormat:@"%@",jsonDic[@"data"]];
            NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"----%@", arr);
            NSMutableArray *allFamNams = [@[] mutableCopy];
            for (NSDictionary *dic in arr) {
                [allFamNams addObject:dic[@"GeName"]];
            }
            [WSelectMyFamModel sharedWselectMyFamModel].myFamArray = allFamNams;
        }
        [SXLoadingView hideProgressHUD];
    } failure:^(NSError *error) {
        MYLog(@"失败");
    }];
}

#pragma mark - 事件
//给5个button添加点击事件跳转
-(void)clickBtn:(UIButton *)sender{
    //NSLog(@"%ld",sender.tag);
    switch (sender.tag) {
        case 1001:
            //跳转
        {
            NSLog(@"图文影像");
            ImageAndTextViewController *imageTextVC = [[ImageAndTextViewController alloc]init];
            [self.navigationController pushViewController:imageTextVC animated:YES];
            break;
        }
        case 1002:
        {
            //跳转
            NSLog(@"世系图");
            LineageViewController *lineageVC = [[LineageViewController alloc]init];
            [self.navigationController pushViewController:lineageVC animated:YES];
        }
            break;
        case 1003:
            //跳转
            NSLog(@"阅读家谱");
            break;
        case 1004:
        {
            //跳转
            NSLog(@"字辈");
            GennerationViewController *gennerVc = [[GennerationViewController alloc] init];
            [self.navigationController pushViewController:gennerVc animated:YES];
        }
            break;
        case 1005:
        {
            NSLog(@"四海同宗");
            WholeWorldViewController *wholeVc = [[WholeWorldViewController alloc] initWithTitle:@"四海同宗" image:nil];
            [self.navigationController pushViewController:wholeVc animated:YES];
            //跳转
        }
            break;
        default:
            break;
    }
    
}


-(void)respondsToCreatBtn:(UIButton *)sender{
    _selectedCreatBtn = !_selectedCreatBtn;
    if (_selectedCreatBtn) {
        [self.view addSubview:self.crtFamTree];
    }else{
        [_crtFamTree removeFromSuperview];
    }
   
}

#pragma mark - FamilyTreeTopViewDelegate
-(void)TopSearchViewDidTapView:(FamilyTreeTopView *)topSearchView{
    MYLog(@"点击搜索栏");
    SearchFamilyTreeViewController *seachVc = [[SearchFamilyTreeViewController alloc]init];
    [self.navigationController pushViewController:seachVc animated:YES];
    
}
-(void)TopSearchView:(FamilyTreeTopView *)topSearchView didRespondsToMenusBtn:(UIButton *)sender{
    MYLog(@"点击我的家谱");
    
    if (sender.selected) {
        [self.view addSubview:self.selecMyFamView];
    }else{
    
         [self.selecMyFamView removeFromSuperview];
    }
    
    [self.selecMyFamView updateDataSourceAndUI];
}


#pragma mark *** createTreeDelegate ***

-(void)CreateFamilyTree:(CreatFamilyTree *)creatTree didSelectedBtn:(UIButton *)sender{
    
    if (creatTree.type == CreatefamilyTreeTypeThreeBtn) {
        if (sender.tag == 0) {
            CreateFamViewController *creVc = [[CreateFamViewController alloc] initWithTitle:@"创建家谱" image:nil];
            [self.navigationController pushViewController:creVc animated:YES];
        }
        if (sender.tag == 2) {
           ManagerFamilyViewController *manager = [[ManagerFamilyViewController alloc] initWithTitle:@"管理家谱" image:nil];
            [manager.comNavi.rightBtn removeFromSuperview];
            [self.navigationController pushViewController:manager animated:YES];
        }
        if (sender.tag == 1) {
            AddMemberViewController *add = [[AddMemberViewController alloc] initWithTitle:@"添加成员" image:nil];
            [self.navigationController pushViewController:add animated:YES];
        }
    }
    
    MYLog(@"%ld",sender.tag);
}
#pragma mark *** SelectMyFamViewDelegate ***

-(void)SelectMyFamilyViewDelegate:(SelectMyFamilyView *)seleMyFam didSelectItemTitle:(NSString *)title{
    NSLog(@"%@", title);
}
#pragma mark *** getters ***

-(UIButton *)creatBtn{
    if (!_creatBtn) {
        _creatBtn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_width-105*AdaptationWidth(), Screen_height-self.tabBarController.tabBar.bounds.size.height-2*105*AdaptationWidth(), 105*AdaptationWidth(), 105*AdaptationWidth())];
        [_creatBtn setImage:MImage(@"noJP_cj_open") forState:UIControlStateNormal];
        [_creatBtn addTarget:self action:@selector(respondsToCreatBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _creatBtn;
}
-(CreatFamilyTree *)crtFamTree{
    if (!_crtFamTree) {
        _crtFamTree = [[CreatFamilyTree alloc] initWithFrame: AdaptationFrame(62, 495, 517, 373) withType:CreatefamilyTreeTypeThreeBtn];
        _crtFamTree.delegate = self;
        
    }
    return _crtFamTree;
}

-(SelectMyFamilyView *)selecMyFamView{
    if (!_selecMyFamView) {
        _selecMyFamView = [[SelectMyFamilyView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, HeightExceptNaviAndTabbar)];
        _selecMyFamView.delegate = self;
        
        
    }
    [_selecMyFamView.collectionView reloadData];
    return _selecMyFamView;
}

@end
