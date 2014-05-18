//
//  SkipButton.m
//  QuizBro
//
//  Created by Boris Kachscovsky on 4/15/14.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "SkipButton.h"

@implementation SkipButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

/**
 *  Draws the Skip Button
 *
 *  @param rect 
 */
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // Drawing code
    [self changeBackgroundColor:[UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:15.0f/255.0f alpha:1.0f]];
}

@end
