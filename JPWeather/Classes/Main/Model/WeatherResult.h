//
//  WeatherResult.h
//  JPWeather
//
//  Created by Jimmy on 15/11/17.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"
@interface WeatherResult : NSObject
@property (nonatomic, copy)NSString *success;
@property (nonatomic, strong)NSArray *result;
@end
