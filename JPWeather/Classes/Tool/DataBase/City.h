//
//  City.h
//  JPWeather
//
//  Created by Jimmy on 15/11/16.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject
@property (nonatomic,copy) NSString *cityName;
@property (nonatomic, copy) NSString *cityId;

+ (NSString *)findCityIdByCityName:(NSString *)cityName;
+ (NSMutableDictionary *)findAllCity;
@end
