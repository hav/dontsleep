//
//  TimeOutPopUpView.m
//  QuizBro
//
//  Created by Christian Danheimer Furedal on 2014-04-09.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "TimeOutPopUpView.h"
#import "GameColors.h"

@interface TimeOutPopUpView()

@property (nonatomic) UIColor* yellow;
@property (nonatomic) UIColor* green;
@property (nonatomic) UILabel *textLabel;

@end

@implementation TimeOutPopUpView

/**
 *  Standard IOS function, used to initialize the view within a given frame
 *
 *  @param frame The bounds of our view
 *
 *  @return Returns an instance of our current class
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setText:@"You are out of time!"];
        [self setBackgroundColor:GameColors.yellow];
        self.layer.borderWidth = 1;
        self.layer.borderColor = GameColors.yellow.CGColor;
        self.layer.cornerRadius = 8;
        [self addSubview:self.textLabel];
    }
    return self;
}

/**
 *  Getter for our text label
 *
 *  @return Returns our text label if it exists, and creates a new one otherwise
 */
- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.frame.size.width - 20, 30)];
    }
    
    return _textLabel;
}

/**
 *  Sets the text for our label
 *
 *  @param text Text which will replace the current text
 */
-(void)setText:(NSString*)text
{
    [self.textLabel setText:text];
}

@end