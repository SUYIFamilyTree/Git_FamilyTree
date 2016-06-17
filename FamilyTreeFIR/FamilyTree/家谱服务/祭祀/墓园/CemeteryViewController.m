//
//  CemeteryViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/13.
//  Copyright © 2016年 王子豪. All rights reserved.
//

enum {
    BTNIntroTag,
    BTNJishiTag,
    BTNMianhuaiTag
};

#import "CemeteryViewController.h"
#import "CemDetailView.h"
#import "CemIntroViewController.h"
#import "CemGoodsShopView.h"
#import "InputCherishView.h"
#define bacheight (Screen_height-self.tabBarController.tabBar.bounds.size.height-64)
@interface CemeteryViewController ()
{
    BOOL _selectedMianhuaiBtn;
}
@property (nonatomic,strong) UIScrollView *scrollView; /*背景滚动图*/

@property (nonatomic,strong) UIImageView *cemImageView; /*背景图*/

@property (nonatomic,strong) CemDetailView *detailView; /*详细墓碑内容*/

@property (nonatomic,strong) CemGoodsShopView *goodsView; /*祭祀商品*/

@property (nonatomic,copy) NSMutableArray *goodsImagesArr; /*买的祭祀商品数组*/


@property (nonatomic,strong) InputCherishView *inputView; /*输入缅怀语*/

@property (nonatomic,strong) NSMutableArray *cherishArr; /*所有缅怀语*/

@property (nonatomic,strong) UIView *allCherishView; /*全部缅怀语的view*/





@end

@implementation CemeteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
}
#pragma mark *** 初始化数据 ***
-(void)initData{
    
}
#pragma mark *** 初始化界面 ***
-(void)initUI{
    [self.view addSubview:self.scrollView];
  
    
    [self.scrollView addSubview:self.cemImageView];
      [self initXiangLu];
    [self.scrollView addSubview:self.detailView];
    
    [self allGoodsdisplay];
    
    [self initRightBtn];
    [self reloadCherishLabels];
    
    
    
}
//香炉
-(void)initXiangLu{
    
    for (int idx = 0; idx<2; idx++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:AdaptationFrame((0.7*bacheight-Screen_width/2)/AdaptationWidth()+50+idx*(350+140), 520, 126, 226)];
        image.image = MImage(@"my_name_xiangLu");
        
        [self.scrollView addSubview:image];
    }
    
}

//所有买了的贡品
-(void)allGoodsdisplay{
    for (int idx = 0; idx<self.goodsImagesArr.count; idx++) {
        UIImageView *godsIma = [[UIImageView alloc] initWithFrame:AdaptationFrame(idx*105, 740, 105, 80)];
        godsIma.image = MImage(self.goodsImagesArr[idx]);
        [self.scrollView addSubview:godsIma];
    }
    
}


