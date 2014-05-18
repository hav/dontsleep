//
//  BaseModel.m
//  QuizBro
//
//  Created by Farshid Besharati on 2014-03-31.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "BaseModel.h"
#import "DataManager.h"

#import "Question.h"
#import "Answer.h"

@interface BaseModel()

@property (nonatomic, strong) BoardViewController *boardViewController;
@property (nonatomic, strong) NSMutableArray *questions;
@property (nonatomic, strong) Question *currentQuestion;
@property (nonatomic, strong) Answer *currentCorrectAnswer;

@property (nonatomic) NSInteger myScore;

@end

@implementation BaseModel

- (id)initWithViewController:(BoardViewController *)viewController {
    self = [super init];
    
    if (self) {
        self.boardViewController = viewController;
    }
    
    return self;
}


#pragma mark - Questions

/**
 *  Fetches a random Question from the database.
 *  Question is guaranteed to not be a previously used one,
 *  unless all questions have already been used
 *
 *  @return A random Question
 */
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


/**
 *  Allocates empty mutable array
 *
 *  @return Empty NSMutableArray
 */
- (NSMutableArray *)questions {
    if (!_questions)
    {
        _questions = [[NSMutableArray alloc] init];
    }
    
    return _questions;
}

static const int CORRECT_ANSWER_BONUS = 2;
static const int WRONG_ANSWER_PENALTY = 1;

- (BOOL)didSelectAnswer:(NSString *)answerText {
    if ([self.currentCorrectAnswer.answerText isEqualToString:answerText]) {
        self.myScore = self.myScore + CORRECT_ANSWER_BONUS;
        [self.gameDelegate board:self.boardViewController didUpdateScore:self.myScore];
        [self.boardDelegate board:self.boardViewController didUpdateScore:self.myScore];
        
        return YES;
    }
    
    self.myScore = self.myScore - WRONG_ANSWER_PENALTY;
    [self.gameDelegate board:self.boardViewController didUpdateScore:self.myScore];
    [self.boardDelegate board:self.boardViewController didUpdateScore:self.myScore];
    
    return NO;
}

- (NSDictionary *)randomQuestionAndAnswers {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    self.currentQuestion = [self fetchRandomQuestion];
    [dict setValue:self.currentQuestion.questionText forKey:@"Question"];
    
    NSArray *currentAnswers = [self.currentQuestion.answers allObjects];
    
    [currentAnswers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [dict setValue:((Answer *)obj).answerText forKey:[NSString stringWithFormat:@"Answer_%d", idx+1]];
        
        if ([((Answer *)obj).correctAnswer isEqual:@(YES)]) {
            self.currentCorrectAnswer = obj;
        }
    }];
    
    return [dict copy];
}

@end
