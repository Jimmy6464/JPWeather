//
//  InfoCell.m
//  JPWeather
//
//  Created by Jimmy on 15/11/16.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "InfoCell.h"
#import "NetWorkTool.h"
#import "MainViewController.h"
static UICollectionView *_collectionView = nil;
static NSString *reuseIdentifier =@"cellID";
static CurrentWeather *_weather;


@implementation InfoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"InfoCell" owner:nil options:nil] lastObject];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)awakeFromNib {

    
}
- (void)layoutSubviews
{
//    [super layoutSubviews];
    [self initialData];
    [self setUpFrame];
}
- (IBAction)deleteAction:(id)sender {
    [self.btnDelegate deleteWeatherByCityName:_weather.city];
}

- (IBAction)refreshAction:(id)sender {
    [self.btnDelegate refreshWeatherByCityName:_weather.city];
}
//设计cell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath withData:(CurrentWeather *)currentWeather
{
    _weather = currentWeather;

    // 注册UICollectionViewCell
    if (_collectionView == nil) {
        _collectionView = collectionView;
        [collectionView registerClass:[InfoCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    return [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
}
#pragma mark - 初始化数据
- (void)initialData
{
    _cityName.text = _weather.city;
    _tempereture.text = [NSString stringWithFormat:@"湿度：%@",_weather.SD];
    _tempNum.text = [NSString stringWithFormat:@"%@ ℃",_weather.temp];    _updateTime.text = [NSString stringWithFormat:@"%@  发布",_weather.time];
    _windLevel.text = [NSString stringWithFormat:@"%@  %@",_weather.WD,_weather.WS];
    //设置行高
    [self setUpFrame];

}
- (void)setUpFrame
{
    //自适应行高
    for (UIView *view in self.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            label.textColor = [UIColor whiteColor];
            CGSize newSize = [label sizeThatFits:CGSizeMake(view.frame.size.width, MAXFLOAT)];
            view.bounds = CGRectMake(0, 0, newSize.width, newSize.height);

        }
    }
}

@end
