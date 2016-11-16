//
//  MapLocationViewController.m
//  JZLY
//
//  Created by jyLiu on 16/9/26.
//  Copyright © 2016年 Hydom. All rights reserved.
//

#import "MapLocationViewController.h"

@interface MapLocationViewController ()<AMapLocationManagerDelegate,AMapNaviDriveManagerDelegate,AMapNaviDriveViewDelegate>

@end

@implementation MapLocationViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self mapLocation];//获取定位信息
    [self initDriveManager];//初始化导航
    [self initDriveView];//导航界面
    [self configDriveNavi];//两者关联
}

#pragma mark -- 获取定位信息
- (void)mapLocation{
    
    self.locationManager = [[AMapLocationManager alloc]init];
    [self.locationManager setDelegate:self];
    //社区期望定位精度 偏差在100米以内
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //调用AMapLocationManager提供的startUpdatingLocation方法开启持续定位。
    [self.locationManager startUpdatingLocation];
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
}
#pragma mark -- 定位成功
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    
    if (location) {
        NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
        //获得定位路线规划
        AMapNaviPoint *startPoint = [AMapNaviPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
        float latfloatString = [self.mapLangStr floatValue];
        float longloatString = [self.mapLonstr floatValue];
        AMapNaviPoint *stopPoint = [AMapNaviPoint locationWithLatitude:latfloatString longitude:longloatString];
        [self.driveManager calculateDriveRouteWithStartPoints:@[startPoint]
                                                    endPoints:@[stopPoint]
                                                    wayPoints:nil
                                              drivingStrategy:AMapNaviDrivingStrategyMultipleDefault];
        [self.locationManager stopUpdatingLocation];
    }
    else
    {
        NSLog(@"定位失败");
    }
    
}

#pragma mark -- 初始化导航
- (void)initDriveManager{
    if (self.driveManager == nil)
    {
        self.driveManager = [[AMapNaviDriveManager alloc] init];
        [self.driveManager setDelegate:self];
    }
}
//导航界面
- (void)initDriveView
{
    if (self.driveView == nil)
    {
        self.driveView = [[AMapNaviDriveView alloc] initWithFrame:self.view.bounds];
        [self.driveView setDelegate:self];
    }
}
//将 AMapNaviDriveView 与 AMapNaviManager 关联起来
- (void)configDriveNavi
{
    [self.driveManager addDataRepresentative:self.driveView];
    [self.view addSubview:self.driveView];
}


//路线规划成功，开启实时导航
- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    [self.driveManager startGPSNavi];
}

- (void)driveViewCloseButtonClicked:(AMapNaviDriveView *)driveView
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
