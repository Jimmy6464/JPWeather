//
//  Weather.h
//  JPWeather
//
//  Created by Jimmy on 15/11/16.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject
/*
 温度
 */
@property (nonatomic, copy)NSString *temperature;
/*
 温度
 */
@property (nonatomic, copy)NSString *humidity;
/*
 天气
 */
@property (nonatomic, copy)NSString *weather;
/*
 城市名
 */
@property (nonatomic, copy)NSString *citynm;
/*
 星期
 */
@property (nonatomic, copy)NSString *week;
/*
 日期
 */
@property (nonatomic, copy)NSString *days;
/*
 最高温度
 */
@property (nonatomic, copy)NSString *temp_high;
/*
 最低温度
 */
@property (nonatomic, copy)NSString *temp_low;
/*
 风向
 */
@property (nonatomic, copy)NSString *wind;
/*
 风级
 */
@property (nonatomic, copy)NSString *winp;

@property (nonatomic, copy)NSString *weaid;
@property (nonatomic, copy)NSString *weather_icon;
@property (nonatomic, copy)NSString *weather_icon1;
@property (nonatomic, copy)NSString *weatid1;
@property (nonatomic, copy)NSString *weatid;

@property (nonatomic, copy)NSString *winpid;
@property (nonatomic, copy)NSString *windid;

@property (nonatomic, copy)NSString *humi_low;
@property (nonatomic, copy)NSString *humi_high;
@property (nonatomic, copy)NSString *cityid;
@property (nonatomic, copy)NSString *cityno;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
