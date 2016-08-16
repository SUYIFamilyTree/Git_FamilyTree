
//
//  FamilyHelpViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/31.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "FamilyHelpViewController.h"
#import "HelpTableTableViewCell.h"
#import "AdgnatioHelpInfoViewController.h"

#define BtnWidth 50
#define GapToleft 15
static NSString *const kReusableCellIdentifier = @"cellIdentifier";
static NSString *const kReuserableUITableViewCell = @"UITableViewCell";






@interface FamilyHelpViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *dataSource; /*数据源*/

//@property (nonatomic,assign) NSInteger selectedBtnNum; /*选择的第几个btn*/



@property (nonatomic,strong) UILabel *myLabel; /*label*/
@property (nonatomic,strong) UITableView *tableView; /*table*/


@end

@implementation FamilyHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    [self getDataWithType:self.type];
}


#pragma mark *** 初始化界面 ***
-(void)initUI{
    
    
    NSArray *topTitles = @[@"赏金寻亲",@"募捐圆梦",@"我提供",@"我需要"];
    NSArray *imageNames = @[@"sj_icon_2",@"sj_icon_3",@"sj_icon_4",@"sj_icon_5"];
    for (int idx = 0; idx<topTitles.count; idx++) {
        
        //按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = idx+111;
        [btn addTarget:self action:@selector(respondsToAllBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:MImage(imageNames[idx]) forState:0];

        [self.view addSubview:btn];
        
        btn.sd_layout.topSpaceToView(self.comNavi,10).leftSpaceToView(self.view,GapToleft+idx*(BtnWidth+(Screen_width-GapToleft*2-topTitles.count*BtnWidth)/(topTitles.count-1))).widthIs(BtnWidth).heightIs(BtnWidth);
        
        //文字
        UILabel *label = [UILabel new];
        label.font = MFont(12);
        label.textAlignment = 1;
        label.text = topTitles[idx];
        [self.view addSubview:label];
        self.myLabel = label;
        
        label.sd_layout.topSpaceToView(btn,5).widthIs(BtnWidth).leftEqualToView(btn).heightIs(15);
    
        
    }
    //滚动图
    NSMutableArray *arr = [@[@"sj_bg",@"sj_icon_1",@"sj_icon_2"] mutableCopy];
    
    ScrollerView *scroView = [[ScrollerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myLabel.frame), Screen_width, 0.3*Screen_height) images:arr];
    [self.view addSubview:scroView];
    
    scroView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.myLabel,10);
    
    //tableView
    [self.view addSubview:self.tableView];
    
    self.tableView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.myLabel,0.3*Screen_height+20).bottomSpaceToView(self.tabBarController.tabBar,0);
    
}

#pragma mark - 请求数据
-(void)getDataWithType:(NSString *)type{
    NSDictionary *logDic = @{@"pagenum":@1,
                             @"pagesize":@999,
                             @"type":type,
                             @"memberid":[NSString stringWithFormat:@"%@",GetUserId],
                             @"geid":@0,
                             @"gemeid":@0,
                             @"istop":@"0"};
    [TCJPHTTPRequestManager POSTWithParameters:logDic requestID:GetUserId requestcode:@"zqhzlist" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        MYLog(@"%@",jsonDic);
        if (succe) {
            
        }
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark *** Events ***
-(void)respondsToAllBtn:(UIButton *)sender{
    MYLog(@"%ld",(long)sender.tag-111);
    switch (sender.tag-111) {
        case 0:
            [self getDataWithType:@"SJXQ"];
            break;
        case 1:
            [self getDataWithType:@"MJYM"];
            break;
        case 2:
            [self getDataWithType:@"WTG"];
            break;
        case 3:
            [self getDataWithType:@"WXY"];
            break;
        default:
            break;
    }
    [self.tableView reloadData];
    
}

#pragma mark *** tableDataSource ***
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中第产品众筹
        HelpTableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableCellIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[HelpTableTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kReusableCellIdentifier];
        }
        
        cell.leftImageView.image = MImage(@"sj_bg");
        
        return cell;
}
    


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.2*Screen_width+10;
   
}

#pragma mark *** tableViewDelegate ***

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AdgnatioHelpInfoViewController *detailVc = [[AdgnatioHelpInfoViewController alloc] initWithTitle:@"宗亲互助" image:nil];
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark *** getters ***
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HelpTableTableViewCell class] forCellReuseIdentifier:kReusableCellIdentifier];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuserableUITableViewCell];
    }
    return _tableView;
}

-(NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[@"怀宁陈氏陈大大80搜眼成功在合肥举行",@"安寝护士呼啸而预估三娘在上海举办虎离成功",@"西安网师办教育修船成功",@"昨天但是大量数据库大力加快速度"];
        
    }
    
    return _dataSource;
}

@end
