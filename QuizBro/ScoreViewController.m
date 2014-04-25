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


#import "ScoreViewController.h"

@interface ScoreViewController ()

@property NSInteger scorePoint;

@end

@implementation ScoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scorePoint = 0;

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self addCenterLine];
}

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

- (void)addPointPlayerOne:(NSInteger)scorePoint
{
    
    UIView *scoreBox = [[UIView alloc] initWithFrame:({
        CGRect frame = self.view.bounds;
        frame.size.height = scoreDim;
        frame.size.width = scoreDim;
        frame.origin.y = 0;
        frame.origin.x = 0;
        frame;
    })];
    
    CGPoint finalOrigin = CGPointMake(widthStartingPosition + scoreDim/2, heightStartingPosition - scoreDim*scorePoint);
    scoreBox.backgroundColor = [UIColor greenColor];
    
    [self animateScoreBox:scoreBox toOrigin:finalOrigin];
}

- (void)addPointPlayerTwo:(NSInteger)scorePoint
{
    UIView *scoreBox = [[UIView alloc] initWithFrame:({
        CGRect frame = self.view.bounds;
        frame.size.height = scoreDim;
        frame.size.width = scoreDim;
        frame.origin.y = self.view.frame.size.height;
        frame.origin.x = 0;
        frame;
    })];
    
    CGPoint finalOrigin = CGPointMake(widthStartingPosition + scoreDim/2, heightStartingPosition + scoreDim*(scorePoint - 1));
    scoreBox.backgroundColor = [UIColor redColor];
    
    [self animateScoreBox:scoreBox toOrigin:finalOrigin];
}

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
@end
