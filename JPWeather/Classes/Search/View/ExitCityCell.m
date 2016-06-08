//
//  ExitCityCell.m
//  JPWeather
//
//  Created by Jimmy on 15/11/19.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "ExitCityCell.h"
static NSString *identifier = @"reCell";
static UICollectionView *_collectionView = nil;
@implementation ExitCityCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ExitCityCell" owner:nil options:nil] lastObject];
        self.frame = frame;
        _collectionView = nil;
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    for (UIView *view in self.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            CGSize size = [label sizeThatFits:CGSizeMake(200, CGFLOAT_MAX)];
            label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, size.width, size.height);
        }
    }
}
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath
{
//    ExitCityCell *cell = [ExitCityCell new];
    if (_collectionView == nil) {
        _collectionView = collectionView;
        [_collectionView registerClass:[ExitCityCell class] forCellWithReuseIdentifier:identifier];
    }
    return [_collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//    cell = [_collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//    return cell;
}
@end
