//
//  ResultAnswerPopUpView.m
//  QuizBro
//
//  Created by Christian Danheimer Furedal on 2014-04-09.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "ResultAnswerPopUpView.h"
#import "GameColors.h"

@interface ResultAnswerPopUpView()
@property (nonatomic) UIColor* yellow;
@property (nonatomic) UIColor* green;
@property (nonatomic) UILabel *textLabel;
@end

@implementation ResultAnswerPopUpView

/**
 *  Initializes the textLabel Attribute
 *
 *  @return returns a new text Label if it has not been intialized, and the current label if it has
 */
- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.frame.size.width - 20, 30)];
    }
    
    return _textLabel;
}

/**
 *  Standard IOS function to init the view in a given frame
 *
 *  @param frame The boundaries of our view
 *
 *  @return it returns the current instance of our ResultAnswerPopUpView
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.textLabel];
        
    }
    return self;
}

/**
 *  Initializes our function with a gien result
 *
 *  @param result YES or NO, depending on the result
 */
-(void)initWithResult:(BOOL)result
{
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 8;
    
    if(result){
        [self setText:@"Correct answer!"];
        [self setBackgroundColor:GameColors.green];
        self.layer.borderColor = GameColors.green.CGColor;
    }
    else{
        [self setText:@"Wrong answer!"];
        [self setBackgroundColor:GameColors.yellow];
        self.layer.borderColor = GameColors.yellow.CGColor;
    }
}

/**
 *  Sets the text to our label
 *
 *  @param text Text to be set on the label
 */
-(void)setText:(NSString*)text
{
    [self.textLabel setText:text];
}

@end
