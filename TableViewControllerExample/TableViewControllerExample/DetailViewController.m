//
//  DetailViewController.m
//  TableViewControllerExample
//
//  Created by Chetan Sanghi on 29/10/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

@synthesize selectedDrink,ingredients,directions, keyboardVisibilityFlag,selectedDrinkDetails,selectedIndexPath; // MODAL

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
    [self.selectedDrinkDetails setObject:self.nameOfDrink.text forKey:@"name"];
    [self.selectedDrinkDetails setObject:self.ingredients.text forKey:@"ingredients"];
    [self.selectedDrinkDetails setObject:self.directions.text forKey:@"directions"];
    
    [self.delegate updateChanges:self forIndexPath:self.selectedIndexPath];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrView.contentSize = self.view.frame.size; // scroll view size set to the size of the current view
    
    
    
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
     //   self.ingredients.editable = NO;
       // self.nameOfDrink.editable = NO;
        //self.directions.editable = NO;
        
        UIBarButtonItem *updateButton = [[UIBarButtonItem alloc] init];
    
        updateButton.title = @"Update";
        updateButton.target = self;
        updateButton.action = @selector(updateFields);
        
        self.navigationItem.rightBarButtonItem = updateButton;
    
    
    }
    
    self.nameOfDrink.text = self.selectedDrink;
    self.directions.text = self.selectedDrinkDirections;
    self.ingredients.text = self.selectedDrinkIngredients;
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)keyboardDidShow:(id)notification
{
    NSLog(@"Notification for the keyboard did show received");
    
    if(keyboardVisibilityFlag)
    {
        NSLog(@"Keyboard is already visible");
        return;
    }
    
    NSLog(@"Will resize the current view for the keyboard to fit in");
    
    NSDictionary *info = [notification userInfo];  
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    CGFloat keyboardTop = keyboardRect.origin.y;
    CGRect viewFrame = self.view.bounds;
    viewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
    self.scrView.frame  = viewFrame;
    self.keyboardVisibilityFlag = YES;

}

-(void)keyBoardDidHide:(id)notification
{
    if(!keyboardVisiblityFlag)
    {
        NSLog(@"Keyboard is already on the screen");
        return;
    }
    
    self.scrView.frame = self.view.frame;
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    
    [super viewWillAppear:animated];
    
        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil]; 
    
    
    NSLog(@"keyboard event will be generated");
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    self.keyboardVisibilityFlag = NO;
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
}

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
