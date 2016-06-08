//
//  NetWorkTool.m
//  JPWeather
//
//  Created by Jimmy on 15/11/16.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "NetWorkTool.h"
#import "City.h"
#import "Weather.h"
#import "WeatherResult.h"
#import "CurrentWeather.h"
#define CurrentPath(name) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",name]]
@implementation NetWorkTool
+ (NSMutableDictionary *)getWeatherByCityName:(NSString *)cityName
{

    /*
     NSMutableDictionary *pramas = [NSMutableDictionary new];
     pramas[@"app"] = @"weather.future";
     pramas[@"weaid"] = cityNum;
     pramas[@"appkey"] = @"11415";
     pramas[@"sign"] = @"d30705ed84b4b4f7d46340727d509c78";
     pramas[@"format"] = @"json";
     
     //    __block Weather *wea;
     __block NSMutableDictionary *dict;
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     [manager GET:@"http://api.k780.com:88/" parameters:pramas success:^(AFHTTPRequestOperation *operation, id responseObject) {
     NSDictionary *dic = responseObject;
     NSFileManager *manager = [NSFileManager defaultManager];
     NSString *fileName = @"exitCityFutureWeather.plist";
     
     if ([manager fileExistsAtPath:CurrentPath(fileName)]) {
     dict = [NSMutableDictionary dictionaryWithContentsOfFile:CurrentPath(fileName)];
     [dict setObject:dic forKey:cityName];
     }else{
     dict = [NSMutableDictionary new];
     [dict setObject:dic forKey:cityName];
     }
     NSLog(@"%@",CurrentPath(fileName));
     [dict writeToFile:CurrentPath(fileName) atomically:YES];
     
     
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     NSLog(@"获取失败");
     }];

     */
    NSString *cityNum = [City findCityIdByCityName:cityName];
    if (cityNum == nil) {
        return nil;
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.k780.com:88/?app=weather.future&weaid=%@&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json",cityNum]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    NSString *fileName = @"exitCityFutureWeather.plist";
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSMutableDictionary *dict ;
    if ([manager fileExistsAtPath:CurrentPath(fileName)]) {
        dict = [NSMutableDictionary dictionaryWithContentsOfFile:CurrentPath(fileName)];
        [dict setObject:dic forKey:cityName];
    }else{
        dict = [NSMutableDictionary new];
        [dict setObject:dic forKey:cityName];
    }
    [dict writeToFile:CurrentPath(fileName) atomically:YES];
    return dict;
}
+ (NSMutableDictionary *)getCurrentByCityName:(NSString *)cityName
{

    //获取城市ID
    NSString *cityNum = [City findCityIdByCityName:cityName];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.weather.com.cn/data/sk/%@.html",cityNum]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];

    NSString *fileName = @"exitCityCurrentWeather.plist";
    NSFileManager *manager = [NSFileManager defaultManager];

    NSMutableDictionary *dict ;
    if ([manager fileExistsAtPath:CurrentPath(fileName)]) {
        dict = [NSMutableDictionary dictionaryWithContentsOfFile:CurrentPath(fileName)];
        [dict setObject:dic forKey:cityName];
    }else{
        dict = [NSMutableDictionary new];
        [dict setObject:dic forKey:cityName];
    }
    [dict writeToFile:CurrentPath(fileName) atomically:YES];
    return dict;
}
@end
