//
//  GameViewController.m
//  QuizBro
//
//  Created by Christian Danheimer Furedal on 2014-03-31.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "GameViewController.h"
#import "ScoreViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

-(void)deviceRotated:(NSNotification *)note{
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    CGFloat rotationAngleLeft = M_PI;
    CGFloat rotationAngleRight = 0;
    
    self.leftContainer.transform = CGAffineTransformMakeRotation(rotationAngleLeft);
    self.rightContainer.transform = CGAffineTransformMakeRotation(rotationAngleRight);
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceRotated:) name:UIDeviceOrientationDidChangeNotification object:nil];
}
-(void)viewDidUnload{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}


- (void)addChildViewController:(UIViewController *)childController {
    [super addChildViewController:childController];
    /*
    if ([childController isKindOfClass:[ScoreViewController class]]) {
        
    }
     */
}


@end