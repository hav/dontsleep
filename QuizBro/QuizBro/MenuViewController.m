//
//  MenuViewController.m
//  QuizBro
//
//  Created by Boris Kachscovsky on 4/9/14.
//  Copyright (c) 2014 quizbro. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@property (nonatomic) BOOL animating;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation MenuViewController

- (void)viewDidAppear:(BOOL)animated
{
    
    [self performSelector:@selector(displayStartButton:)
               withObject:@"Start"
               afterDelay:0.5];
    
    self.animating = YES;
    [self performSelectorInBackground:@selector(animationLoop) withObject:nil];
}

- (void)animationLoop
{
    while(self.animating)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            CGSize size = self.view.bounds.size;
            int x = [self randomIntBetween:30 and:size.width];
            int y = -30;

            UILabel* questionMark = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 30, 30)];
            questionMark.text = @"?";
            
            questionMark.textAlignment = NSTextAlignmentCenter;
            NSMutableAttributedString *atbQuestionText = [[NSMutableAttributedString alloc] initWithString:questionMark.text];
            [atbQuestionText addAttribute:NSFontAttributeName
                                    value:[UIFont systemFontOfSize:[self randomIntBetween:12 and:24]]
                                    range:NSMakeRange(0, questionMark.text.length)];
            [questionMark setAttributedText:atbQuestionText.copy];
            questionMark.alpha = 0.5;
            
//            If we want it green, like in the matrix!
//            questionMark.attributedText = [[NSAttributedString alloc] initWithString:@"?" attributes:@{NSForegroundColorAttributeName : [UIColor greenColor]}];
            [self.view addSubview:questionMark];
            
            [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 questionMark.alpha = 0.1;
                                 questionMark.frame = CGRectMake(x,size.height + 30,30, 30);
                             }
                             completion:nil];
        });
        float randomFloat = (arc4random() % 10) * .005;
        [NSThread sleepForTimeInterval:randomFloat];
    }
}

- (int)randomIntBetween:(int)low and:(int)high
{
    return (arc4random() % (high - low)) + low;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)displayStartButton:(NSString*)text
{
    self.startButton.alpha = 0;
    
    NSAttributedString* atbString = [[NSAttributedString alloc] initWithString:text attributes:nil];
    [self.startButton setAttributedTitle:atbString forState:UIControlStateNormal];
    self.startButton.layer.borderWidth = 1;
    self.startButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.startButton.layer.cornerRadius = 8;
    self.startButton.layer.masksToBounds = YES;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ self.startButton.alpha = 1;}
                     completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    self.animating = NO;
}

@end
