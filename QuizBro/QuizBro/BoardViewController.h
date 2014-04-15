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
#import "answerButton.h"


@interface BoardViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *wrongAnswersText;
@property (weak, nonatomic) IBOutlet UILabel *rightAnswersText;



@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (weak, nonatomic) IBOutlet AnswerButton *answerAButton;
@property (weak, nonatomic) IBOutlet AnswerButton *answerBButton;
@property (weak, nonatomic) IBOutlet AnswerButton *answerCButton;
@property (weak, nonatomic) IBOutlet AnswerButton *answerDButton;

@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;
@property (weak, nonatomic) IBOutlet UIButton *nextQuestionButton;

@property (nonatomic, strong) BaseModel *baseModel;

@property (retain, nonatomic) UIButton* chosenAnswer;

- (void)timeOut;

@end
