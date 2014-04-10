//
//  BaseModel.h
//  QuizBro
//
//  Created by Farshid Besharati on 2014-03-31.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseModelProtocol <NSObject>


@end

@interface BaseModel : NSObject

- (BOOL)didSelectAnswer:(NSString *)answerText;
- (NSDictionary *)randomQuestionAndAnswers;

- (NSInteger *)getScore;

@property (nonatomic, strong) id<BaseModelProtocol> delegate;

@end
