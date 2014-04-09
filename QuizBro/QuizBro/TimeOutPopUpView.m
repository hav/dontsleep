//
//  TimeOutPopUpView.m
//  QuizBro
//
//  Created by Christian Danheimer Furedal on 2014-04-09.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "TimeOutPopUpView.h"

@interface TimeOutPopUpView()

@property (nonatomic) UILabel *textLabel;
@end

@implementation TimeOutPopUpView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setText:@"You are out of time!"];
        [self setBackgroundColor:[UIColor redColor]];
        [self addSubview:self.textLabel];
    }
    return self;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.frame.size.width - 20, 30)];
    }
    
    return _textLabel;
}


-(void)setText:(NSString*)text
{
    [self.textLabel setText:text];
}

@end