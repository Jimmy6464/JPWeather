//
//  ExitCityCell.h
//  JPWeather
//
//  Created by Jimmy on 15/11/19.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExitCityCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *cityName;
+ (instancetype)cellWithCollectionView :(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath;
@end
