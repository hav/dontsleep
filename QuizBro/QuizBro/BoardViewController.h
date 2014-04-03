//
//  BoardViewController.h
//  QuizBro
//
//  Created by Boris Kachscovsky on 4/2/14.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface BoardViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (weak, nonatomic) IBOutlet UITextField *answerATextView;
@property (weak, nonatomic) IBOutlet UITextField *answerBTextView;
@property (weak, nonatomic) IBOutlet UITextField *answerCTextView;
@property (weak, nonatomic) IBOutlet UITextField *answerDTextView;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;

@property NSInteger* rightAnswers;
@property NSInteger* wrongAnswers;

@property NSString* chosenAnswer;

@end
