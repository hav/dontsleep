//
//  GameModel.m
//  QuizBro
//
//  Created by Boris Kachscovsky on 5/16/14.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "GameModel.h"
#import "ScoreViewController.h"

@interface GameModel()

@property (strong,nonatomic) BaseModel* player1;
@property (strong,nonatomic) BaseModel* player2;
@property (strong,nonatomic) ScoreViewController* score;

@end

@implementation GameModel

- (GameModel *) initWithModelForPlayer1:(BaseModel*)player1 andPlayer2:(BaseModel *)player2
{
    self = [super init];
    self.player1 = player1;
    self.player2 = player2;
    
    player1.gameModel = self;
    player2.gameModel = self;
    return self;
}

//Communicate with ScoreViewController (scores)
//Check who won

- (void) scoreAddedForPlayer:(BaseModel*)player
{
    if([player isEqual:(self.player1)])
    {
        [self.score addPointPlayerOne];
    }
    else{
        [self.score addPointPlayerTwo];
    }
}

- (void) scoreSubtractedForPlayer:(BaseModel*)player
{
    if([player isEqual:(self.player1)])
    {
        [self.score removePointPlayerOne];
    }
    else{
        [self.score removePointPlayerTwo];
    }
}

@end
