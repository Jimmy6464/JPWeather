//
//  SearchCell.m
//  JPWeather
//
//  Created by Jimmy on 15/11/18.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"SearchCell" owner:nil options:nil] lastObject];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (void)layoutSubviews
{
    CGSize size = [self.cityLabel sizeThatFits:CGSizeMake(300, CGFLOAT_MAX)];
    self.cityLabel.frame = CGRectMake(self.cityLabel.frame.origin.x, self.cityLabel.frame.origin.y, size.width, size.height);
}
@end
