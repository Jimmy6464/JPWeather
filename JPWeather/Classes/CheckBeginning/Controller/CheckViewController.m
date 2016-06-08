//
//  CheckViewController.m
//  JPWeather
//
//  Created by Jimmy on 15/11/20.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "CheckViewController.h"
#import "SearchViewController.h"
#import "MainViewController.h"
#import <CoreLocation/CoreLocation.h>

#import "NetWorkTool.h"
@interface CheckViewController ()<CLLocationManagerDelegate>
@property (nonatomic, strong)CLLocationManager *locationManager;

@end

@implementation CheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self authodLocation];
    [_locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)goToMainController
{
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainViewController *main = [board instantiateInitialViewController];
    [UIApplication sharedApplication].keyWindow.rootViewController = main;
}
- (void)authodLocation
{
    _locationManager = [CLLocationManager new];
    _locationManager.delegate =self;
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"服务正常");
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
            [_locationManager requestWhenInUseAuthorization];
        }
        
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    //反地理编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks firstObject];
        NSString * currentPlace = [placemark.addressDictionary[@"City"]substringToIndex:2];
        [NetWorkTool getWeatherByCityName:currentPlace];
        [NetWorkTool getCurrentByCityName:currentPlace];
        [self performSelectorOnMainThread:@selector(goToMainController) withObject:nil waitUntilDone:YES];
    }];
    [_locationManager stopUpdatingLocation];
}
@end
