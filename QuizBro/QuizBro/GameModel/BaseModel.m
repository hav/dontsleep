//
//  BaseModel.m
//  QuizBro
//
//  Created by Farshid Besharati on 2014-03-31.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "BaseModel.h"
#import "DataManager.h"
#import "AppDelegate.h"

#import "Question.h"
#import "Answer.h"

@interface BaseModel()

@property (nonatomic, strong) NSMutableArray *questions;
@property (nonatomic, strong) Question *currentQuestion;
@property (nonatomic, strong) Answer *currentCorrectAnswer;

@end

@implementation BaseModel

- (Question *)fetchRandomQuestion {
    Question *randomQuestion;
    
    // TODO pick random question
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedInstance] managedObjectContext];;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Question" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];

    if ([results count] <= [self.questions count]) {
        [self.questions removeAllObjects];
    }
    
    do {
        randomQuestion = results[arc4random() % [results count]];
    } while ([self.questions containsObject:randomQuestion] && ![randomQuestion isEqual:self.currentQuestion]);
    
    [self.questions addObject:randomQuestion];

    return randomQuestion;
}

- (BOOL)didSelectAnswer:(NSString *)answerText {
    if ([self.currentCorrectAnswer.answerText isEqualToString:answerText]) {
        return YES;
    }
    
    return NO;
}

- (NSDictionary *)randomQuestionAndAnswers {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    self.currentQuestion = [self fetchRandomQuestion];
    [dict setValue:self.currentQuestion.questionText forKey:@"Question"];
    
    NSArray *currentAnswers = [self.currentQuestion.answers allObjects];
    
    [currentAnswers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [dict setValue:((Answer *)obj).answerText forKey:[NSString stringWithFormat:@"Answer_%d", idx+1]];
        
        if (((Answer *)obj).correctAnswer) {
            self.currentCorrectAnswer = obj;
        }
    }];
    
    return [dict copy];
}


@end
