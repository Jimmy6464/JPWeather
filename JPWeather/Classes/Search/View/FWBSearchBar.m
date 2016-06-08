//
//  FWBSearchBar.m
//  Imate_MicroBlog
//
//  Created by Jimmy on 15/11/2.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "FWBSearchBar.h"

@implementation FWBSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.background = [UIImage resizableWithImageName:@"searchbar_textfield_background"];
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        CGRect rect = CGRectMake(0, 0, imageV.frame.size.width+20, imageV.frame.size.height);
        imageV.frame = rect;
        imageV.contentMode = UIViewContentModeCenter;
        
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = imageV;
    }
    return self;
}

@end
