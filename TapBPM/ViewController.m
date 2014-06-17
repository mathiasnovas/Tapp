//
//  ViewController.m
//  TapBPM
//
//  Created by Mathias Novas on 21.05.14.
//  Copyright (c) 2014 Nettvever Novas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSDate *currentTime;
@property (strong, nonatomic) NSMutableArray *bpmValues;
@property (assign, nonatomic) float bpmAverage;
@property (assign, nonatomic) float progress;

@property (strong, nonatomic) NSMutableArray *savedValues;

- (float)averageBPM;

@end

@implementation ViewController
@synthesize tapProgress, bpmLabel, bpmTextLabel, currentTime, bpmValues, bpmAverage, savedValues;

int listSize = 10;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bpmLabel.text = @"Tapp!";
    self.bpmTextLabel.text = @"";
    self.bpmAverage = 0;

    self.bpmValues = [NSMutableArray array];
    self.tapProgress.progress = 0;
    self.tapProgress.hidden = true;
}

- (IBAction)press:(id)sender
{
}

- (IBAction)tap:(id)sender
{
    [UIView beginAnimations:@"rippleEffect" context:NULL];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:(UIViewAnimationTransition) 110 forView:self.view cache:NO];
    [UIView commitAnimations];
    
    NSDate *now = [NSDate date];
    NSTimeInterval elapsed;
    float bpm;
    
    BOOL showProgress = [[NSUserDefaults standardUserDefaults] boolForKey:@"toggleProgress"];
    
    if (self.currentTime) {
        elapsed = [now timeIntervalSinceDate:self.currentTime];
        bpm = 60 / elapsed;
        
        if (elapsed > 2) {
            [self.bpmValues removeAllObjects];
            self.progress = 0;
        }
        
        [self.bpmValues addObject:[NSNumber numberWithFloat:bpm]];
        
        if ([self.bpmValues count] > listSize) {
            [self.bpmValues removeObjectAtIndex:0];
        }
        
        BOOL useAverage = [[NSUserDefaults standardUserDefaults] boolForKey:@"toggleAverage"];
        BOOL roundNumbers = [[NSUserDefaults standardUserDefaults] boolForKey:@"toggleRoundNumbers"];
        
        self.bpmAverage = useAverage ? [self averageBPM] : bpm;
        self.bpmAverage = roundNumbers ? roundf(self.bpmAverage) : self.bpmAverage;
        
        CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        pulse.fromValue = [NSNumber numberWithFloat:1.0];
        pulse.toValue = [NSNumber numberWithFloat:0.9];
        
        CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fade.fromValue = [NSNumber numberWithFloat:1.0];
        fade.toValue = [NSNumber numberWithFloat:0.4];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        
        group.duration = 60 / self.bpmAverage;
        group.repeatCount = HUGE_VALF;
        group.autoreverses = NO;
        group.animations = [NSArray arrayWithObjects:pulse, fade, nil];
        
        [self.bpmLabel.layer addAnimation:group forKey:@"animateOpacity"];
        
        NSString *bpmText = roundNumbers ? @"%.0f" : @"%.2f";
        
        self.bpmLabel.text = [NSString stringWithFormat:bpmText, self.bpmAverage];
        self.bpmTextLabel.text = @"BPM";
    } else {
        self.bpmTextLabel.text = @"Again!";
    }
    
    self.currentTime = now;
    
    if (showProgress) {
        self.currentTime = now;
        
        if (self.progress > 0) {
            self.progress = self.progress + 0.075;
        } else {
            self.tapProgress.hidden = false;
            self.progress = 0.1;
        }
        
        [self.tapProgress setProgress:self.progress animated:YES];
        
        if (self.tapProgress.progress == 1) {
            self.tapProgress.hidden = true;
        }
    } else {
        self.tapProgress.hidden = true;
    }
}

- (float)averageBPM
{
    float sum = 0;
    
    for (int i = 0; i < [self.bpmValues count]; i++) {
        sum += [(NSNumber *)[self.bpmValues objectAtIndex:i] floatValue];
    }
    
    return sum / [self.bpmValues count];
}

@end
