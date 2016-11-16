//
//  MapLocationViewController.h
//  JZLY
//
//  Created by jyLiu on 16/9/26.
//  Copyright © 2016年 Hydom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
@interface MapLocationViewController : UIViewController
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) AMapNaviDriveManager *driveManager;
@property (nonatomic, strong) AMapNaviDriveView *driveView;
@property (nonatomic, strong) NSString *mapLonstr;
@property (nonatomic, strong) NSString *mapLangStr;
@end
