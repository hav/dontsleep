//
//  DataManager.h
//  QuizBro
//
//  Created by Farshid Besharati on 2014-04-03.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

/**
 *  Allows access to a singleton of DataManager
 *
 *  @return DataManager singleton
 */
+ (id)sharedInstance;

/**
 *  Allows easy access to the Core Data context used throughout the application.
 *
 *  @return The apps NSManagedObjectContext
 */
- (NSManagedObjectContext *)managedObjectContext;

/**
 *  Seeds the database when the application is ran for the first time.
 */
- (void)seedDatabase;

@end
