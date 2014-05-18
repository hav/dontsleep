//
//  GameModel.h
//  QuizBro
//
//  Created by Boris Kachscovsky on 5/16/14.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

@class BaseModel;
#import <Foundation/Foundation.h>

@interface GameModel : NSObject

- (void) scoreSubtractedForPlayer:(BaseModel*)player;
- (void) scoreAddedForPlayer:(BaseModel*)player;
- (GameModel *) initWithModelForPlayer1:(BaseModel*)player1 andPlayer2:(BaseModel*)player2;

@end
