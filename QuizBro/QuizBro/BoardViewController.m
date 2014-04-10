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
@property (nonatomic) UIColor* yellow;
@property (nonatomic) UIColor* green;
@property (nonatomic, strong) CircularTimerView *circularTimerView;

@end

@implementation BoardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.yellow = [UIColor colorWithRed:254.0f/255.0f green:191.0f/255.0f blue:15.0f/255.0f alpha:1.0f];
    self.green = [UIColor colorWithRed:124.0f/255.0f green:199.0f/255.0f blue:11.0f/255.0f alpha:1.0f];
    
    [self createUI];
    [[DataManager sharedInstance] seedDatabase];
    [[DataManager sharedInstance] managedObjectContext];
    
    self.chosenAnswer = [[UIButton alloc] init];
    
    [self loadNewAnswer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updateUI];
}

- (void)updateUI
{

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

- (void)createUI
{
    self.view.layer.borderWidth = 1;
    self.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.view.layer.cornerRadius = 8;
    self.view.layer.masksToBounds = YES;
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

- (void)fadeButton:(UIButton *)button
{
    button.alpha = 0.8;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ button.alpha = 1;}
                     completion:nil];
}

- (void)fadeOut:(UIButton *)button
{
    button.alpha = 1;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ button.alpha = 0;}
                     completion:nil];
}

- (void)fadeIn:(UIButton *)button
{
    button.alpha = 0;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ button.alpha = 1;}
                     completion:nil];
}

- (void)selectDeselect:(UIButton *)button
{
    UIColor *newColor;
    if(button.layer.backgroundColor == self.green.CGColor)
    {
        newColor = [UIColor whiteColor];
    }
    else
    {
        newColor = self.green;
    }
    
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ button.layer.backgroundColor = newColor.CGColor;}
                     completion:nil];
        
}

- (IBAction)checkAnswer:(id)sender {
    CGSize viewSize = self.view.frame.size;

    ResultAnswerPopUpView *resultAnswerPopUpView = [[ResultAnswerPopUpView alloc] initWithFrame:CGRectMake(20, viewSize.height / 3, viewSize.width - 20, 30)];
    
    if([self.baseModel didSelectAnswer:self.chosenAnswer.titleLabel.text]){
        [resultAnswerPopUpView initWithResult:TRUE];
        self.rightAnswers++;
        self.rightAnswersText.text = [NSString stringWithFormat:@"%d", (int) self.rightAnswers];
    }
    else{
        [resultAnswerPopUpView initWithResult:FALSE];
        self.wrongAnswers++;
        self.wrongAnswersText.text = [NSString stringWithFormat:@"%d", (int) self.wrongAnswers];
    }
    
    [self animatePopupwithView:resultAnswerPopUpView];
    
    self.checkButton.alpha = 0;
    self.skipButton.alpha = 0;
    [self fadeIn:self.nextQuestionButton];
    [self.circularTimerView stop];
}

- (IBAction)nextQuestionPressed:(id)sender {
    self.nextQuestionButton.alpha = 0;
    [self fadeIn:self.checkButton];
    [self fadeIn:self.skipButton];
    [self removeSubviews];
    [self loadNewAnswer];
}

- (IBAction)skipQuestion:(id)sender {
    // Button Animation
    [self fadeButton:(UIButton*) sender];
    [self loadNewAnswer];
}

- (IBAction)clickOnAnswer:(id)sender {
    // Button Animation
    [self selectDeselect:(UIButton*) sender];
    self.chosenAnswer = (UIButton*) sender;
}

- (void)removeSubviews
{
    // Remove those pesky popups
    for (UIView *subView in self.view.subviews)
    {
        if ([subView isKindOfClass:[TimeOutPopUpView class]] ||
            [subView isKindOfClass:[ResultAnswerPopUpView class]] ||
            [subView isKindOfClass:[CircularTimerView class]])
        {
            [subView removeFromSuperview];
        }
    }
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
    self.circularTimerView.direction = CircularTimerViewDirectionClockwise;
    
    // Text fade from green to red
    self.circularTimerView.font = [UIFont systemFontOfSize:9];
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
    CGSize viewSize = self.view.frame.size;
    
    TimeOutPopUpView *timeOutPopUpView = [[TimeOutPopUpView alloc]
                                          initWithFrame:
                                          CGRectMake(20, viewSize.height / 3, viewSize.width - 20, 30)];
    [self animatePopupwithView:timeOutPopUpView];
    self.checkButton.alpha = 0;
    self.skipButton.alpha = 0;
    [self fadeIn:self.nextQuestionButton];
    
}

- (void)animatePopupwithView:(UIView *)view
{
    CGSize viewSize = self.view.frame.size;
    int startyPosition = view.frame.origin.x;
    int endyPosition = viewSize.height / 2;
    
    view.alpha = 0;
    
    // Animate & Jump
    CGFloat offset = .1*(endyPosition - startyPosition);
    
    [UIView animateWithDuration:.3 animations:^{
        CGRect frame = view.frame;
        frame.origin.y = endyPosition + offset;
        view.frame = frame;
        view.alpha = 0.3;
    } completion:^(BOOL finished){
        [UIView animateWithDuration:.1 animations:^{
            CGRect frame = view.frame;
            frame.origin.y = endyPosition;
            view.frame = frame;
            view.alpha = 1;
        }];
    }];
    
    [self.view addSubview:view];
}




@end
