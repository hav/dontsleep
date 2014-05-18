//
//  BaseModel.h
//  QuizBro
//
//  Created by Farshid Besharati on 2014-03-31.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BoardViewController;

/**
 *  Protocol declaration for BaseModel delegates.
 */
@protocol BaseModelProtocol <NSObject>

/**
 *  Delegate method to notify a delegate of the score of
 *  the current BoardViewController
 *
 *  @param board The BoardViewController that this BaseModel belongs to
 *  @param score The current score
 */
- (void)board:(BoardViewController *)board didUpdateScore:(int)score;

@end

/**
 *  BaseModel is the representation of the game. It keeps track of 
 *  the score for the current player as well as retrieving questions and 
 *  answers for the board to show.
 */
@interface BaseModel : NSObject

/**
 *  Custom init that creates a BaseModel and assigns a board to it.
 *
 *  @param viewController The creating BoardViewController
 *
 *  @return A BaseModel
 */
- (id)initWithViewController:(BoardViewController *)viewController;

/**
 *  Called when a board wants to know if the chosen answer is the correct one.
 *
 *  @param answerText The text for the answer
 *
 *  @return YES if correct, NO if false
 */
- (BOOL)didSelectAnswer:(NSString *)answerText;

/**
 *  Selects a random question and accompanying answers
 *
 *  @return NSDictionary with the question and its answers
 */
- (NSDictionary *)randomQuestionAndAnswers;

/**
 *  Protocol properties
 */
@property (nonatomic, strong) id<BaseModelProtocol> gameDelegate;
@property (nonatomic, strong) id<BaseModelProtocol> boardDelegate;

@end
