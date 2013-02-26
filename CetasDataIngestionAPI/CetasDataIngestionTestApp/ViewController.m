//
//  ViewController.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import "ViewController.h"
#import "Config.h"
#import "Event.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)trackButtonPressed:(id)sender{
    NSLog(@"CetasDataIngestionTestApp:  Track Button Pressed");
    [Config test];
    Event *event = [[Event alloc] init];


    
}

@end
