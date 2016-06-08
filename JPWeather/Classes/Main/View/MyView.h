//
//  MyView.h
//  JPWeather
//
//  Created by Jimmy on 15/11/16.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Weather;
@interface MyView : UIView
@property (weak, nonatomic) IBOutlet UILabel *weekLbl;
@property (weak, nonatomic) IBOutlet UILabel *tempHighLbl;
@property (weak, nonatomic) IBOutlet UILabel *tempLowLbl;
@property (weak, nonatomic) IBOutlet UILabel *weatherlbl;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;

@property (strong, nonatomic) Weather *futureWeather;
- (instancetype)initWithFrame:(CGRect)frame withData:(Weather *)weather;
@end
