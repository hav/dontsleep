//
//  Answer.h
//  QuizBro
//
//  Created by Farshid Besharati on 2014-04-03.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Question;

/**
 *  Each Question has four related answers which are stored in a set.
 *  These Answers all have four properties.
 *
 *  @param answerText The text of the answer.
 *  @param identifier An integer identifying the answer.
 *  @param correctAnswer A BOOL value declaring if the answer is the correct one or not.
 *  @param question The Question the Answer belongs to.
 */
@interface Answer : NSManagedObject

@property (nonatomic, retain) NSString * answerText;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * correctAnswer;
@property (nonatomic, retain) Question *question;

@end
