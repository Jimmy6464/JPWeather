//
//  NetWorkTool.h
//  JPWeather
//
//  Created by Jimmy on 15/11/16.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MJExtension.h"

@interface NetWorkTool : NSObject
+ (NSMutableDictionary *)getWeatherByCityName:(NSString *)cityName;
+ (NSMutableDictionary *)getCurrentByCityName:(NSString *)cityName;
@end
