//
//  DataManager.m
//  QuizBro
//
//  Created by Farshid Besharati on 2014-04-03.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "DataManager.h"
#import "AppDelegate.h"

#import "Question.h"
#import "Answer.h"

@interface DataManager()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation DataManager

+ (id)sharedInstance {
    static DataManager *sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [((AppDelegate *)[[UIApplication sharedApplication] delegate]) managedObjectContext];
    }
    
    return _managedObjectContext;
}

- (void)seedDatabase {
    NSError *error;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"quiz" ofType:@"json"];
    NSArray *questionsAndAnswers = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath] options:kNilOptions error:&error];
    NSEntityDescription *questionDescription = [NSEntityDescription entityForName:@"Question" inManagedObjectContext:context];
    NSEntityDescription *answerDescription = [NSEntityDescription entityForName:@"Answer" inManagedObjectContext:context];
    
    [questionsAndAnswers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Question *newQuestion = [[Question alloc] initWithEntity:questionDescription insertIntoManagedObjectContext:context];
        newQuestion.questionText = [obj valueForKey:@"questionText"];
        newQuestion.identifier = [obj valueForKey:@"identifier"];
        
        NSArray *answers = obj[@"answers"];
        [answers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            Answer *newAnswer = [[Answer alloc] initWithEntity:answerDescription insertIntoManagedObjectContext:context];
            newAnswer.answerText = obj[@"answerText"];
            newAnswer.identifier = obj[@"identifier"];
            newAnswer.correctAnswer = obj[@"correctAnswer"];
            
            [newQuestion addAnswersObject:newAnswer];
        }];
        
        [context save:nil];
    }]; 
}

@end
