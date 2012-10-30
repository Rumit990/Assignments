//
//  DetailViewController.m
//  TableViewControllerExample
//
//  Created by Chetan Sanghi on 29/10/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

@synthesize selectedDrink,ingredients,directions, keyboardVisibilityFlag; // MODAL

@synthesize nameOfDrink,selectedDrinkDirections,selectedDrinkIngredients,scrView ; // OUTLETS

@synthesize delegate;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)addChanges
{
    
    [self.delegate addChanges:self];
}

-(void)discardChanges
{
     
    //[self.delegate discardChanges:self];

    [self dismissModalViewControllerAnimated:YES];
}

-(void)updateFields
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrView.contentSize = self.view.frame.size;
    
    NSLog(@"In the view did load");
    
    if(!selectedDrink)
    {
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] init];
        cancelButton.title = @"Cancel";
    
         
        cancelButton.target = self;
    
        cancelButton.action = @selector(discardChanges);
    
        self.navigationItem.leftBarButtonItem = cancelButton;
    
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] init];
        
        saveButton.title = @"Save";
    
        saveButton.target = self;
    
        saveButton.action = @selector(addChanges);
    
        self.navigationItem.rightBarButtonItem = saveButton; 
    }
    else
    {
        self.ingredients.editable = NO;
        self.nameOfDrink.editable = NO;
        self.directions.editable = NO;
        
        //UIBarButtonItem *updateButton = [[UIBarButtonItem alloc] init];
    
        //updateButton.title = @"Update";
        //updateButton.target = self;
       // updateButton.action = @selector(updateFields);
        
        //self.navigationItem.rightBarButtonItem = updateButton;
    
    
    }
    
    self.nameOfDrink.text = self.selectedDrink;
    self.directions.text = self.selectedDrinkDirections;
    self.ingredients.text = self.selectedDrinkIngredients;
    
    
    // Do any additional setup after loading the view from its nib.
}

/*-(void)keyBoardDidShow:(id)notification
{
    NSLog(@"Notification for the keyboard did show received");
}

-(void)keyBoardDidHide:(id)notification
{
    
}
*/
/*
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
        
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil]; 
  //  NSlog(@"keyboard event will be generated");
    

    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    //self.keyboardVisibilityFlag = NO;
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
}
*/
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
