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

@property (nonatomic) CircularTimerView *circularTimer;

@end

@implementation BoardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.chosenAnswer = [[UIButton alloc] init];
    
    [self loadNewAnswer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updateUI];
}

- (UIColor*)green
{
    return [UIColor colorWithRed:124.0f/255.0f green:199.0f/255.0f blue:11.0f/255.0f alpha:1.0f];
}

- (UIColor*)yellow
{
    return [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:15.0f/255.0f alpha:1.0f];
}

- (BaseModel *)baseModel {
    if (!_baseModel) {
        _baseModel = [[BaseModel alloc] initWithViewController:self];
        _baseModel.boardDelegate = self;
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

    
    // Edit Next Question Button
    self.nextQuestionButton.layer.borderWidth = 1;
    self.nextQuestionButton.layer.borderColor = self.green.CGColor;
    self.nextQuestionButton.layer.backgroundColor = self.green.CGColor;
    self.nextQuestionButton.layer.cornerRadius = 8;
    self.nextQuestionButton.layer.masksToBounds = YES;
    self.nextQuestionButton.alpha = 0;
}

- (void)loadNewAnswer{
    
    [self initTimerWithTime:15];
    
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
    
    [self deselectAll];
    
}

- (IBAction)checkAnswer:(id)sender {
    [self.circularTimer stop];
    CGSize viewSize = self.view.frame.size;

    ResultAnswerPopUpView *resultAnswerPopUpView = [[ResultAnswerPopUpView alloc] initWithFrame:CGRectMake(20, viewSize.height / 3, viewSize.width - 20, 30)];
    
    [BoardAnimations animatePopupwith:resultAnswerPopUpView on:self.view];
    
    self.checkButton.alpha = 0;
    self.skipButton.alpha = 0;
    [self.nextQuestionButton fadeIn];
}

- (IBAction)nextQuestionPressed:(id)sender {
    self.nextQuestionButton.alpha = 0;
    [self.checkButton fadeIn];
    [self.skipButton fadeIn];
    [self removeSubviews];
    [self loadNewAnswer];
}

- (IBAction)skipQuestion:(id)sender {
    // Button Animation
    [self deselectAll];
    [self.circularTimer stop];
    [(BaseButton*) sender fadeButton];
    [self loadNewAnswer];
}

- (IBAction)clickOnAnswer:(id)sender {
    if(![sender isEqual:self.chosenAnswer])
        [self deselectAll];
    // Button Animation
    [(BaseButton*)sender invertSelectionfromColor:self.green];
    self.chosenAnswer = (UIButton*) sender;
}

- (void)deselectAll
{
    [self.answerAButton deselect];
    [self.answerBButton deselect];
    [self.answerCButton deselect];
    [self.answerDButton deselect];
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
    
    __weak BoardViewController *weakSelf = self;
    
    self.circularTimer.endBlock = ^(CircularTimerView *circularTimerView){
        [weakSelf timeOut];
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

#pragma mark - Model methods

- (void)addDelegateForModel:(GameViewController *)delegateController {
    self.baseModel.gameDelegate = delegateController;
}


#pragma mark - BaseModel Protocol

- (void)board:(BoardViewController *)board didUpdateScore:(int)score {
    if ([board isEqual:self]) {
        
    }
}

@end
