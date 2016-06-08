//
//  DataBase.h
//  JPWeather
//
//  Created by Jimmy on 15/11/16.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DataBase : NSObject

//打开数据库
+ (sqlite3 *)openDataBase;
//关闭数据库
- (void)closeDataBase;
@end
