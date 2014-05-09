//
//  BaseButton.h
//  QuizBro
//
//  Created by Boris Kachscovsky on 4/15/14.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseButton : UIButton

- (void)changeBackgroundColor:(UIColor *)color;
- (void)fadeButton;
- (void)fadeOut;
- (void)fadeIn;
- (void)invertSelectionfromColor:(UIColor *)color;
- (void)deselect;

@end
