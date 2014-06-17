//
//  SettingsViewController.m
//  TapBPM
//
//  Created by Mathias Novas on 25.05.14.
//  Copyright (c) 2014 Nettvever Novas. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize averageSwitch, roundNumbersSwitch, progressSwitch;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    BOOL useAverage = [[NSUserDefaults standardUserDefaults] boolForKey:@"toggleAverage"];
    BOOL roundNumbers = [[NSUserDefaults standardUserDefaults] boolForKey:@"toggleRoundNumbers"];
    BOOL showProgress = [[NSUserDefaults standardUserDefaults] boolForKey:@"toggleProgress"];
    
    averageSwitch.on = useAverage;
    roundNumbersSwitch.on = roundNumbers;
    progressSwitch.on = showProgress;
}

- (IBAction)useAverageMode:(id)sender
{
    UISwitch *toggle = (UISwitch*) sender;

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [userDefaults setBool:toggle.on forKey:@"toggleAverage"];
    [userDefaults synchronize];
}

- (IBAction)roundNumbersMode:(id)sender
{
    UISwitch *toggle = (UISwitch*) sender;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setBool:toggle.on forKey:@"toggleRoundNumbers"];
    [userDefaults synchronize];
}

- (IBAction)useProgress:(id)sender
{
    UISwitch *toggle = (UISwitch*) sender;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setBool:toggle.on forKey:@"toggleProgress"];
    [userDefaults synchronize];
}

@end
