//
//  UserDetailsViewController.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//


#import "UserDetailsViewController.h"
#import "CountriesViewController.h"
#import "CetasEvent.h"


@interface UserDetailsViewController ()

@end

@implementation UserDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(id)initWithDelegate:(id)delegate{
    
    if (self) {
        // Custom initialization
        self.title = @"Travel Guide";
        self.checkInDelegate = delegate;
    }
    return self;
  
    
    
}



-(void)viewWillAppear:(BOOL)animated
{
    
    
    [super viewWillAppear:animated];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [self resignFirstResponder];
}

-(void)viewDidDisappear:(BOOL)animated{
    
    self.invalidIDMessage.text = nil;
}

-(IBAction)checkInButtonPressed:(id)sender{
        
    
    if([self.userIDField.text isEqualToString:@""] || (self.userIDField.text.length < 6)){
        
        self.invalidIDMessage.text = @"The user ID should have atleast 6 characters.";
        [self resignFirstResponder];
        return;
    }
    
    [self.checkInDelegate checkInWithUserName:[self.userNameField text] userId:[self.userIDField text] userAge:[self.userAgeField text]];
    CountriesViewController *countriesViewController = [[CountriesViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:countriesViewController animated:YES];
    
}


#pragma TextFieldDelegate

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}
@end
