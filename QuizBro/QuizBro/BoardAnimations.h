//
//  BoardAnimations.h
//  QuizBro
//
//  Created by Boris Kachscovsky on 4/11/14.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoardAnimations : NSObject

+ (void)fadeButton:(UIButton *)button;
+ (void)fadeOut:(UIButton *)button;
+ (void)fadeIn:(UIButton *)button;
+ (void)invertSelection:(UIButton *)button fromColor:(UIColor *)color;
+ (void)deselect:(UIButton *)button;
+ (void)animatePopupwith:(UIView *)popup on:(UIView *)view;


@end
