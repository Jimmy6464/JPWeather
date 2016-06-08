//
//  ProtocolDataSpread.h
//  JPWeather
//
//  Created by Jimmy on 15/11/17.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"
@protocol ProtocolDataSpread <NSObject>
@optional
//获取所拥有的城市未来天气数据
- (NSMutableDictionary *)dataForFutureWeather;
//获取所拥有的城市即时天气数据
- (NSMutableDictionary *)dataforCurrentWeather;
//根据城市名删除即时天气数据
- (NSMutableDictionary *)deleteDataByCityName:(NSString *)name;
//根据城市名删除未来天气数据
- (NSMutableDictionary *)deleteFutureDataByCityName:(NSString *)name;
//根据天气获取天气背景视频
- (NSString *)changeWeatherBacugroundByWeather:(Weather *)weather;
//添加天气
- (void)addWeatherByCityName:(NSString *)name;
//
- (UIImage *)getIconByWeather:(Weather *)weather;
@end
