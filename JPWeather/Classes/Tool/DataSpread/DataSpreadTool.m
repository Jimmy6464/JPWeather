//
//  DataSpreadTool.m
//  JPWeather
//
//  Created by Jimmy on 15/11/17.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "DataSpreadTool.h"
#import "Weather.h"
#import "NetWorkTool.h"
#import "UIImage+GIF.h"
#define CurrentPath(name) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",name]]
@implementation DataSpreadTool
- (NSMutableDictionary *)dataforCurrentWeather;
{
    NSMutableDictionary *dict ;
    
    NSString *fileName = @"exitCityCurrentWeather.plist";
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:CurrentPath(fileName)]) {
        dict = [NSMutableDictionary dictionaryWithContentsOfFile:CurrentPath(fileName)];
    }
    return dict;
}
- (NSMutableDictionary *)dataForFutureWeather;
{
    NSMutableDictionary *dict ;
    NSString *fileName = @"exitCityFutureWeather.plist";
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:CurrentPath(fileName)]) {
        dict = [NSMutableDictionary dictionaryWithContentsOfFile:CurrentPath(fileName)];
    }
    return dict;
}
- (NSMutableDictionary *)deleteDataByCityName:(NSString *)name
{
    NSMutableDictionary *dict ;
    NSString *fileName = @"exitCityCurrentWeather.plist";
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:CurrentPath(fileName)]) {
        dict = [NSMutableDictionary dictionaryWithContentsOfFile:CurrentPath(fileName)];
        [dict removeObjectForKey:name];
        [dict removeObjectForKey:[name substringToIndex:2]];
    }
    [dict writeToFile:CurrentPath(fileName) atomically:YES];
    return dict;
}
- (NSMutableDictionary *)deleteFutureDataByCityName:(NSString *)name
{
    NSMutableDictionary *dict ;
    NSString *fileName = @"exitCityFutureWeather.plist";
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:CurrentPath(fileName)]) {
        dict = [NSMutableDictionary dictionaryWithContentsOfFile:CurrentPath(fileName)];
        [dict removeObjectForKey:name];
    }
    [dict writeToFile:CurrentPath(fileName) atomically:YES];
    return dict;
}
- (NSString *)changeWeatherBacugroundByWeather:(Weather *)weather
{

    NSString *icon = [self getIconByDate:weather];
    NSString *dayOrNight = [icon substringWithRange:NSMakeRange(38, 1)];
    NSString *str = [icon substringWithRange:NSMakeRange(40, icon.length-40)];
    int num = [str intValue];
    if (num  == 0 ) {
        if ([dayOrNight isEqualToString:@"n"]) {
            return @"wind";
        }
        return @"clear";
    }else if (num >=1 && num <= 2){
        if ([dayOrNight isEqualToString:@"n"]) {
            return @"overcast";
        }
        return @"partlycloudy";
    }

    if ((num >= 13 && num <= 17) || num >=25) {
        return @"snow";
    }else if (num >= 3 && num <= 12){
        
        if ([dayOrNight isEqualToString:@"n"]) {
            return @"n_rain";
        }
        return @"rain";
    }
    return nil;
}
- (NSString *)getIconByDate:(Weather *)weather
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"HH:MM:ss"];
    NSString *str = [formatter stringFromDate:date];
    if ([str intValue] <= 18) {
        return weather.weather_icon;
    }else{
        return weather.weather_icon1;
    }
    return nil;
}
- (void)addWeatherByCityName:(NSString *)name
{
    [NetWorkTool getCurrentByCityName:name];
    [NetWorkTool getWeatherByCityName:name];
}
- (UIImage *)getIconByWeather:(Weather *)weather
{
    NSString *icon = [self getIconByDate:weather];
    NSString *iconName = [NSString stringWithFormat:@"a_%@",[icon substringWithRange:NSMakeRange(icon.length - 5, 1)]];
    return [UIImage imageNamed:iconName];
}

@end
