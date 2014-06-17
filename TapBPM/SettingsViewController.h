//
//  SettingsViewController.h
//  TapBPM
//
//  Created by Mathias Novas on 25.05.14.
//  Copyright (c) 2014 Nettvever Novas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UITableViewController

- (IBAction)useAverageMode:(id)sender;
- (IBAction)roundNumbersMode:(id)sender;
- (IBAction)useProgress:(id)sender;

@property (strong, nonatomic) IBOutlet UISwitch *averageSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *roundNumbersSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *progressSwitch;

@end
