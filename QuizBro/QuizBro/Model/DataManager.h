//
//  DataManager.h
//  QuizBro
//
//  Created by Farshid Besharati on 2014-04-03.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+ (id)sharedInstance;

- (NSManagedObjectContext *)managedObjectContext;
- (void)seedDatabase;

@end
