//
//  RootTool.h
//  JPWeather
//
//  Created by Jimmy on 15/11/16.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface RootTool : NSObject
@property (nonatomic, strong)CLLocationManager *manager;
+ (void)chooseControllerWithWindow:(UIWindow *)window;
@end
