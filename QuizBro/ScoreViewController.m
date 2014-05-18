//
//  ScoreViewController.m
//  QuizBro
//
//  Created by Christian Danheimer Furedal on 2014-04-18.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#define heightStartingPosition self.view.frame.size.height/2
#define widthStartingPosition self.view.frame.size.width/2 - scoreDim

#define scoreDim 20
#define playerOneTagConstant 0
#define playerTwoTagConstant 100


#import "ScoreViewController.h"
#import "BoardViewController.h"

@interface ScoreViewController ()

@property NSInteger scorePointPlayerOne;
@property NSInteger scorePointPlayerTwo;

@property (nonatomic, strong) BoardViewController *player1Board;
@property (nonatomic, strong) BoardViewController *player2Board;
@property (weak, nonatomic) IBOutlet UILabel *playerOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoLabel;

@property (nonatomic) NSInteger oldPlayerOneScore;
@property (nonatomic) NSInteger oldPlayerTwoScore;
@property (nonatomic) NSInteger playerOneScore;
@property (nonatomic) NSInteger playerTwoScore;

@property (nonatomic, strong) UIView *playerOneScoreView;
@property (nonatomic, strong) UIView *playerTwoScoreView;

@end

@implementation ScoreViewController

- (id)initWithPlayerOne:(BoardViewController *)playerOne andPlayerTwo:(BoardViewController *)playerTwo {
    self = [super init];
    
    if (self) {
        self.player1Board = playerOne;
        self.player2Board = playerTwo;
    }
    
    return self;
}

/**
 *  Set all scores to zero.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor blackColor];
    
    self.scorePointPlayerOne = 0;
    self.scorePointPlayerTwo = 0;
    self.playerOneScore = 0;
    self.playerTwoScore = 0;
//    [self updateFrames];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    //[self addCenterLine];
}

#pragma mark - Lazy instantiation

/**
 *  Initialize score view of player one.
 *
 *  @return Player one's score view.
 */
- (UIView *)playerOneScoreView {
    if (!_playerOneScoreView) {
        _playerOneScoreView = [[UIView alloc] initWithFrame:({
            CGRect frame = self.view.frame;
            frame.size.height = 100;
            frame.size.width = 64.0f;
            frame.origin.x = 0;
            frame.origin.y = 344;
            frame;
        })];
        //_playerOneScoreView.backgroundColor = [UIColor greenColor];
        _playerOneScoreView.layer.backgroundColor = [UIColor greenColor].CGColor;
        [self.view addSubview:_playerOneScoreView];
    }
    
    return _playerOneScoreView;
}

/**
 *  Initialize score view of player two.
 *
 *  @return Player two's score view.
 */
- (UIView *)playerTwoScoreView {
    if (!_playerTwoScoreView) {
        _playerTwoScoreView = [[UIView alloc] initWithFrame:({
            CGRect frame = self.view.frame;
            frame.size.height = 100;
            frame.size.width = 64.0f;
            frame.origin.x = 0;
            frame.origin.y = 364;
            frame;
        })];
        //_playerTwoScoreView.backgroundColor = [UIColor redColor];
        _playerTwoScoreView.layer.backgroundColor = [UIColor redColor].CGColor;
        [self.view addSubview:_playerTwoScoreView];
    }
    
    return _playerTwoScoreView;
}

- (void)adjustScoreFor:(BoardViewController *)board toScore:(NSInteger)score {
    if ([board isEqual:self.player1Board]) {
        //self.oldPlayerOneScore = self.playerOneScore;
        self.playerOneScore = score;
    } else {
        //self.oldPlayerTwoScore = self.playerTwoScore;
        self.playerTwoScore = score;
    }
    
//    [self updateFrames];
}

/**
 *  Update player one's score label.
 *
 *  @param playerOneScore New score for player one.
 */
- (void)setPlayerOneScore:(NSInteger)playerOneScore {
    self.playerOneLabel.text = [NSString stringWithFormat:@"%d", playerOneScore];
    _playerOneScore = playerOneScore;
}

/**
 *  Update player two's score label.
 *
 *  @param playerTwoScore New score for player two.
 */
- (void)setPlayerTwoScore:(NSInteger)playerTwoScore {
    self.playerTwoLabel.text = [NSString stringWithFormat:@"%d", playerTwoScore];
    _playerTwoScore = playerTwoScore;
}

/**
 *  Animate new score representation.
 */
- (void)updateFrames {
    CABasicAnimation *playerOneAnimation = [CABasicAnimation animationWithKeyPath:@"frame.size.height"];
    playerOneAnimation.duration = 0.2;
    playerOneAnimation.fromValue = @(self.oldPlayerOneScore/100);
    playerOneAnimation.toValue = @(self.playerOneScore/100);
    
    [self.playerTwoScoreView.layer addAnimation:playerOneAnimation forKey:@"ScorePositioning"];
    
    CABasicAnimation *playerTwoAnimation = [CABasicAnimation animationWithKeyPath:@"frame.size.height"];
    playerTwoAnimation.duration = 0.2;
    playerTwoAnimation.fromValue = @(self.oldPlayerTwoScore);
    playerTwoAnimation.toValue = @(self.playerTwoScore);
    [self.playerTwoScoreView.layer addAnimation:playerTwoAnimation forKey:@"ScorePositioning"];
}


/**
 *  Adds a black line in the middle of the view.
 */
- (void)addCenterLine
{
    UIView *lineView = [[UIView alloc] initWithFrame:({
        CGRect frame = self.view.bounds;
        frame.size.height = 1.0f;
        frame.origin.y = heightStartingPosition;
        frame;
    })];
    
    lineView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineView];
    
}

/**
 *  Animates the view to fly in to the target point.
 *
 *  @param view  Score box.
 *  @param point Target point.
 */
- (void)animateScoreBox:(UIView *)view toOrigin:(CGPoint)point
{
    CGRect newFrame = view.bounds;
    newFrame.origin = point;
    
    [UIView animateWithDuration:0.3 animations:^{
        view.frame = newFrame;
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.1 animations:^{
        }];
    }];
    
    [self.view addSubview:view];
}

/**
 *  Find and returns the view with target tag.
 *
 *  @param tag View tag.
 *
 *  @return The view.
 */
- (UIView *)viewWithTagNotCountingSelf:(NSInteger)tag
{
    UIView *toReturn = nil;
    
    for (UIView *subView in self.view.subviews)
    {
        toReturn = [subView viewWithTag:tag];
        
        if (toReturn)
            break;
    }
    
    return toReturn;
}

@end
