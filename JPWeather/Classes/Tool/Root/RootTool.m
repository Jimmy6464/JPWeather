//
//  RootTool.m
//  JPWeather
//
//  Created by Jimmy on 15/11/16.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "RootTool.h"
#import "MainViewController.h"
#import "CheckViewController.h"
#define CurrentPath(name) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",name]]
@implementation RootTool

+ (void)chooseControllerWithWindow:(UIWindow *)window
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:CurrentPath(@"exitCityCurrentWeather.plist")]) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MainViewController *main = [board instantiateInitialViewController];
        window.rootViewController = main;
    }else {
        CheckViewController *search = [CheckViewController new];
        window.rootViewController = search;
    }
}
@end
