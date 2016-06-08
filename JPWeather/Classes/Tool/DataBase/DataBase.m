//
//  DataBase.m
//  JPWeather
//
//  Created by Jimmy on 15/11/16.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "DataBase.h"
#define DataPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"cityname.sqlite"]
static sqlite3 *dataBase;
@implementation DataBase
+ (sqlite3 *)openDataBase
{
    //避免重复打开
    if (dataBase) {
        return dataBase;
    }
    NSString *sourcePtah = [[NSBundle mainBundle] pathForResource:@"cityname" ofType:@"sqlite"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:DataPath]) {
        NSError *err = nil;
        //如果复制失败打印错误信息
        if (![manager copyItemAtPath:sourcePtah toPath:DataPath error:&err]) {
            NSLog(@"open data base error %@",[err localizedDescription]);
            return nil;
        }
    }
    //打开数据库文件
    sqlite3_open([DataPath UTF8String], &dataBase);
    return dataBase;
}
- (void)closeDataBase
{
    sqlite3_close(dataBase);
}
@end
