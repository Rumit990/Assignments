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

@implementation ShoppingItemsViewController

@synthesize shoppingItems;
@synthesize scrollView;
@synthesize shoppingItemsFilter;
@synthesize iconDownloaderArray;
@synthesize arrayOfItemPortlets;

-(NSMutableArray *)arrayOfItemPortlets
{
    if(!arrayOfItemPortlets)
    {
        arrayOfItemPortlets = [[NSMutableArray alloc] init];
    }
    return arrayOfItemPortlets;
}

-(void)setArrayOfItemPortlets:(NSMutableArray *)receivedArray
{
    arrayOfItemPortlets = receivedArray;
}

-(NSMutableArray *)iconDownloaderArray
{
    if(!iconDownloaderArray)
    {
        iconDownloaderArray = [[NSMutableArray alloc] init];
    }
    return iconDownloaderArray;
}

-(void)setIconDownloaderArray:(NSMutableArray *)receivedArray
{
    iconDownloaderArray = receivedArray;
}


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
        
        [item initWithDictionary:tempShoppingData andIndex:count];; // to create shopping item instance from the dictionary.
        
        [self.shoppingItems addObject:item];
        
        //NSLog(@"self.shoppingItems.count = %d",self.shoppingItems.count);
         
         count++;
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

    
}

-(void)viewDidDisappear:(BOOL)animated
{
    // in order to reset the view from the beginning when the view appears next time
    
    //self.shoppingItemsView.shoppingItemCount = 0;
//    
//    self.shoppingItemsView.shoppingItemRowCount = 0;
    
   // self.shoppingItemsView.iconDowloaderArray = nil;
    
    //self.shoppingItemsView.arrayOfItemViews = nil;
    //    for(UIView *subview in self.shoppingItemsView.subviews)
//	{
//		[subview removeFromSuperview];
//		
//	}
//    
//    self.shoppingItemsView.scrollView = nil;


}

-(void)filterButtonHandler
{
    
    
    NSLog(@"Handling apply button");
    
    FilterViewController *filterViewController = [[FilterViewController alloc] initWithStyle:UITableViewStyleGrouped];

    filterViewController.applyFilterDelegate = self;
    
    
    [self.navigationController pushViewController:filterViewController animated:YES];
}


#define gapInRows 8
#define gapInItems 8
#define frameWidth 150
#define frameHeight 190


-(void)createViewWithData
{
    int count = 0;
    
    CGRect itemViewFrame = CGRectMake(0, 0, frameWidth, frameHeight);
    
    CGFloat scrollViewContentSize = (gapInRows + itemViewFrame.size.height) * ((self.shoppingItems.count + 1) / 2);
    
    self.scrollView.contentSize = CGSizeMake(320.0, scrollViewContentSize);
    
    //[self addSubview:self.scrollView];
    
    
    for(ShoppingItem *item in shoppingItems)
    {
        
        IconDownloader *downloader = [[IconDownloader alloc] init];
        
        downloader.shoppingItem = item;
        
        downloader.delegate = self;
     
        
        [downloader startDownload];
        
        [self.iconDownloaderArray addObject:downloader];
        
        if(count%2 == 0)
        {
            
            itemViewFrame.origin.x = 0;
            
            ProductPortletCreator *itemView = [[ProductPortletCreator alloc] initWithFrame:itemViewFrame andIndex:count];
            
            itemView.shoppingItem = item;
            
            itemView.productPortletCreatorDelegate = self;      
            
            [self.arrayOfItemPortlets addObject:itemView];
            [self.scrollView addSubview:itemView];
            
        }
        
        else
        {
            
            itemViewFrame.origin.x = itemViewFrame.size.width + gapInItems;
            

            //            ProductPortletCreator *itemView = [[ProductPortletCreator alloc] initWithFrame:itemViewFrame andIndex:count];
            
             ProductPortletCreator *itemView = [[ProductPortletCreator alloc] initWithFrame:itemViewFrame];
            
            itemView.shoppingItem = item;
            
            itemView.productPortletCreatorDelegate = self;    
            
            
            [self.arrayOfItemPortlets addObject:itemView];
            [self.scrollView addSubview:itemView];
            
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
    
    [self createViewWithData];
    
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
    
    NSLog(@"Shopping items view controller, the selected filter is -----------------> %@",selectedFilter);
    
    self.shoppingItemsFilter = selectedFilter;
    
    [self.navigationController popViewControllerAnimated:YES]; 
    
}

/************--FILTER VIEW CONTROLLER DELEGATE METHODS--***************/




/*******************--PRODUCT PORTLET CREATOR DELEGATE METHODS--*********************/

-(void)shortlistButtonHandler:(ShoppingItem *)shortlistedItem
{
    NSLog(@"Shortlist button pressed --------------------- &&&&&&&& *******");
    
    
    ShoppingItemDetailsViewController *itemDetailsViewController = [[ShoppingItemDetailsViewController alloc] initWithNibName:@"ShoppingItemDetailsViewController" bundle:nil andItem:shortlistedItem];
    
    [self.navigationController pushViewController:itemDetailsViewController animated:YES];
    
}    


-(void)buyButtonHandler:(ShoppingItem *)item
{
    NSLog(@"buy button pressed ---------------------------&&&&&&&&&*******");
    
}


/*******************--PRODUCT PORTLET CREATOR DELEGATE METHODS--*********************/




/**********************ICON DOWNLOADER DELEGATE MEHTODS*********************/

-(void)appImageDidLoad:(NSIndexPath *)indexPath iconDownloader:(ShoppingItem *)item
{

    [[self.arrayOfItemPortlets objectAtIndex:item.itemIndex] setShoppingItem:item];
    [[[self.arrayOfItemPortlets objectAtIndex:item.itemIndex] shoppingItemImageView] setImage:item.itemImage];
    
    
}


/**********************ICON DOWNLOADER DELEGATE MEHTODS*********************/





@end
