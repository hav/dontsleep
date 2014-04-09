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
#import "GameViewController.h"
#import "DataManager.h"
#import "CircularTimerView.h"



@interface BoardViewController ()

@property (nonatomic)  NSInteger* rightAnswers;
@property (nonatomic)  NSInteger* wrongAnswers;
@property (nonatomic, strong) CircularTimerView *circularTimerView;

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

- (NSInteger*)rightAnswers
{
    if(!_rightAnswers)
    {
        _rightAnswers = 0;
    }
    return _rightAnswers;
}

- (NSInteger*)wrongAnswers
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

- (void)loadNewAnswer{
    
    [self initTimer];

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
    
    // set question
    [self.questionTextView setText:questionText];
    
    // set answers
    [self.answerAButton setTitle:answerA forState:UIControlStateNormal];
    [self.answerBButton setTitle:answerB forState:UIControlStateNormal];
    [self.answerCButton setTitle:answerC forState:UIControlStateNormal];
    [self.answerDButton setTitle:answerD forState:UIControlStateNormal];
    
    
}

- (IBAction)checkAnswer:(id)sender {
    ResultAnswerPopUpView *resultAnswerPopUpView = [[ResultAnswerPopUpView alloc] initWithFrame:CGRectMake(0, 180, self.view.frame.size.width - 20, 30)];
    
    if([self.baseModel didSelectAnswer:self.chosenAnswer.titleLabel.text]){
        [resultAnswerPopUpView initWithResult:TRUE];
        [self.view addSubview:resultAnswerPopUpView];
        self.rightAnswers++;
        self.rightAnswersText.text = [NSString stringWithFormat:@"%d", (int) self.rightAnswers];
    }
    else{
        [resultAnswerPopUpView initWithResult:FALSE];
        [self.view addSubview:resultAnswerPopUpView];
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

- (void)initTimer
{
    // Remove the last view
    for (UIView *subView in self.view.subviews)
    {
        if ([subView isKindOfClass:[CircularTimerView class]])
        {
            [subView removeFromSuperview];
        }
    }
    
    self.circularTimerView =
    [[CircularTimerView alloc] initWithPosition:CGPointMake(410.f, 20.f)
                                         radius:20
                                 internalRadius:15
                                 returnInstance:self];
    
    // Light gray circle
    self.circularTimerView.backgroundColor = [UIColor lightGrayColor];
    self.circularTimerView.backgroundFadeColor = [UIColor lightGrayColor];
    
    // Circle Fade from green to red
    self.circularTimerView.foregroundColor = [UIColor greenColor];
    self.circularTimerView.foregroundFadeColor = [UIColor redColor];
    self.circularTimerView.direction = CircularTimerViewDirectionCounterClockwise;
    
    // Text fade from green to red
    self.circularTimerView.font = [UIFont systemFontOfSize:10];
    self.circularTimerView.fontColor = [UIColor greenColor];
    self.circularTimerView.fontFadeColor = [UIColor redColor];
    
    // Display seconds - format text here
    self.circularTimerView.frameBlock = ^(CircularTimerView *circularTimerView){
        NSTimeInterval elapsed = [circularTimerView runningElapsedTime];
        NSTimeInterval total = [circularTimerView intervalLength];
        circularTimerView.text = [NSString stringWithFormat:@"%.0f",total - elapsed];
    };
    
    // 1 minute timer
    [self.circularTimerView setupCountdown:15];
    
    [self.view addSubview:self.circularTimerView];
}

- (void)timeOut
{
    NSLog(@"%@ timed out",self);
     TimeOutPopUpView *timeOutPopUpView = [[TimeOutPopUpView alloc] initWithFrame:CGRectMake(0, 180, self.view.frame.size.width - 20, 30)];
    [self.view addSubview:timeOutPopUpView];
}




@end
