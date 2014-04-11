//
//  ResultAnswerPopUpView.m
//  QuizBro
//
//  Created by Christian Danheimer Furedal on 2014-04-09.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "ResultAnswerPopUpView.h"

@interface ResultAnswerPopUpView()

@property (nonatomic) UILabel *textLabel;
@end

@implementation ResultAnswerPopUpView

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
        [self setBackgroundColor:[UIColor greenColor]];
        self.layer.borderColor = [UIColor greenColor].CGColor;
    }
    else{
        [self setText:@"Wrong answer!"];
        [self setBackgroundColor:[UIColor redColor]];
        self.layer.borderColor = [UIColor redColor].CGColor;
    }
}

-(void)setText:(NSString*)text
{
    [self.textLabel setText:text];
}

@end
