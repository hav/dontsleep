//
//  BaseButton.m
//  QuizBro
//
//  Created by Boris Kachscovsky on 4/15/14.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)changeBackgroundColor:(UIColor *)color
{
    self.layer.borderColor = color.CGColor;
    self.backgroundColor = color;
    self.layer.backgroundColor = color.CGColor;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
}

- (void)fadeButton
{
    self.alpha = 0.8;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ self.alpha = 1;}
                     completion:nil];
}

- (void)fadeOut
{
    self.alpha = 1;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ self.alpha = 0;}
                     completion:nil];
}

- (void)fadeIn
{
    self.alpha = 0;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ self.alpha = 1;}
                     completion:nil];
}

- (void)invertSelectionfromColor:(UIColor *)color
{
    UIColor *newColor;
    if(self.layer.backgroundColor == color.CGColor)
    {
        newColor = [UIColor whiteColor];
    }
    else
    {
        newColor = color;
    }
    
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.layer.borderColor = color.CGColor;
                         self.backgroundColor = newColor;
                         self.layer.backgroundColor = newColor.CGColor;}
                     completion:nil];
    
}

- (void)deselect
{
    UIColor *newColor = [UIColor whiteColor];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.layer.borderColor = newColor.CGColor;
                         self.backgroundColor = newColor;
                         self.layer.backgroundColor = newColor.CGColor;}
                     completion:nil];
}

@end
