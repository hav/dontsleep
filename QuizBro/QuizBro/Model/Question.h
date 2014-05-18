//
//  Question.h
//  QuizBro
//
//  Created by Farshid Besharati on 2014-04-03.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Answer, Tag;

/**
 *  Questions are represented in the database by Question objects.
 *  A question has an identifier (integer), a text, a relationship
 *  to a set of answers, and a relationship to a set of tags.
 */
@interface Question : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * questionText;
@property (nonatomic, retain) NSSet *answers;
@property (nonatomic, retain) NSSet *tags;
@end


/**
 *  Methods generated by Core Data for accessing and modifying the Question objects.
 */
@interface Question (CoreDataGeneratedAccessors)

- (void)addAnswersObject:(Answer *)value;
- (void)removeAnswersObject:(Answer *)value;
- (void)addAnswers:(NSSet *)values;
- (void)removeAnswers:(NSSet *)values;

- (void)addTagsObject:(Tag *)value;
- (void)removeTagsObject:(Tag *)value;
- (void)addTags:(NSSet *)values;
- (void)removeTags:(NSSet *)values;

@end
