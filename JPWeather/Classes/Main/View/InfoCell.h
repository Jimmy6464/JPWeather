//
//  InfoCell.h
//  JPWeather
//
//  Created by Jimmy on 15/11/16.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentWeather.h"
@protocol ButtonOperation
- (void)refreshWeatherByCityName:(NSString *)name;
- (void)deleteWeatherByCityName:(NSString *)name;

@end
@interface InfoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *updateTime;
@property (weak, nonatomic) IBOutlet UILabel *windLevel;
@property (weak, nonatomic) IBOutlet UILabel *tempereture;
@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (weak, nonatomic) IBOutlet UILabel *tempNum;

@property (weak, nonatomic) id<ButtonOperation> btnDelegate;

//@property (strong, nonatomic) CurrentWeather  *weather;
- (IBAction)deleteAction:(id)sender;
- (IBAction)refreshAction:(id)sender;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath withData:(CurrentWeather *)currentWeather;


@end
