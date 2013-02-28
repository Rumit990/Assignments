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
    Config *config = [Config getDefaultInstance];
    [config setUserName:@"someone"];
    [config setUserId:@"userid"];
    CetasTracker *tracker = [[CetasTracker alloc] initWithApiKey:@"mq28uQr94zM5yHMrBWGX5P3j+pNajzT9StMd+WoEyDsJj40U+ebzS5k0Nj1CCVc6efnohnFJeOOyWf0KAxqeD7RH5x+hB8dEOio8HQOWMjCJZnTV22yTOLBCeTsk+h1GdMeE1KOTl2X7USpLVUk6bw==" config:config];
   

    
}

@end
