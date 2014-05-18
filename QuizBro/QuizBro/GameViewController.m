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

@property (strong,nonatomic) BaseModel* player1;
@property (strong, nonatomic) BaseModel* player2;
@property (strong,nonatomic) BoardViewController* player1Board;
@property (strong,nonatomic) BoardViewController* player2Board;


@end

@implementation GameViewController

- (BaseModel *)player1 {
    if (!_player1) {
        _player1 = [[BaseModel alloc] initWithViewController:self];
    }
    
    return _player1;
}

- (BaseModel *)player2 {
    if (!_player2) {
        _player2 = [[BaseModel alloc] initWithViewController:self];
    }
    
    return _player2;
}

- (GameModel *)gameModel
{
    if(!_gameModel){
        _gameModel = [[GameModel alloc] initWithModelForPlayer1:self.player1 andPlayer2:self.player2];
    }
    return _gameModel;
}

-(void)deviceRotated:(NSNotification *)note{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    CGFloat rotationAngleLeft = M_PI;
    CGFloat rotationAngleRight = 0;

    self.leftContainer.transform = CGAffineTransformMakeRotation(rotationAngleLeft);
    self.rightContainer.transform = CGAffineTransformMakeRotation(rotationAngleRight);
}

-(void)viewDidLoad{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceRotated:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    self.player1.gameModel = self.gameModel;
    self.player2.gameModel = self.gameModel;
    
}


-(void)viewDidUnload{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)addChildViewController:(UIViewController *)childController {
    [super addChildViewController:childController];
    

    if ([childController isKindOfClass:[BoardViewController class]]) {
        if(!_player1Board)
            self.player1Board = (BoardViewController *) childController;
        else
            self.player2Board = (BoardViewController *) childController;
        
        
        [((BoardViewController *)childController) addDelegateForModel:self];
    }
}


@end