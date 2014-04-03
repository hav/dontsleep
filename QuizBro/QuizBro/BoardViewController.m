//
//  BoardViewController.m
//  QuizBro
//
//  Created by Boris Kachscovsky on 4/2/14.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "BoardViewController.h"
#import "GameViewController.h"
#import "DataManager.h"



@interface BoardViewController ()


@end

@implementation BoardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[DataManager sharedInstance] seedDatabase];
    [[DataManager sharedInstance] managedObjectContext];
    
    self.chosenAnswer = [[UITextField alloc] init];
    
    self.wrongAnswers = 0;
    self.rightAnswers = 0;
    
    [self loadNewAnswer];
}

- (BaseModel *)baseModel {
    if (!_baseModel) {
        _baseModel = [[BaseModel alloc] init];
    }
    
    return _baseModel;
}

- (void)loadNewAnswer{

    self.answerAButton.backgroundColor = [UIColor whiteColor];
    self.answerBButton.backgroundColor = [UIColor whiteColor];
    self.answerCButton.backgroundColor = [UIColor whiteColor];
    self.answerDButton.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *question = [self.baseModel randomQuestionAndAnswers];
    
    
    NSString* questionText = [question objectForKey:@"Question"];
    NSString* answerA = [question objectForKey:@"Answer_1"];
    NSString* answerB = [question objectForKey:@"Answer_2"];
    NSString* answerC = [question objectForKey:@"Answer_3"];
    NSString* answerD = [question objectForKey:@"Answer_4"];
    
    self.questionTextView.text = questionText;
    self.answerAButton.titleLabel.text = answerA;
    self.answerBButton.titleLabel.text = answerB;
    self.answerCButton.titleLabel.text = answerC;
    self.answerDButton.titleLabel.text = answerD;
}

- (IBAction)checkAnswer:(id)sender {
    if(self.chosenAnswer != nil && [self.baseModel didSelectAnswer:self.chosenAnswer.titleLabel.text]){
        self.rightAnswers++;
        self.rightAnswersText.text = [NSString stringWithFormat:@"%d", (int) self.rightAnswers];
    }
    else{
        self.wrongAnswers++;
        self.wrongAnswersText.text = [NSString stringWithFormat:@"%d", (int) self.wrongAnswers];
    }
    
    [self loadNewAnswer];
}
- (IBAction)skipQuestion:(id)sender {
    [self loadNewAnswer];
}

- (IBAction)clickOnAnswer:(id)sender {
    self.chosenAnswer = (UIButton*) sender;
    self.chosenAnswer.backgroundColor = [UIColor greenColor];
}



@end
