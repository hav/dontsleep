//
//  BoardViewController.h
//  QuizBro
//
//  Created by Boris Kachscovsky on 4/2/14.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "BaseModel.h"
#import "AnswerButton.h"
#import "SkipButton.h"
#import "NextQuestionButton.h"
#import "CheckAnswerButton.h"

@class GameViewController;

@interface BoardViewController : UIViewController <BaseModelProtocol>

@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (weak, nonatomic) IBOutlet AnswerButton *answerAButton;
@property (weak, nonatomic) IBOutlet AnswerButton *answerBButton;
@property (weak, nonatomic) IBOutlet AnswerButton *answerCButton;
@property (weak, nonatomic) IBOutlet AnswerButton *answerDButton;

@property (weak, nonatomic) IBOutlet CheckAnswerButton *checkButton;
@property (weak, nonatomic) IBOutlet SkipButton *skipButton;
@property (weak, nonatomic) IBOutlet NextQuestionButton *nextQuestionButton;

@property (nonatomic, strong) BaseModel *baseModel;

@property (retain, nonatomic) UIButton* chosenAnswer;

/**
 *  Show timeout popup and show a next question button.
 */
- (void)timeOut;

/**
 *  Add a delegate for a Game View Controller.
 *
 *  @param delegateController The Game View Controller.
 */
- (void)addDelegateForModel:(GameViewController *)delegateController;

@end
