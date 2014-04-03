//
//  BoardViewController.m
//  QuizBro
//
//  Created by Boris Kachscovsky on 4/2/14.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "BoardViewController.h"
#import "GameViewController.h"

@interface BoardViewController ()

@end

@implementation BoardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)loadNewAnswer{
    NSString* question = @"This is my question";
    NSString* answerA = @"Answer A";
    NSString* answerB = @"Answer B";
    NSString* answerC = @"Answer C";
    NSString* answerD = @"Answer D";
    
    self.questionTextView.text = question;
    self.answerATextView.text = answerA;
    self.answerBTextView.text = answerB;
    self.answerCTextView.text = answerC;
    self.answerDTextView.text = answerD;
}

- (IBAction)checkAnswer:(id)sender {
    
    if(TRUE){
        self.rightAnswers++;
    }
    else{
        self.wrongAnswers++;
    }
}
- (IBAction)skipQuestion:(id)sender {
}




@end
