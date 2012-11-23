//
//  ShoppingItemPortletViewController.m
//  TinyViewModule
//
//  Created by Vipin Joshi on 21/11/11.
//  Copyright (c) 2011 sanghichetan@yahoo.com. All rights reserved.
//

#import "ShoppingItemPortletViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ShoppingItemDetailsViewController.h"
#import "Common.h"

@implementation ShoppingItemPortletViewController

@synthesize shoppingItem;
@synthesize iconDownloader;
@synthesize shoppingItemImageView;
@synthesize shortlistButton;
@synthesize buyButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)shortlistButtonHandler
{
    NSLog(@"Shortlist button pressed");
    
    
    ShoppingItemDetailsViewController *itemDetailsViewController = [[ShoppingItemDetailsViewController alloc] initWithNibName:@"ShoppingItemDetailsViewController" bundle:nil andItem:self.shoppingItem];
    
    [self.navigationController pushViewController:itemDetailsViewController animated:YES];
    
}    


-(void)buyButtonHandler
{
    NSLog(@"Buy button pressed");
    
}



-(void)createUI
{
    //UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 190)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.layer.borderColor = [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:1.0].CGColor;
    
    self.view.layer.borderWidth = 1.0f;
    
    
    CGRect imageViewFrame = CGRectMake(5, 5, 140, 140);
    
    self.shoppingItemImageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    
    [self.view addSubview:self.shoppingItemImageView];
    

    CGRect shortlistButtonFrame = CGRectMake(1, 160, 73.5, 30);
    CGRect buyButtonFrame = CGRectMake(75.5, 160, 73.5, 30);
    
    
    self.shortlistButton = [Common createPortletButtonWithTitle:@"Shortlist"];
    self.buyButton = [Common createPortletButtonWithTitle:@"Buy"];
    
    [self.shortlistButton addTarget:self action:@selector(shortlistButtonHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.buyButton addTarget:self action:@selector(buyButtonHandler) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.shortlistButton.frame = shortlistButtonFrame;
    self.buyButton.frame = buyButtonFrame;
    
    [self.view addSubview:self.shortlistButton];
    [self.view addSubview:self.buyButton];
        
}

-initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andItem:(ShoppingItem *)item 
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        self.shoppingItem = item;

        IconDownloader *downloader = [[IconDownloader alloc] init];
        downloader.shoppingItem = item;
        downloader.delegate = self;
        
        self.iconDownloader = downloader;
        
        [self createUI];
        
        [self.iconDownloader startDownload];
        
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


/**********************ICON DOWNLOADER DELEGATE MEHTODS*********************/

-(void)appImageDidLoad:(NSIndexPath *)indexPath iconDownloader:(ShoppingItem *)item
{
    
    [self.shoppingItemImageView setImage:item.itemImageIcon];
    
}

/**********************ICON DOWNLOADER DELEGATE MEHTODS*********************/



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
