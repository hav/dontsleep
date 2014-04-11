//
//  BoardViewController.m
//  QuizBro
//
//  Created by Boris Kachscovsky on 4/2/14.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "ResultAnswerPopUpView.h"
#import "TimeOutPopUpView.h"
#import "BoardViewController.h"
#import "BoardAnimations.h"
#import "GameViewController.h"
#import "DataManager.h"
#import "CircularTimerView.h"



@interface BoardViewController ()

@property (nonatomic)  NSNumber* rightAnswers;
@property (nonatomic)  NSNumber* wrongAnswers;
@property (nonatomic) UIColor* yellow;
@property (nonatomic) UIColor* green;
@property (nonatomic) CircularTimerView *circularTimer;

@end

@implementation BoardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[DataManager sharedInstance] seedDatabase];
    [[DataManager sharedInstance] managedObjectContext];
    
    self.chosenAnswer = [[UIButton alloc] init];
    
    [self loadNewAnswer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updateUI];
}

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

- (NSNumber*)rightAnswers
{
    if(!_rightAnswers)
    {
        _rightAnswers = 0;
    }
    return _rightAnswers;
}

- (NSNumber*)wrongAnswers
{
    if(!_wrongAnswers)
    {
        _wrongAnswers = 0;
    }
    return _wrongAnswers;
}

- (BaseModel *)baseModel {
    if (!_baseModel) {
        _baseModel = [[BaseModel alloc] init];
    }
    
    return _baseModel;
}

- (void)updateUI
{
    // Set Up Border
    self.view.layer.borderWidth = 1;
    self.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.view.layer.cornerRadius = 8;
    self.view.layer.masksToBounds = YES;

    // Edit Skip Button
    self.skipButton.layer.backgroundColor = self.yellow.CGColor;
    self.skipButton.layer.cornerRadius = 8;
    self.skipButton.layer.masksToBounds = YES;
    
    // Edit Check Answer Button
    self.checkButton.layer.backgroundColor = self.green.CGColor;
    self.checkButton.layer.cornerRadius = 8;
    self.checkButton.layer.masksToBounds = YES;
    
    // Edit Answer A Button
    self.answerAButton.layer.borderWidth = 1;
    self.answerAButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.answerAButton.layer.cornerRadius = 8;
    self.answerAButton.layer.masksToBounds = YES;
    
    // Edit Answer B Button
    self.answerBButton.layer.borderWidth = 1;
    self.answerBButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.answerBButton.layer.cornerRadius = 8;
    self.answerBButton.layer.masksToBounds = YES;
    
    // Edit Answer C Button
    self.answerCButton.layer.borderWidth = 1;
    self.answerCButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.answerCButton.layer.cornerRadius = 8;
    self.answerCButton.layer.masksToBounds = YES;
    
    // Edit Answer D Button
    self.answerDButton.layer.borderWidth = 1;
    self.answerDButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.answerDButton.layer.cornerRadius = 8;
    self.answerDButton.layer.masksToBounds = YES;
    
    // Edit Next Question Button
    self.nextQuestionButton.layer.borderWidth = 1;
    self.nextQuestionButton.layer.borderColor = self.green.CGColor;
    self.nextQuestionButton.layer.backgroundColor = self.green.CGColor;
    self.nextQuestionButton.layer.cornerRadius = 8;
    self.nextQuestionButton.layer.masksToBounds = YES;
    self.nextQuestionButton.alpha = 0;
}

- (void)loadNewAnswer{
    
    [self initTimerWithTime:2];

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
    
    // set question text
    NSMutableAttributedString *atbQuestionText = [[NSMutableAttributedString alloc] initWithString:questionText];
    [atbQuestionText addAttribute:NSFontAttributeName
                            value:[UIFont systemFontOfSize:24.0]
                            range:NSMakeRange(0, questionText.length)];
    [self.questionTextView setAttributedText:atbQuestionText.copy];
    
    // set answers
    [self.answerAButton setTitle:answerA forState:UIControlStateNormal];
    [self.answerBButton setTitle:answerB forState:UIControlStateNormal];
    [self.answerCButton setTitle:answerC forState:UIControlStateNormal];
    [self.answerDButton setTitle:answerD forState:UIControlStateNormal];
    
    
}

