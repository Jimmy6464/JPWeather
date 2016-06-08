//
//  SearchViewController.h
//  JPWeather
//
//  Created by Jimmy on 15/11/18.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChangeAndLocatedToTheCell
- (void)changeUIWithName:(NSString *)name;
@end
@interface SearchViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, weak) id<ChangeAndLocatedToTheCell> cellDelegate;
@end
