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

@property (nonatomic) NSInteger *myScore;

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
        
        for (int i = 0; i < CORRECT_ANSWER_BONUS; i++) {
            [self.gameModel scoreAddedForPlayer:self];
        }
        
        return YES;
    }
    
    for (int i = 0; i < WRONG_ANSWER_PENALTY; i++) {
        [self.gameModel scoreSubtractedForPlayer:self];
    }
    self.myScore = self.myScore - WRONG_ANSWER_PENALTY;
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

#pragma mark - Score

- (NSInteger *) getScore{
    return self.myScore;
}


@end
