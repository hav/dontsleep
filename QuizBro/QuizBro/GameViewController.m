//
//  GameViewController.m
//  QuizBro
//
//  Created by Christian Danheimer Furedal on 2014-03-31.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "GameViewController.h"
#import "BoardViewController.h"
#import "ScoreViewController.h"


@interface GameViewController ()

@property (strong,nonatomic) BoardViewController* player1Board;
@property (strong,nonatomic) BoardViewController* player2Board;
@property (nonatomic, strong) ScoreViewController *scoreViewController;

@end

@implementation GameViewController

-(void)deviceRotated:(NSNotification *)note{
    CGFloat rotationAngleLeft = M_PI;
    CGFloat rotationAngleRight = 0;

    self.leftContainer.transform = CGAffineTransformMakeRotation(rotationAngleLeft);
    self.rightContainer.transform = CGAffineTransformMakeRotation(rotationAngleRight);
}

-(void)viewDidLoad{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceRotated:) name:UIDeviceOrientationDidChangeNotification object:nil];
}


-(void)viewDidUnload{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)addChildViewController:(UIViewController *)childController {
    [super addChildViewController:childController];
    
    if ([childController isKindOfClass:[BoardViewController class]]) {
        if(!self.player1Board) {
            self.player1Board = (BoardViewController *)childController;
        } else {
            self.player2Board = (BoardViewController *)childController;
            self.scoreViewController = [self.scoreViewController initWithPlayerOne:self.player1Board andPlayerTwo:self.player2Board];
        }
        
        [((BoardViewController *)childController) addDelegateForModel:self];
    } else if ([childController isKindOfClass:[ScoreViewController class]]) {
        self.scoreViewController = (ScoreViewController *)childController;
    }
}

#pragma mark - BaseModel protocol

- (void)board:(BoardViewController *)board didUpdateScore:(int)score {
    [self.scoreViewController adjustScoreFor:board toScore:score];
}


@end