//
//  UIImage+FWBResizable.m
//  Imate_MicroBlog
//
//  Created by Jimmy on 15/10/30.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "UIImage+FWBResizable.h"

@implementation UIImage (FWBResizable)
+ (instancetype)resizableWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
@end
