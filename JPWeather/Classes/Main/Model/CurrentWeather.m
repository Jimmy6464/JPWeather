//
//  CurrentWeather.m
//  JPWeather
//
//  Created by Jimmy on 15/11/17.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "CurrentWeather.h"

@implementation CurrentWeather
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
