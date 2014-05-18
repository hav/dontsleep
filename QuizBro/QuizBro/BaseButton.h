//
//  BaseButton.h
//  QuizBro
//
//  Created by Boris Kachscovsky on 4/15/14.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  Creates a base button to be subclassed by the other buttons
 */
@interface BaseButton : UIButton

/**
 *  Changes the background color of the button
 *
 *  @param color New background color
 */
- (void)changeBackgroundColor:(UIColor *)color;

/**
 *  Fades Button out
 */
- (void)fadeButton;

/**
 *  Fades Button in
 */
- (void)fadeOut;

/**
 *  Fades button in
 */
- (void)fadeIn;

/**
 *  Inverts the selection from a given color
 *
 *  @param color Color the selection is inverted from
 */
- (void)invertSelectionfromColor:(UIColor *)color;

/**
 *  Deselects a selected button
 */
- (void)deselect;

@end
