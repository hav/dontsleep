//
//  BoardAnimations.m
//  QuizBro
//
//  Created by Boris Kachscovsky on 4/11/14.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "BoardAnimations.h"
#import "BoardViewController.h"

@interface BoardAnimations()

@end

@implementation BoardAnimations


+ (void)fadeButton:(UIButton *)button
{
    button.alpha = 0.8;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ button.alpha = 1;}
                     completion:nil];
}

+ (void)fadeOut:(UIButton *)button
{
    button.alpha = 1;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ button.alpha = 0;}
                     completion:nil];
}

+ (void)fadeIn:(UIButton *)button
{
    button.alpha = 0;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ button.alpha = 1;}
                     completion:nil];
}

+ (void)invertSelection:(UIButton *)button fromColor:(UIColor *)color
{
    UIColor *newColor;
    if(button.layer.backgroundColor == color.CGColor)
    {
        newColor = [UIColor whiteColor];
    }
    else
    {
        newColor = color;
    }
    
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         button.backgroundColor = newColor;
                         button.layer.backgroundColor = newColor.CGColor;}
                     completion:nil];
    
}

+ (void)deselect:(UIButton *)button
{
    UIColor *newColor = [UIColor whiteColor];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         button.backgroundColor = newColor;
                         button.layer.backgroundColor = newColor.CGColor;}
                     completion:nil];
}

+ (void)animatePopupwith:(UIView *)popup on:(UIView *)view
{
    CGSize viewSize = view.frame.size;
    int startyPosition = popup.frame.origin.x;
    int endyPosition = viewSize.height / 2;
    
    popup.alpha = 0;
    
    // Animate & Jump
    CGFloat offset = .05*(endyPosition - startyPosition);
    
    [UIView animateWithDuration:.3 animations:^{
        CGRect frame = popup.frame;
        frame.origin.y = endyPosition + offset;
        popup.frame = frame;
        popup.alpha = 0.3;
    } completion:^(BOOL finished){
        [UIView animateWithDuration:.1 animations:^{
            CGRect frame = popup.frame;
            frame.origin.y = endyPosition;
            popup.frame = frame;
            popup.alpha = 1;
        }];
    }];
    
    [view addSubview:popup];
}

@end
