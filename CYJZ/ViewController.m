//
//  ViewController.m
//  CYJZ
//
//  Created by jyLiu on 16/8/4.
//  Copyright © 2016年 JY_L. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import "MapLocationViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//颜色RGB
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define THEMAINCOLOR COLOR(0, 189, 246 ,1)
@interface ViewController ()<MAMapViewDelegate,AMapNaviDriveManagerDelegate,AMapNaviDriveViewDelegate>
{
    MAMapView *_mapView;//地图
    AMapNaviDriveManager *_driveManager;//导航
    MAPointAnnotation *_pointAnnotaion;//定位大头针
}
@property (nonatomic, strong) AMapNaviDriveView *navDriveView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mapLocation];
}
#pragma mark -- 设置地图类型
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _mapView.mapType = MAMapTypeStandard;
}
#pragma mark -- 加载地图
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //初始化地图
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    // 追踪用户的location与heading更新
    _mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    _mapView.delegate = self;
    //显示位置
    _mapView.showsUserLocation = NO;
    //显示实时交通
    _mapView.showTraffic = YES;
    //设置不显示比例尺
     _mapView.showsScale = NO;
    //设置显示罗盘
    _mapView.showsCompass = NO;
    //设置定位图层显示模式
    _mapView.userTrackingMode =  MAUserTrackingModeFollowWithHeading;
     //设置地图缩放手势
    [_mapView setZoomLevel:16.1 animated:YES];
    [self.view addSubview:_mapView];
    
    //添加定位大头针
    [self addPointAnnotaion];
}
#pragma mark -- 添加定位大头针
- (void)addPointAnnotaion
{
    //添加定位大头针
    _pointAnnotaion = [[MAPointAnnotation alloc]init];
    //设置经纬度。
    float latfloatString = 104.06667;
    float longloatString = 30.66667;
    _pointAnnotaion.coordinate = CLLocationCoordinate2DMake(latfloatString, longloatString);
    _pointAnnotaion.title = @"成都";
    _pointAnnotaion.subtitle = @"这是成都市的定位";
    //设置地图中心点
    _mapView.centerCoordinate = _pointAnnotaion.coordinate;
    //地图放大级别
    _mapView.zoomLevel = 17;
    [_mapView addAnnotation:_pointAnnotaion];
}


#pragma mark -- 创建导航按钮
- (void)mapLocation{
    UIView *addBtnView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-130, SCREEN_HEIGHT-80, 120, 35)];
    addBtnView.backgroundColor = THEMAINCOLOR;
    addBtnView.layer.cornerRadius = 3;
    [self.view addSubview:addBtnView];
    UIImageView *image =[[UIImageView alloc]init];
    image.frame = CGRectMake(0, 0, 35, 35);
    image.image = [UIImage imageNamed:@"icon_nav"];
    [addBtnView addSubview:image];
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(15, 0, 110, 35);
    [addBtn setTitle:@"开始导航" forState:UIControlStateNormal];
    addBtn.titleLabel.textColor = [UIColor whiteColor];
    [addBtnView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(respondsToMap:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -- 跳转导航页
- (void)respondsToMap:(UIButton*)sender
{
    MapLocationViewController *map = [[MapLocationViewController alloc]init];
    [self.navigationController pushViewController:map animated:YES];
    map.mapLonstr = @"39.91579297";
    map.mapLangStr = @"116.39671326";
}

















@end
