//
//  ViewController.m
//  TestWrapping
//
//  Created by Prateek Pradhan on 04/07/13.
//  Copyright (c) 2013 Tinyview. All rights reserved.
//

#import "ViewController.h"
#import "WrappingApp.h"

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
-(IBAction)buttonClicked:(id)sender{
    WrappingApp *app = [[WrappingApp alloc] init];
    [app addNumbers];
}
@end
