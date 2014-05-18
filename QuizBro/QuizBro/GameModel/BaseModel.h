//
//  BaseModel.h
//  QuizBro
//
//  Created by Farshid Besharati on 2014-03-31.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameModel.h"

@class BoardViewController;

@protocol BaseModelProtocol <NSObject>

- (void)board:(BoardViewController *)board didUpdateScore:(int)score;

@end

@interface BaseModel : NSObject

- (id)initWithViewController:(BoardViewController *)viewController;
- (BOOL)didSelectAnswer:(NSString *)answerText;
- (NSDictionary *)randomQuestionAndAnswers;

@property (nonatomic, strong) id<BaseModelProtocol> gameDelegate;
@property (nonatomic, strong) id<BaseModelProtocol> boardDelegate;

@end
