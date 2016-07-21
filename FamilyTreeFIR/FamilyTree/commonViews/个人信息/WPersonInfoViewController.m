//
//  WPersonInfoViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/7/21.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "WPersonInfoViewController.h"
#import "WPersonInfoHeaderView.h"
#import "WphotosView.h"
#import "WAllGenView.h"
@interface WPersonInfoViewController ()
/**头部信息view*/
@property (nonatomic,strong) WPersonInfoHeaderView *headView;
/**个人的所有上传图片*/
@property (nonatomic,strong) WphotosView *photosView;
/**所有家谱*/
@property (nonatomic,strong) WAllGenView *allGenView;


@end

@implementation WPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:MImage(@"gr_bg")];
    [self initData];
    [self initUI];
    
}
#pragma mark *** 初始化数据 ***
-(void)initData{
    
}
#pragma mark *** 初始化界面 ***
-(void)initUI{
    [self.view sd_addSubviews:@[self.headView,self.photosView,self.allGenView]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark *** getters ***
-(WPersonInfoHeaderView *)headView{
    if (!_headView) {
        _headView = [[WPersonInfoHeaderView alloc] initWithFrame:AdaptationFrame(0, 64/AdaptationWidth(), Screen_width/AdaptationWidth(), 270)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        //赋值
        if (self.infoModel.photo && self.infoModel.photo.length!=0) {
            _headView.headImage.imageURL = [NSURL URLWithString:self.infoModel.photo];
        }
        if (self.infoModel.name && self.infoModel.name.length!=0) {
            _headView.nameLabel.text = self.infoModel.name;
        }
        _headView.sexImage.image = [self.infoModel.sex isEqualToString:@"1"]?MImage(@"gr_boy"):MImage(@"gr_girl");
        _headView.timeLabel.text = self.infoModel.hour;
        if (self.infoModel.qm && self.infoModel.qm.length!=0) {
            _headView.signatureLabel.text = self.infoModel.qm;
        }
        if (self.infoModel.ah && self.infoModel.ah.length!=0) {
            _headView.intertsLabel.text = self.infoModel.ah;
        }
    }
    return _headView;
}
-(WphotosView *)photosView{
    if (!_photosView) {
        _photosView = [[WphotosView alloc] initWithFrame:AdaptationFrame(0, CGRectYH(self.headView)/AdaptationWidth(), Screen_width/AdaptationWidth(), 171)];
        _photosView.backgroundColor = LH_RGBCOLOR(224, 224, 224);
    }
    return _photosView;
}
-(WAllGenView *)allGenView{
    if (!_allGenView) {
        _allGenView = [[WAllGenView alloc] initWithFrame:CGRectMake(0, CGRectYH(self.photosView), Screen_width, 316*AdaptationWidth())];
    }
    return _allGenView;
}
@end
