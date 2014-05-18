//
//  GameViewController.h
//  QuizBro
//
//  Created by Boris Kachscovsky on 4/2/14.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

@interface GameViewController : UIViewController <BaseModelProtocol>

@property (weak, nonatomic) IBOutlet UIView *leftContainer;
@property (weak, nonatomic) IBOutlet UIView *rightContainer;

@end
