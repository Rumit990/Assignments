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
#import "IconDownloader.h"
#import "ProductPortletCreator.h"
#import "ShoppingItemDetailsViewController.h"
#import "ShoppingItemPortletViewController.h"
#import "Common.h"

@implementation ShoppingItemsViewController

@synthesize shoppingItems;
@synthesize scrollView;
@synthesize shoppingItemsFilter;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.navigationItem.titleView = [Common createLabelWithTitle:@"Shopping Items"];
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
    
    // CREATE SHOPPING OBJECTS FROM THE FETCHED ARRAY OF JSON DATA AND CREATE OBJECTS OF SHOPPING ITEMS
    
    NSLog(@"The amount of data is %d",shoppingItemsTempArray.count);
    
    for(NSDictionary * tempShoppingData in shoppingItemsTempArray)
    {
        
        
        if(!self.shoppingItems)
        {
            self.shoppingItems = [[NSMutableArray alloc] init];
        }
        
        ShoppingItem * item = [[ShoppingItem alloc] init];
        
        [item initWithDictionary:tempShoppingData andIndex:count];; // to create shopping item instance from the dictionary.
        
        [self.shoppingItems addObject:item];
        
        //NSLog(@"self.shoppingItems.count = %d",self.shoppingItems.count);
         
         count++;
    }
    
    NSLog(@"The no. of elements in the created array is : %d",self.shoppingItems.count);
    
}



-(void)fetchShoppingData
{
    // CREATE URL AND FETCH JSON DATA , INTO AN NSData INSTANCE.
    
    NSURL *shoppingDataUrl = [NSURL URLWithString:@"http://dev.tinyview.com:9080/api/rest/products?sort_by=popular"];
    
    NSData *shoppingData = [NSData dataWithContentsOfURL:shoppingDataUrl];
    
    [self populateShoppingItemsArrayWithData:shoppingData]; 
    
    
}

-(void)filterButtonHandler
{
    
    
    NSLog(@"Handling apply button");
    
    FilterViewController *filterViewController = [[FilterViewController alloc] initWithStyle:UITableViewStyleGrouped];

    filterViewController.applyFilterDelegate = self;
    
    
    [self.navigationController pushViewController:filterViewController animated:YES];
}


//  VALUES FOR SETTING THE INITIAL FRAMES

#define gapInRows 8
#define gapInItems 8
#define frameWidth 150
#define frameHeight 190
#define leftMargin 6
#define topMargin 6


-(void)createViewControllersWithData
{
    int count = 0;
    
    CGRect itemViewFrame = CGRectMake(leftMargin, topMargin, frameWidth, frameHeight);  // BASE FRAME FOR THE PORTLETS
    
    CGFloat scrollViewContentSize = (gapInRows + itemViewFrame.size.height) * ((self.shoppingItems.count + 1) / 2);
    
    self.scrollView.contentSize = CGSizeMake(320.0, scrollViewContentSize);
    
    //[self addSubview:self.scrollView];
    
    
    for(ShoppingItem *item in shoppingItems)
    {
        
        
        if(count%2 == 0)  // CONDITION FOR POSITIONING THE ODD NUMBERED ELEMENT 
        {
            
            itemViewFrame.origin.x = leftMargin;  // EACH TIME IN THE FOR LOOP THE ODD NUMBERED ELEMENT IS TO BE SET TO START FROM THE LEFT MARGIN
            
            
            
            ShoppingItemPortletViewController *shoppingItemPortletViewCon = [[ShoppingItemPortletViewController alloc] initWithNibName:@"ShoppingItemPortletViewController" bundle:nil andItem:item];
            

            shoppingItemPortletViewCon.view.frame = itemViewFrame;            

            [self addChildViewController:shoppingItemPortletViewCon];
            
            [self.scrollView addSubview:shoppingItemPortletViewCon.view];
                        
        }
        
        else
        {
            itemViewFrame.origin.x = leftMargin + itemViewFrame.size.width + gapInItems; // STARTING X COORDINATE FOR THE EVEN NUMBERED ELEMENT 
                    
            ShoppingItemPortletViewController *shoppingItemPortletViewCon = [[ShoppingItemPortletViewController alloc] initWithNibName:@"ShoppingItemPortletViewController" bundle:nil andItem:item];
            
            
            shoppingItemPortletViewCon.view.frame = itemViewFrame;            
            
            [self addChildViewController:shoppingItemPortletViewCon];
            
            [self.scrollView addSubview:shoppingItemPortletViewCon.view];
            
            // each time a portlet for an even number is created, the  index is updated
            
            itemViewFrame.origin.y = itemViewFrame.origin.y + itemViewFrame.size.height + gapInRows;
            
            //self.shoppingItemRowCount++; // each time an even row item is drawn, the row count is set in order to change the frames for the next row
            
        }
        
        count++;
        
        
        
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStyleBordered target:self action:@selector(filterButtonHandler)];
    
    self.navigationItem.rightBarButtonItem = filterButton;
    
    
    [self fetchShoppingData];
    
    //CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    //self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    
    //UIEdgeInsets scrollViewInsets = UIEdgeInsetsMake(40, 6, 20, 0);
    
    //self.scrollView.contentInset = scrollViewInsets;
    
    [self createViewControllersWithData];
    
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


/************--FILTER VIEW CONTROLLER DELEGATE METHODS--***************/

-(void)selectedShoppingItemsFilter:(NSString *)selectedFilter
{
    // return to the previous view controller ( by popping )  where the filter is to be applied
    
    NSLog(@"Shopping items view controller, the selected filter is : %@",selectedFilter);
    
    self.shoppingItemsFilter = selectedFilter;
    
    [self.navigationController popViewControllerAnimated:YES]; 
    
}

/************--FILTER VIEW CONTROLLER DELEGATE METHODS--***************/




/*******************--PRODUCT PORTLET CREATOR DELEGATE METHODS--*********************/

-(void)shortlistButtonHandler:(ShoppingItem *)shortlistedItem
{
    NSLog(@"Shortlist button pressed");
    
    
    ShoppingItemDetailsViewController *itemDetailsViewController = [[ShoppingItemDetailsViewController alloc] initWithNibName:@"ShoppingItemDetailsViewController" bundle:nil andItem:shortlistedItem];
    
    [self.navigationController pushViewController:itemDetailsViewController animated:YES];
    
}    


-(void)buyButtonHandler:(ShoppingItem *)item
{
    NSLog(@"Buy button pressed");
    
}


/*******************--PRODUCT PORTLET CREATOR DELEGATE METHODS--*********************/


@end
