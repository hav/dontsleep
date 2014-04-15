//
//  ResultAnswerPopUpView.m
//  QuizBro
//
//  Created by Christian Danheimer Furedal on 2014-04-09.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "ResultAnswerPopUpView.h"

@interface ResultAnswerPopUpView()
@property (nonatomic) UIColor* yellow;
@property (nonatomic) UIColor* green;
@property (nonatomic) UILabel *textLabel;
@end

@implementation ResultAnswerPopUpView

- (UIColor*)green
{
    if(!_green)
    {
        _green = [UIColor colorWithRed:124.0f/255.0f green:199.0f/255.0f blue:11.0f/255.0f alpha:1.0f];
    }
    return _green;
}

- (UIColor*)yellow
{
    if(!_yellow)
    {
        _yellow = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:15.0f/255.0f alpha:1.0f];
    }
    return _yellow;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.frame.size.width - 20, 30)];
    }
    
    return _textLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.textLabel];
        
    }
    return self;
}


-(void)initWithResult:(BOOL)result
{
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 8;
    
    if(result){
        [self setText:@"Correct answer!"];
        [self setBackgroundColor:self.green];
        self.layer.borderColor = self.green.CGColor;
    }
    else{
        [self setText:@"Wrong answer!"];
        [self setBackgroundColor:self.yellow];
        self.layer.borderColor = self.yellow.CGColor;
    }
}

-(void)setText:(NSString*)text
{
    [self.textLabel setText:text];
}

@end
