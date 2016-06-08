//
//  Weather.m
//  JPWeather
//
//  Created by Jimmy on 15/11/16.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "Weather.h"

@implementation Weather
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        //kvc
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
