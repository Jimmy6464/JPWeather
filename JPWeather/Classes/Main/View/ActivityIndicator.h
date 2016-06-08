//
//  ActivityIndicator.h
//  UI12_WedApp
//
//  Created by Jimmy on 15/11/2.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
//构建自定义小菊花
@interface ActivityIndicator : UIView

{
    UIActivityIndicatorView *_activityV;
    UILabel *_textLabel;
}
- (void)showWithText:(NSString *)showText;
- (void)hidden;
@end