- (IBAction)checkAnswer:(id)sender {
    CGSize viewSize = self.view.frame.size;

    ResultAnswerPopUpView *resultAnswerPopUpView = [[ResultAnswerPopUpView alloc] initWithFrame:CGRectMake(20, viewSize.height / 3, viewSize.width - 20, 30)];
    
    if([self.baseModel didSelectAnswer:self.chosenAnswer.titleLabel.text]){
        [resultAnswerPopUpView initWithResult:TRUE];
        self.rightAnswers = [NSNumber numberWithInt:self.rightAnswers.intValue + 1];
        self.rightAnswersText.text = [NSString stringWithFormat:@"%d", (int) self.rightAnswers];
    }
    else{
        [resultAnswerPopUpView initWithResult:FALSE];
        self.wrongAnswers = [NSNumber numberWithInt:self.wrongAnswers.intValue + 1];
        self.wrongAnswersText.text = [NSString stringWithFormat:@"%d", (int) self.wrongAnswers];
    }
    
    [BoardAnimations animatePopupwith:resultAnswerPopUpView on:self.view];
    
    self.checkButton.alpha = 0;
    self.skipButton.alpha = 0;
    [BoardAnimations fadeIn:self.nextQuestionButton];
    [self.circularTimer stop];
}

- (IBAction)nextQuestionPressed:(id)sender {
    self.nextQuestionButton.alpha = 0;
    [BoardAnimations fadeIn:self.checkButton];
    [BoardAnimations fadeIn:self.skipButton];
    [self removeSubviews];
    [self loadNewAnswer];
}

- (IBAction)skipQuestion:(id)sender {
    // Button Animation
    [self.circularTimer stop];
    [BoardAnimations fadeButton:(UIButton*) sender];
    [self loadNewAnswer];
}

- (IBAction)clickOnAnswer:(id)sender {
    if(![sender isEqual:self.chosenAnswer])
        [self deselectAll];
    // Button Animation
    [BoardAnimations invertSelection:(UIButton*) sender fromColor:self.green];
    self.chosenAnswer = (UIButton*) sender;
}

- (void)deselectAll
{
    [BoardAnimations deselect:self.answerAButton];
    [BoardAnimations deselect:self.answerBButton];
    [BoardAnimations deselect:self.answerCButton];
    [BoardAnimations deselect:self.answerDButton];
}

- (void)removeSubviews
{
    // Remove those pesky popups
    for (UIView *subView in self.view.subviews)
    {
        if ([subView isKindOfClass:[TimeOutPopUpView class]] ||
            [subView isKindOfClass:[ResultAnswerPopUpView class]])
        {
            [subView removeFromSuperview];
        }
        else if([subView isKindOfClass:[CircularTimerView class]]){
            [((CircularTimerView *)subView) stop];
            [subView removeFromSuperview];
        }
    }
}

- (void)initTimerWithTime:(int)seconds
{
    // Remove the last view
    for (UIView *subView in self.view.subviews)
    {
        if ([subView isKindOfClass:[CircularTimerView class]])
        {
            [((CircularTimerView *)subView) stop];
            [subView removeFromSuperview];
        }
    }
    
    self.circularTimer = [[CircularTimerView alloc] initWithPosition:CGPointMake(410.0f, 20.0f)
                                                              radius:20
                                                      internalRadius:15];
    
    self.circularTimer.backgroundColor = [UIColor lightGrayColor];
    self.circularTimer.backgroundFadeColor = [UIColor lightGrayColor];
    self.circularTimer.foregroundColor = self.green;
    self.circularTimer.foregroundFadeColor = self.green;
    self.circularTimer.direction = CircularTimerViewDirectionClockwise;
    self.circularTimer.font = [UIFont systemFontOfSize:9];
    
    self.circularTimer.frameBlock = ^(CircularTimerView *circularTimerView){
        circularTimerView.text = [NSString stringWithFormat:@"%d", (int) [circularTimerView runningElapsedTime] + 1];
    };
    
    [self.circularTimer setupCountdown:seconds];
    
    self.circularTimer.startBlock = ^(CircularTimerView *circularTimerView){
    };
    self.circularTimer.endBlock = ^(CircularTimerView *circularTimerView){
        [self timeOut];
    };
    
    
    [self.view addSubview:self.circularTimer];
}

- (void)timeOut
{
    if(![self.circularTimer isRunning]){
        CGSize viewSize = self.view.frame.size;
        TimeOutPopUpView *timeOutPopUpView = [[TimeOutPopUpView alloc]
                                              initWithFrame:
                                              CGRectMake(20, viewSize.height / 3, viewSize.width - 20, 30)];
        [BoardAnimations animatePopupwith:timeOutPopUpView on:self.view];
        self.checkButton.alpha = 0;
        self.skipButton.alpha = 0;
        [BoardAnimations fadeIn:self.nextQuestionButton];
    }
}




@end
