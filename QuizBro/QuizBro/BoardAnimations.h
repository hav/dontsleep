//
//  BoardAnimations.h
//  QuizBro
//
//  Created by Boris Kachscovsky on 4/11/14.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  A Class containing methods for performing the most commonly used animations in the app.
 */
@interface BoardAnimations : NSObject

/**
 *  Fades a button from alpha 0 to 1.
 *
 *  @param button The button to fade.
 */
+ (void)fadeIn:(UIButton *)button;

/**
 *  Animates a view popping up inside another view.
 *
 *  @param popup The view to animate the popping on.
 *  @param view  The view to pop inside of.
 */
+ (void)animatePopupwith:(UIView *)popup on:(UIView *)view;


@end
