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
@property (nonatomic) BOOL titleAnimating;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic) NSString* questionMarkText;

@property (weak, nonatomic) IBOutlet UIButton *categoryButton1;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton2;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton3;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton4;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton5;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton6;
@property (weak, nonatomic) IBOutlet UIPickerView *timerPickerView;

@end

@implementation MenuViewController

/**
 *  Preforms some of the initial button animations
 *
 *  @param animated YES for animated NO for no
 */
- (void)viewDidAppear:(BOOL)animated
{
    self.animating = YES;
    
    [self displayButton:self.startButton withText:@"Start" andDelay:0.5];
    [self displayButton:self.categoryButton1 withText:@"category1" andDelay:0.5];
    [self displayButton:self.categoryButton2 withText:@"category2" andDelay:0.5];
    [self displayButton:self.categoryButton3 withText:@"category3" andDelay:0.5];
    [self displayButton:self.categoryButton4 withText:@"category4" andDelay:0.5];
    [self displayButton:self.categoryButton5 withText:@"category5" andDelay:0.5];
    [self displayButton:self.categoryButton6 withText:@"category6" andDelay:0.5];
    
    
    [self performSelectorInBackground:@selector(animationLoop) withObject:nil];
}

/**
 *  Returns the text for the question mark (getter)
 *
 *  @return Returns the text for the question mark
 */
- (NSString *)questionMarkText
{
    if (!_questionMarkText){
        _questionMarkText = @"?";
    }
    return _questionMarkText;
}

/**
 *  Animates the question marks as they fall down the screen
 */
- (void)animateQuestionMarks
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // Initial Values
        CGSize size = self.view.bounds.size;
        int x = [self randomIntBetween:0 and:size.width];
        int y = -70;
        
        UILabel* questionMark = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 70, 70)];
        questionMark.text = self.questionMarkText;
        questionMark.textAlignment = NSTextAlignmentCenter;
        
        // Changes
        NSMutableAttributedString *atbQuestionText = [[NSMutableAttributedString alloc] initWithString:questionMark.text];
        [atbQuestionText addAttribute:NSFontAttributeName
                                value:[UIFont boldSystemFontOfSize:[self randomIntBetween:12 and:24]]
                                range:NSMakeRange(0, questionMark.text.length)];
        [atbQuestionText addAttribute:NSForegroundColorAttributeName
                                value:[UIColor colorWithRed:[self randomDouble] green:[self randomDouble] blue:[self randomDouble] alpha:1.0]
                                range:NSMakeRange(0,questionMark.text.length)];
        
        [questionMark setAttributedText:atbQuestionText.copy];
        [self.view addSubview:questionMark];
        
        // Animation
        [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             questionMark.alpha = 0.1;
                             questionMark.frame = CGRectMake(x,size.height + 30,70, 70);
                         }
                         completion:nil];
    });
    [NSThread sleepForTimeInterval:(arc4random() % 10) * .005];
}

/**
 *  Loop that contains our animations
 */
- (void)animationLoop
{
    while(self.animating)
    {
        [self animateQuestionMarks];
    }
}
/**
 *  Returns a random double
 *
 *  @return A pseudo random double
 */
- (double)randomDouble
{
    return drand48();
}

/**
 *  Returns a random int between two values
 *
 *  @param low  the lower bound for the random int
 *  @param high the higher bound for the random int
 *
 *  @return random int
 */
- (int)randomIntBetween:(int)low and:(int)high
{
    return (arc4random() % (high - low)) + low;
}

/**
 *  UIKit function, called after class is loaded
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 *  Animations used to display the start button
 *
 *  @param text Start button's given text
 */
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

/**
 *  Displays a given button with a given text and delay
 *
 *  @param button The button to be displayed
 *  @param text   The text to be displayed on the button
 *  @param delay  The amount of delay before the animation takes place
 */
- (void)displayButton:(UIButton*)button withText:(NSString*)text andDelay:(float)delay{
    button.alpha = 0;
    
    NSAttributedString* atbString = [[NSAttributedString alloc] initWithString:text attributes:nil];
    [button setAttributedTitle:atbString forState:UIControlStateNormal];
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.cornerRadius = 8;
    button.layer.masksToBounds = YES;
    
    [UIView animateWithDuration:0.3 delay:delay options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ button.alpha = 1;}
                     completion:nil];
}

/**
 *  It's a secret!
 *
 *  @param sender Easter egg :)
 */
- (IBAction)secretQPressed:(id)sender {
    self.questionMarkText = @"?";
}

/**
 *  It's a secret!
 *
 *  @param sender Easter Egg :)
 */
- (IBAction)secretOPressed:(id)sender {
    self.questionMarkText = @"Bro";
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

/**
 *  Before we move on to the next view, this method does some clean up
 *
 *  @param segue  The type of animation we are moving to
 *  @param sender The class we are moving to
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    self.animating = NO;
}

@end
