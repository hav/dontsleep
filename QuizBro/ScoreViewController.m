//
//  ScoreViewController.m
//  QuizBro
//
//  Created by Christian Danheimer Furedal on 2014-04-18.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#define heightStartingPosition self.view.frame.size.height/2
#define scoreDim 20
#define widthStartingPosition self.view.frame.size.width/2 - scoreDim
#define playerOneTagConstant 0
#define playerTwoTagConstant 100


#import "ScoreViewController.h"
#import "BoardViewController.h"

@interface ScoreViewController ()

@property NSInteger scorePointPlayerOne;
@property NSInteger scorePointPlayerTwo;

@property (nonatomic, strong) BoardViewController *player1Board;
@property (nonatomic, strong) BoardViewController *player2Board;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scorePointPlayerOne = 0;
    self.scorePointPlayerTwo = 0;

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self addCenterLine];
}

- (void)adjustScoreFor:(BoardViewController *)board toScore:(NSInteger)score {
    
}

- (void)modifyFrameForPlayerOne {
    
}

// Adds a black line in the middle of the view
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
    
    UIView *playerOne = [[UIView alloc] initWithFrame:({
        CGRect frame = self.view.bounds;
        frame.size.height = 0;
        frame.origin = CGPointMake(0, 0);
        frame;
    })];
}

// Adds a score box for player one.
- (void)addPointPlayerOne
{
    self.scorePointPlayerOne++;
    UIView *scoreBox = [[UIView alloc] initWithFrame:({
        CGRect frame = self.view.bounds;
        frame.size.height = scoreDim;
        frame.size.width = scoreDim;
        frame.origin.y = 0;
        frame.origin.x = 0;
        frame;
    })];
    
    CGPoint finalOrigin = CGPointMake(widthStartingPosition + scoreDim/2, heightStartingPosition - scoreDim*self.scorePointPlayerOne);
    scoreBox.backgroundColor = [UIColor greenColor];
    scoreBox.layer.borderColor = [UIColor blackColor].CGColor;
    scoreBox.layer.borderWidth = 1.0f;
    scoreBox.tag = self.scorePointPlayerOne+playerOneTagConstant;
    
    [self animateScoreBox:scoreBox toOrigin:finalOrigin];
}

// Adds a score box for player two.
- (void)addPointPlayerTwo
{
    self.scorePointPlayerTwo++;
    UIView *scoreBox = [[UIView alloc] initWithFrame:({
        CGRect frame = self.view.bounds;
        frame.size.height = scoreDim;
        frame.size.width = scoreDim;
        frame.origin.y = self.view.frame.size.height;
        frame.origin.x = 0;
        frame;
    })];
    
    CGPoint finalOrigin = CGPointMake(widthStartingPosition + scoreDim/2, heightStartingPosition + scoreDim*(self.scorePointPlayerTwo - 1));
    scoreBox.backgroundColor = [UIColor redColor];
    scoreBox.layer.borderColor = [UIColor blackColor].CGColor;
    scoreBox.layer.borderWidth = 1.0f;
    scoreBox.tag = self.scorePointPlayerOne+playerTwoTagConstant;
    
    [self animateScoreBox:scoreBox toOrigin:finalOrigin];
}



// Animates the view to fly in to the target point
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

// Removes the last point from player one
- (void)removePointPlayerOne
{
    UIView *scoreBox = [self viewWithTagNotCountingSelf:(self.scorePointPlayerOne+playerOneTagConstant)];
    [scoreBox removeFromSuperview];
    self.scorePointPlayerOne--;
}

// Removes the last point from player two
- (void)removePointPlayerTwo
{
    UIView *scoreBox = [self viewWithTagNotCountingSelf:(self.scorePointPlayerTwo+playerTwoTagConstant)];
    [scoreBox removeFromSuperview];
    self.scorePointPlayerTwo--;
}

// Find and returns the view with target tag
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
