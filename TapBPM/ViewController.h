//
//  ViewController.h
//  TapBPM
//
//  Created by Mathias Novas on 21.05.14.
//  Copyright (c) 2014 Nettvever Novas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *bpmLabel;
@property (strong, nonatomic) IBOutlet UILabel *bpmTextLabel;
@property (strong, nonatomic) IBOutlet UIProgressView *tapProgress;

- (IBAction)tap:(id)sender;
- (IBAction)press:(id)sender;

@end