//三个btn
-(void)initRightBtn{
    
    NSArray *imageArr = @[@"my_name_nav_1",@"my_name_nav_2",@"my_name_nav_3"];
    
    for (int idx = 0; idx<3; idx++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:AdaptationFrame(Screen_width/AdaptationWidth()-130, 750+idx*130, 114, 114)];
        [btn setImage:MImage(imageArr[idx]) forState:0];
        btn.tag = idx;
        [btn addTarget:self action:@selector(respondsToCemBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}




//缅怀语言 布局

-(void)reloadCherishLabels{
    
    
    [self.scrollView addSubview:self.allCherishView];
    
    for (UIView *view in self.allCherishView.subviews) {
        [view removeFromSuperview];
    }
    
    for (int idx = 0; idx<3; idx++) {
        
        NSInteger randX = (random()%30+180);
        
        UILabel *label = [[UILabel alloc] initWithFrame:AdaptationFrame(randX, 50+85*idx, 300, 35)];
        label.font = WFont(random()%5+20);
        label.textColor = [UIColor random];
        
        label.text = self.cherishArr[idx];
        [label sizeToFit];
        
        [self.allCherishView addSubview:label];
        
    }
    for (int idx = 0; idx<3; idx++) {
        
        NSInteger randX =  random()%30+40;
        UILabel *label = [[UILabel alloc] initWithFrame:AdaptationFrame(randX, 90+82*idx, 300, 35)];
        label.font = WFont(random()%5+20);
        label.textColor = [UIColor random];
        label.text = self.cherishArr[3+idx];
        [label sizeToFit];
        
        [self.allCherishView addSubview:label];
    }
    for (int idx = 0; idx<3; idx++) {
        
        NSInteger randX = (random()%50+380);

        UILabel *label = [[UILabel alloc] initWithFrame:AdaptationFrame(randX, 90+82*idx, 300, 35)];
        label.font = WFont(random()%5+20);
        label.textColor = [UIColor random];
        label.text = self.cherishArr[6+idx];
        [label sizeToFit];
        
        [self.allCherishView addSubview:label];
    }
    
}


#pragma mark *** btnEvents ***

-(void)respondsToCemBtn:(UIButton *)sender{
    switch (sender.tag) {
        case BTNIntroTag:
        {
            CemIntroViewController *cemIntro = [[CemIntroViewController alloc] initWithTitle:@"墓园名称" image:nil];
            [self.navigationController pushViewController:cemIntro animated:YES];
        }
            break;
        case BTNJishiTag:
        {
            [self.view addSubview:self.goodsView];
        }
            break;
        case BTNMianhuaiTag:
        {
            _selectedMianhuaiBtn = !_selectedMianhuaiBtn;
            [self.view addSubview:self.inputView];

            if (_selectedMianhuaiBtn) {
                self.inputView.hidden = false;
            }else{
                self.inputView.hidden = true;
            }
        }
            break;
        default:
            break;
    }
}
//提交btn
-(void)respondsToCommitBtn:(UIButton *)sender{
    [self.cherishArr removeLastObject];
    [self.cherishArr insertObject:self.inputView.textView.text atIndex:0];
    [self reloadCherishLabels];
}
#pragma mark *** getters ***
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, bacheight)];
        _scrollView.contentSize = CGSizeMake(1.4*bacheight, bacheight);
        _scrollView.bounces = false;
        _scrollView.contentOffset = CGPointMake(0.7*bacheight-Screen_width/2, 0);
    }
    return _scrollView;
}

-(UIImageView *)cemImageView{
    if (!_cemImageView) {
        _cemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height)];
        _cemImageView.image = MImage(@"my_name_bg.png");
        _cemImageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _cemImageView;
}

-(CemDetailView *)detailView{
    if (!_detailView) {
        _detailView = [[CemDetailView alloc] initWithFrame:AdaptationFrame((0.7*bacheight-Screen_width/2)/AdaptationWidth()+243, 64/AdaptationWidth()+120, 240, 470)];
    }
    return _detailView;
}
-(CemGoodsShopView *)goodsView{
    if (!_goodsView) {
        _goodsView = [[CemGoodsShopView alloc] initWithFrame:CGRectMake(0, 64, Screen_width,Screen_height-64-self.tabBarController.tabBar.bounds.size.height)];
        
    }
    return _goodsView;
}
-(InputCherishView *)inputView{
    if (!_inputView) {
        _inputView = [[InputCherishView alloc] initWithFrame:AdaptationFrame(170, 955, 375, 162)];
        [_inputView.commitBtn addTarget:self action:@selector(respondsToCommitBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _inputView;
}
-(NSMutableArray *)cherishArr{
    if (!_cherishArr) {
        _cherishArr = [@[@"在天堂快快乐乐，不孤单1",@"在天堂快快乐乐，不孤单2",@"在天堂快快乐乐，不孤单3",@"在天堂快快乐乐，不孤单4",@"在天堂快快乐乐，不孤单5",@"在天堂快快乐乐，不孤单6",@"在天堂快快乐乐，不孤单7",@"在天堂快快乐乐，不孤单8",@"在天堂快快乐乐，不孤单9"] mutableCopy];
        
    }
    return _cherishArr;
}
-(UIView *)allCherishView{
    if (!_allCherishView) {
        _allCherishView = [[UIView alloc] initWithFrame:AdaptationFrame(0.7*bacheight-Screen_width/2/AdaptationWidth()+Screen_width/2/AdaptationWidth(), 0, Screen_width/AdaptationWidth(), 300)];
    }
    return _allCherishView;
}

-(NSMutableArray *)goodsImagesArr{
    if (!_goodsImagesArr) {
        _goodsImagesArr = [@[@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour",@"my_name_flour"] mutableCopy];
        
    }
    return _goodsImagesArr;
}
@end
