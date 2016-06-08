//
//  City.m
//  JPWeather
//
//  Created by Jimmy on 15/11/16.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "City.h"
#import "DataBase.h"
@implementation City
+ (NSString *)findCityIdByCityName:(NSString *)cityName
{
    //打开数据库
    sqlite3 *data = [DataBase openDataBase];
    //执行对象
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare(data, "select * from citys where name = ?", -1, &stmt, nil);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [cityName UTF8String], -1, nil);
        City *city = [City new];
        city.cityName = cityName;
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *cityNum =sqlite3_column_text(stmt, 3);
            City *ci = [City new];
            ci.cityId = [NSString stringWithFormat:@"%s",cityNum];
            city = ci;
        }
        sqlite3_finalize(stmt);
        return city.cityId;
    }
    return nil;
}
+ (NSMutableDictionary *)findAllCity
{
    //打开数据库
    sqlite3 *data = [DataBase openDataBase];
    //执行对象
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare(data, "select * from citys ", -1, &stmt, nil);
    if (result == SQLITE_OK) {
        NSMutableDictionary *arr = [NSMutableDictionary new];
        City *city = [City new];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *cityName = sqlite3_column_text(stmt, 2);
            const unsigned char *cityNum =sqlite3_column_text(stmt, 3);
            City *ci = [City new];
            ci.cityId = [NSString stringWithFormat:@"%s",cityNum];
            ci.cityName  = [NSString stringWithUTF8String:(char *)cityName] ;
            [arr setObject:ci.cityId forKey:ci.cityName];
            city = ci;
        }
        sqlite3_finalize(stmt);
        return arr;
    }
    return nil;

}
@end
