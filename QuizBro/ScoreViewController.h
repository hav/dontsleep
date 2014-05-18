//
//  ScoreViewController.h
//  QuizBro
//
//  Created by Christian Danheimer Furedal on 2014-04-18.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BoardViewController;

@interface ScoreViewController : UIViewController

/**
 *  Change the current score for player.
 *
 *  @param board Board of player with new score.
 *  @param score New score.
 */
- (void)adjustScoreFor:(BoardViewController *)board toScore:(NSInteger)score;

/**
 *  Initialize the Score View Controller and set player one and two properties.
 *
 *  @param playerOne Board of player one.
 *  @param playerTwo Board of player two.
 *
 *  @return The Score View Controller (itself).
 */
- (id)initWithPlayerOne:(BoardViewController *)playerOne andPlayerTwo:(BoardViewController *)playerTwo;

@end
