//
//  MyView.m
//  JPWeather
//
//  Created by Jimmy on 15/11/16.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "MyView.h"
#import "Weather.h"
#import "DataSpreadTool.h"
@implementation MyView
- (instancetype)initWithFrame:(CGRect)frame withData:(Weather *)weather
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MyView" owner:nil options:nil] lastObject];
        self.frame = frame;
        _futureWeather = weather;
        
    }
    return self;
}
- (void)layoutSubviews
{
    self.backgroundColor = [UIColor clearColor];
    [self initialData];
    [self setUpFrame];
}
//初始化数据
- (void)initialData
{
    _weekLbl.text = _futureWeather.week;
    _tempHighLbl.text = [NSString stringWithFormat:@"%@ ℃",_futureWeather.temp_high];
    _tempLowLbl.text = [NSString stringWithFormat:@"%@ ℃",_futureWeather.temp_low];
    _weatherlbl.text = _futureWeather.weather;
    
    DataSpreadTool *tool = [DataSpreadTool new];
    _weatherIcon.image = [tool getIconByWeather:_futureWeather];
}
//设置布局
- (void)setUpFrame
{
    //自己适应行高
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            label.textColor = [UIColor blackColor];
            label.numberOfLines = 1;
            CGSize newSize = [label sizeThatFits:CGSizeMake(view.frame.size.width, MAXFLOAT)];
            view.bounds = CGRectMake(0, 0, newSize.width, newSize.height);
       
        }
    }
}
@end
