//
//  ActivityIndicator.m
//  UI12_WedApp
//
//  Created by Jimmy on 15/11/2.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "ActivityIndicator.h"

@implementation ActivityIndicator

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //背景View 为了防止用户误操作
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.alpha = 0.5;
        [self addSubview:backgroundView];
        //菊花(考究：默认宽高多少)
        _activityV = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
        _activityV.center = CGPointMake(50, 40);
//        [_activityV startAnimating];
        
        //
        UIView *loadingView = [[UIView alloc]initWithFrame:CGRectMake(170, 350, 100, 100)];
        loadingView.layer.cornerRadius = 10;
        loadingView.backgroundColor = [UIColor blackColor];
        loadingView.center = backgroundView.center;
        [self addSubview:loadingView];
        
        [loadingView addSubview:_activityV];
        
        //label
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 65, 80, 30)];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [loadingView addSubview:_textLabel];
    }
    [self hidden];
    return self;
}
- (void)showWithText:(NSString *)showText
{
    if (self.alpha == 0 ) {
        self.alpha = 1;
        _textLabel.text  = showText;
        [_activityV startAnimating];
        //状态栏上的菊花图
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    
}
- (void)hidden
{
    self.alpha = 0;
    _textLabel.text = nil;
    [_activityV stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
@end
