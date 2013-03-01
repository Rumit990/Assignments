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
#import "JSON.h"
#import "CetasTracker.h"

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

    
    //Initialize event object.
//    Event *event= [[Event alloc] init];
//    // Add event detail to dictionary similar to filling map in Java.
//    NSDictionary *eventDetail = [NSDictionary dictionaryWithObjectsAndKeys:
//                                 @"1000",@"tracker",@"2" ,@"trackerlevel", nil];
//    //Set event Detail
//    [event setEventDetail:eventDetail];
    NSMutableArray *events =[[NSMutableArray alloc] init];
    
    for (int i=0; i<= 7 ; i++) {
        //Initialize event object.
        Event *event= [[Event alloc] init];
        // Add event detail to dictionary similar to filling map in Java.
        NSDictionary *eventDetail = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"1000",@"tracker",@"2" ,@"trackerlevel", nil];
        //Set event Detail
        [event setEventDetail:eventDetail];
        [events addObject:event];
    }
    
    
    [[CetasTracker getDefaultTracker] logEvents:events];
    
   
    
}
-(IBAction)logout:(id)sender{
     [[CetasTracker getDefaultTracker] stopTracker];
}
@end
