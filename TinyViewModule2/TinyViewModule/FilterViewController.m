
//
//  FilterViewController.m
//  TinyViewModule
//
//  Created by Chetan Sanghi on 17/11/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import "FilterViewController.h"
#import "CategoryListViewController.h"
#import "CentredTableView.h"

@implementation FilterViewController

@synthesize applyFilterDelegate;
@synthesize categoryFilter;
@synthesize backgroundView;

/*------------------------*/

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    NSMutableDictionary *filterItems = [[NSMutableDictionary alloc] initWithObjects:@"Category" forKeys:@"Section1" count:1];
//    
//    NSLog(@"This is received from teh custom class = = = = = = = = %f ",[CentredTableView tableView:self heightForHeaderInSection:section withDataSource:filterItems]);
//    
//    return [CentredTableView tableView:self heightForHeaderInSection:section withDataSource:filterItems];
//}



/*------------------------*/


-(NSString *)categoryFilter
{
    if(!categoryFilter)
    {
        categoryFilter = @"any";
    }
    
    return categoryFilter;  
}

-(void)setCategoryFilter:(NSString *)shoppingCategoryFilter
{
    categoryFilter = shoppingCategoryFilter;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        
        self.title = @"Filter Products";
        
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



/*******-------NAVIGATION BUTTON HANDLERS------*******/



-(void)applyButtonHandler
{

    if(!self.categoryFilter)
    {
        [self.applyFilterDelegate selectedShoppingItemsFilter:@"any"];
    }
    else
    {
        [self.applyFilterDelegate selectedShoppingItemsFilter:self.categoryFilter];
    }

}

-(void)cancelButtonHandler
{
    [self.navigationController popViewControllerAnimated:YES];
}



/*******-------NAVIGATION BUTTON HANDLERS------*******/


- (void)viewDidLoad
{
    [super viewDidLoad];

    /***--ADDITION OF NAVIGATION BUTTONS IS DONE IN HERE--***/
    
    
    UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStyleBordered target:self action:@selector(applyButtonHandler)];
    
    applyButton.tintColor = [UIColor redColor];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonHandler)];
    
    self.navigationItem.rightBarButtonItem = applyButton;
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    
    /***--ADDITION OF NAVIGATION BUTTONS IS DONE, IN HERE--***/
    
    
//    CGRect newFrame = CGRectMake(00, 208.00, 320.0, 416.0);
//       
//    self.view.frame = newFrame;
//    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [self.view superview];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    /***--ADDITION OF BACKGROUND IS DONE IN HERE--***/

//    UIView *sample = [self.view superview];
//    
//    
//    
//    NSLog(@"view details %@",sample.description);
//    
//   UIImage *filterPageImage = [UIImage imageNamed:@"FilterViewImage.jpg"];
//    
//    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:filterPageImage];
//    
//    [sample addSubview:backgroundImageView];
//    
//    [sample bringSubviewToFront:self.view];
    
    UIImage *filterPageImage = [UIImage imageNamed:@"FilterViewImage.jpg"];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:filterPageImage];    
    
    if(self.categoryFilter != @"any")
    {
        
        [self.tableView reloadData];
    
    }
    /***--ADDITION OF BACKGROUND IS DONE IN HERE--***/
    ;

   
//    
//    CGRect newFrame = CGRectMake(00, 208.00, 320.0, 416.0);
//    
//    self.view.frame = newFrame;
    
    //NSLog(@"khud ka size ============ %f and %f",self.view.bounds.size.width,self.view.bounds.size.height);
    
        
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];


}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FilterSelectorCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = @"Category";
    cell.detailTextLabel.text = self.categoryFilter;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate



/***TO SHOW THE CELL APPROPRIATELY**/



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 140; // to leave the required space before the cell with contents
    }
    else return 44;  // normal cell size
}



-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        cell.hidden = YES;  //upper cell is hidden
    }
    else
    cell.detailTextLabel.text = self.categoryFilter;
}


/***TO SHOW THE CELL APPROPRIATELY**/





/********CATEGORY SETTER DELEGATE METHOD********/


-(void)setCategoryForFilter:(NSString *)selectedCategory
{
    NSLog(@"Filter view controller, the selected category received is ---------------> %@",selectedCategory);
    
    self.categoryFilter = selectedCategory;
    
    
    
}

/********CATEGORY SETTER DELEGATE METHOD********/



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
        
    CategoryListViewController *categoryListViewController = [[CategoryListViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    categoryListViewController.categorySetterDelegate = self;

     [self.navigationController pushViewController:categoryListViewController animated:YES];
     
}

@end
