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

@interface Answer : NSManagedObject

@property (nonatomic, retain) NSString * answerText;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * correctAnswer;
@property (nonatomic, retain) Question *question;

@end
