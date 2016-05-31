//
//  WholeWorldViewController.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/31.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "WholeWorldViewController.h"
#import <MapKit/MapKit.h>

#define LeftSetuView_size 15

static NSString *const kReusableIdentifier = @"PinAnnotation";

@interface WholeWorldViewController ()<HeaderSelectViewDelegate,MKMapViewDelegate>
@property (nonatomic,strong) HeaderSelectView *headerView; /*选择视图*/

@property (nonatomic,strong) MKMapView *mapView; /*地图*/

@property (nonatomic,copy) NSArray *dataArr; /*点击坐标显示的文字信息*/



@end

@implementation WholeWorldViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initUI];
    [self initLocation];
    
    
}
//模拟定位
-(void)initLocation{
    
    NSArray *latArr = @[@"40",@"36",@"29",@"10"];
    NSArray *longArr = @[@"107",@"115",@"128",@"90"];
    
    for (int idx = 0; idx<latArr.count; idx++) {
        
        CLLocationCoordinate2D corrdinate = CLLocationCoordinate2DMake([latArr[idx] floatValue],[longArr[idx] floatValue]);
        
        //创建标注数据源
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        
        annotation.coordinate = corrdinate;
        
        annotation.title = @"三张李四张三李四";
        
        
        [self.mapView addAnnotation:annotation];
    }
    
    
}

#pragma mark *** HeaderSelectViewDelegate ***

-(void)HeaderSelecteView:(HeaderSelectView *)headSeView didSelectedBtn:(UIButton *)sender{
    NSLog(@"%@", sender.titleLabel.text);
}

#pragma mark *** 初始化界面 ***
-(void)initUI{
    
    //顶部图
    HeaderSelectView *headView = [[HeaderSelectView alloc] init];
    headView.delegate = self;
    [self.view addSubview:headView];
    self.headerView = headView;
    headView.sd_layout.heightIs(50).rightSpaceToView(self.view,0).topSpaceToView(self.view,64).rightSpaceToView(self.view,0);
    
    //地图
    [self.view addSubview:self.mapView];
    self.mapView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.headerView,0)
    .bottomSpaceToView(self.view,0);
    
    //左下角图
    NSArray *namesArr = @[@"宗室团体",@"家族成员",@"重要地点"];
    NSArray *imageNames = @[@"red_sm",@"yel_sm",@"ci_sm"];
    for (int idx = 0; idx<namesArr.count; idx++) {
        
        UIImageView *theImage = [UIImageView new];
        theImage.image = MImage(imageNames[idx]);
        theImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:theImage];
        //布局
        
        theImage.sd_layout.leftSpaceToView(self.view,20).topSpaceToView(self.view,0.8*Screen_height+idx*(25)).heightIs(LeftSetuView_size).widthIs(LeftSetuView_size);
        
        UILabel *theLabel = [UILabel new];
        theLabel.font = MFont(12);
        theLabel.textAlignment = 0;
        theLabel.text = namesArr[idx];
        [self.view addSubview:theLabel];
        
        theLabel.sd_layout.leftSpaceToView(theImage,5).topEqualToView(theImage).widthIs(60).heightIs(LeftSetuView_size);
    }
}

#pragma mark *** MKMapViewDelegate ***

-(void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error{
    NSLog(@"%@", error.localizedDescription);
    
}

//自定义标注数据原视图

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    //异常处理
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    //表主视图重用机制
    MKAnnotationView *pinAnnotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:kReusableIdentifier];
    if (!pinAnnotationView) {
        pinAnnotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kReusableIdentifier];
    }
    //更新标注数据源
//    pinAnnotationView.annotation = annotation;
    pinAnnotationView.image=[UIImage imageNamed:@"ci"];
    pinAnnotationView.canShowCallout = YES;

    return pinAnnotationView;
}

#pragma mark *** gesEvents ***
-(void)respondsToLongGes:(UILongPressGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        //获取手势在地图上的位置
        CGPoint location = [gesture locationInView:self.mapView];
        //手势换成经纬度
        CLLocationCoordinate2D corrdinate = [self.mapView convertPoint:location toCoordinateFromView:self.mapView];
        
        MYLog(@"%lf--%lf",corrdinate.latitude,corrdinate.longitude);
        
        //创建标注数据源
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        
        annotation.coordinate = corrdinate;
        
       
        annotation.subtitle = @"elpsycongroo";
        
        [self.mapView addAnnotation:annotation];
    }
    
}

#pragma mark *** getters ***

-(MKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MKMapView alloc] init];
        _mapView.mapType = MKMapTypeStandard;
        
        _mapView.delegate = self;
        
        _mapView.showsCompass = YES;
        
        //长按手势添加大头针
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(respondsToLongGes:)];
        [_mapView addGestureRecognizer:longGesture];
        
    }
    return _mapView;
}
@end
