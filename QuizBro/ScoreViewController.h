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

- (void)addPointPlayerOne;
- (void)addPointPlayerTwo;
- (void)removePointPlayerOne;
- (void)removePointPlayerTwo;

- (void)adjustScoreFor:(BoardViewController *)board toScore:(NSInteger)score;
- (id)initWithPlayerOne:(BoardViewController *)playerOne andPlayerTwo:(BoardViewController *)playerTwo;

@end
