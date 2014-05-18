//
//  ResultAnswerPopUpView.h
//  QuizBro
//
//  Created by Christian Danheimer Furedal on 2014-04-09.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  The popup window with the result of our move
 */
@interface ResultAnswerPopUpView : UIView

/**
 *  Creates a popup with a given result
 *
 *  @param result YES for a sucessful result, NO for an unsucessful result
 */
-(void)initWithResult:(BOOL)result;

@end
