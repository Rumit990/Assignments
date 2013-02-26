//
//  ViewController.m
//  CetasDataIngestionTestApp
//
//  Created by Prateek Pradhan on 25/02/13.
//  Copyright (c) 2013 Cetas Software. All rights reserved.
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
