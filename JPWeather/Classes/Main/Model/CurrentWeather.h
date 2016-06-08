//
//  CurrentWeather.h
//  JPWeather
//
//  Created by Jimmy on 15/11/17.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentWeather : NSObject

/*
城市名
*/
@property (nonatomic, copy) NSString *city;
/*
 城市ID
 */
@property (nonatomic, copy) NSString *cityid;
/*
 温度
 */
@property (nonatomic, copy) NSString *temp;
/*
 风向
 */
@property (nonatomic, copy) NSString *WD;
/*
 风级
 */
@property (nonatomic, copy) NSString *WS;
/*
 湿度
 */
@property (nonatomic, copy) NSString *SD;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *WSE;
@property (nonatomic, copy) NSString *isRadar;
@property (nonatomic, copy) NSString *Radar;
@property (nonatomic, copy) NSString *njd;
@property (nonatomic, copy) NSString *qy;
@property (nonatomic,copy) NSString *rain;
/*
 temp,
 time,
 WD,
 qy,
 isRadar,
 cityid,
 city,
 WS,
 Radar,
 WSE,
 njd,
 SD,
 rain
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
