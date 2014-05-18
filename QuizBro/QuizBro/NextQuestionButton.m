//
//  NextQuestionButton.m
//  QuizBro
//
//  Created by Boris Kachscovsky on 4/15/14.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "NextQuestionButton.h"

@implementation NextQuestionButton

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
 *  Draws the next question button
 *
 *  @param rect Rectangle containing the next question button
 */
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // Drawing code
    [self changeBackgroundColor:[UIColor colorWithRed:124.0f/255.0f green:199.0f/255.0f blue:11.0f/255.0f alpha:1.0f]];
}

@end
