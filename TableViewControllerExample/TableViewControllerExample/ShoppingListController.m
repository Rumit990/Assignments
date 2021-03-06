//
//  ShoppingListController.m
//  TableViewControllerExample
//
//  Created by Chetan Sanghi on 31/10/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import "ShoppingListController.h"

@implementation ShoppingListController

@synthesize itemId, itemName, noOfItemsSelected;  //outlets

@synthesize selectedItem;

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

-(void)createUI
{
    self.itemName.text = self.selectedItem.itemName;
    self.itemId.text = self.selectedItem.itemId;
    self.noOfItemsSelected.text = self.selectedItem.itemCount;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createUI];
    
    
    // Do any additional setup after loading the view from its nib.
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
