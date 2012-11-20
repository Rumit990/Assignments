//
//  ShoppingItemsViewController.m
//  TinyViewModule
//
//  Created by Chetan Sanghi on 16/11/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import "ShoppingItemsViewController.h"
#import "ShoppingItem.h"
#import "FilterViewController.h"


@implementation ShoppingItemsViewController

@synthesize shoppingItems;
@synthesize shoppingItemsView;
@synthesize shoppingItemsFilter;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"Shopping list";
        
        
        
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

-(void)populateShoppingItemsArrayWithData:(NSData *)shoppingData
{
    int count = 0;
    
    NSError * error = error;
    
    // tempprary array to receive the shopping items received from the URL
    
    NSArray *shoppingItemsTempArray = [NSJSONSerialization JSONObjectWithData:shoppingData options:kNilOptions error:&error];
    
    //check for the data retrieval
    
    NSLog(@"The amount of data is %d",shoppingItemsTempArray.count);
    
    for(NSDictionary * tempShoppingData in shoppingItemsTempArray)
    {   
        
        if(!self.shoppingItems)
        {
            self.shoppingItems = [[NSMutableArray alloc] init];
        }
        
        ShoppingItem * item = [[ShoppingItem alloc] init];
        
        [item createShoppingItem:tempShoppingData]; // to create shopping item instance from the dictionary.
        
        [self.shoppingItems addObject:item];
        
        //NSLog(@"self.shoppingItems.count = %d",self.shoppingItems.count);
        
    }
    
    NSLog(@"The no. of elements in the created array is : %d",self.shoppingItems.count);
    
}



-(void)fetchShoppingData
{
    // create URL and fetch JSON data , into an NSData instance.
    
    NSURL *shoppingDataUrl = [NSURL URLWithString:@"http://dev.tinyview.com:9080/api/rest/products?sort_by=popular"];
    
    NSData *shoppingData = [NSData dataWithContentsOfURL:shoppingDataUrl];
    
    [self populateShoppingItemsArrayWithData:shoppingData]; // see if the data is to be entered into the core data , if yes do it simple
    
    
}

-(void)createUI
{
    /*if(!self.scrollView)
    {
        
        //  TEST
        
        
        UIImage *testImage = [UIImage  imageNamed:@"Use.jpg"];
        
        UIImageView *view = [[UIImageView alloc] initWithImage:testImage];
        
        self.scrollView.contentSize = testImage.size;
        
        //self.scrollView = [[UIScrollView alloc] initWithFrame:<#(CGRect)#>];
        
        [self.scrollView addSubview:view];
        
        
        // TEST
        
    }*/
    
}

// doubt to be asked, what si the correct place for scroll view iniialization
// and about view did unload, when is it called

-(void)viewWillAppear:(BOOL)animated
{
    
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    self.shoppingItemsView.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    
    UIEdgeInsets scrollViewInsets = UIEdgeInsetsMake(40, 6, 20, 0);
    
    self.shoppingItemsView.scrollView.contentInset = scrollViewInsets;
    
    [self.shoppingItemsView createViewWithData:self.shoppingItems];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    // in order to reset the view from the beginning when the view appears next time
    
    self.shoppingItemsView.shoppingItemCount = 0;
    
    self.shoppingItemsView.shoppingItemRowCount = 0;
    
    self.shoppingItemsView.iconDowloaderArray = nil;
    
    for(UIView *subview in self.shoppingItemsView.subviews)
	{
		[subview removeFromSuperview];
		
	}
    
    self.shoppingItemsView.scrollView = nil;

}

-(void)filterButtonHandler
{
    
    
    NSLog(@"Handling apply button");
    
    FilterViewController *filterViewController = [[FilterViewController alloc] initWithStyle:UITableViewStyleGrouped];

    filterViewController.applyFilterDelegate = self;
    
    
    [self.navigationController pushViewController:filterViewController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStyleBordered target:self action:@selector(filterButtonHandler)];
    
    self.navigationItem.rightBarButtonItem = filterButton;
    
    
    [self fetchShoppingData];
    
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

/****---------DELEGATE METHODS-------------***/

-(void)selectedShoppingItemsFilter:(NSString *)selectedFilter
{
    // return to the previous view controller ( by popping )  where the filter is to be applied
    
    NSLog(@"Shopping items view controller, the selected filter is -----------------> %@",selectedFilter);
    
    self.shoppingItemsFilter = selectedFilter;
    
    [self.navigationController popViewControllerAnimated:YES]; 
    
}

/****---------DELEGATE METHODS-------------***/


@end
