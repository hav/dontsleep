//
//  ViewController.m
//  QuizBro
//
//  Created by Farshid Besharati on 2014-03-31.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "ViewController.h"
#import "BaseModel.h"
#import "DataManager.h"
#import "Question.h"
#import "Answer.h"

@interface ViewController ()

@property (nonatomic, strong) BaseModel *baseModel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor greenColor]];
    [[DataManager sharedInstance] seedDatabase];
    
    [[DataManager sharedInstance] managedObjectContext];
    NSDictionary *firstQ = [self.baseModel randomQuestionAndAnswers];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (BaseModel *)baseModel {
    if (!_baseModel) {
        _baseModel = [[BaseModel alloc] init];
    }
    
    return _baseModel;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSelectQuestion {
    
}

@end
