//
//  ShoppingItemDetailsViewController.m
//  TinyViewModule
//
//  Created by Vipin Joshi on 21/11/11.
//  Copyright (c) 2011 sanghichetan@yahoo.com. All rights reserved.
//

#import "ShoppingItemDetailsViewController.h"
#import "ShoppingItem.h"
#import "ShoppingItemDetailsViewController.h"
#import "ShoppingItem.h"
#import "Common.h"

@implementation ShoppingItemDetailsViewController


@synthesize shoppingItem;
@synthesize itemImageView;
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andItem:(ShoppingItem *)item
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        shoppingItem = item;
        
        self.navigationItem.titleView = [Common createLabelWithTitle:@"Item details"];
        
        
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

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.scrollView.contentSize = self.shoppingItem.itemImage.size;
    
    self.itemImageView.image = self.shoppingItem.itemImage;
    
    
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    if(shoppingItem)
    {
        NSLog(@"the object is coming here %@",shoppingItem.imageURL.description);
        
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
