//
//  TableViewController.m
//  TableViewControllerExample
//
//  Created by Chetan Sanghi on 27/10/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import "TableViewController.h"
#import "DetailViewController.h"
#import "ShoppingListController.h"

@implementation TableViewController 

@synthesize allAboutDrinks;
@synthesize fetchedFromURL;
@synthesize items;

-(NSMutableArray *)items
{
    if(!items)
    {
        items = [[NSMutableArray alloc] init];
    }
    return items;
}

-(void)setItems:(NSMutableArray *)rcvdItems
{
    items = rcvdItems;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    
       
    
    self.title = @"Saturday Guide";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DrinkDirections" ofType:@"plist"];
    
    
    
    self.allAboutDrinks = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)addButtonPressed
{
    DetailViewController *dvc= [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    dvc.delegate = self;   
    
    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:dvc];
    [self presentModalViewController:navCon animated:YES];
}

-(void)discardChanges:(DetailViewController *)requester
{
    [self dismissModalViewControllerAnimated:YES];
    
    [self.tableView reloadData];
}

//-(NSComparisonResult)compare:(MyCustomObject *)other forElement:(NSString *)object
//{
//    
//}

-(void)addChanges:(DetailViewController *)requester
{
    
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    
    
    
    [temp setObject:requester.nameOfDrink.text forKey:@"name"];
    [temp setObject:requester.ingredients.text forKey:@"ingredients"];
    [temp setObject:requester.directions.text forKey:@"directions"];
    
    [self.allAboutDrinks addObject:temp];
    
    [self dismissModalViewControllerAnimated:YES];
    
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector( caseInsensitiveCompare:)];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDesc];
    //Sort the data in the model (dictionary befor calling the reload button)
    
    NSArray *tempArray = [NSArray arrayWithArray:self.allAboutDrinks];
    
    tempArray = [self.allAboutDrinks sortedArrayUsingDescriptors:sortDescriptors];
    
    self.allAboutDrinks = [tempArray mutableCopy];
    
    [self.tableView reloadData];
    
}

-(void)updateChanges:(DetailViewController *)requester forIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSArray *tempArray = [NSArray arrayWithObject:indexPath];
         
    
    
    
    [self.tableView reloadRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationFade];

    NSLog(@"Aa rahaa hai delegate mein");
    [self.navigationController popViewControllerAnimated:YES];
    
   
}

- (void)fetchedData:(NSData *)responseData 
{
    
    NSError* error;
    
    self.fetchedFromURL = [NSJSONSerialization 
                          JSONObjectWithData:responseData options:kNilOptions error:&error];
    
      NSString *takenName = [[self.fetchedFromURL objectAtIndex:1] objectForKey:@"name"]; 
    
     NSLog(@"Name: %@", takenName); //3
    
    
    
    for(NSDictionary *tempItem in fetchedFromURL)
    {
        
        ShoppingItem *tempShoppingItem = [[ShoppingItem alloc] init];
        
        tempShoppingItem.itemName = [tempItem objectForKey:@"name"];
        tempShoppingItem.itemId = [[tempItem objectForKey:@"id"] stringValue];
        tempShoppingItem.itemCount = [[tempItem objectForKey:@"itemCnt"] stringValue];
        
        [self.items addObject:tempShoppingItem];
        
    }

}

-(void)populateShoppingItems
{
    NSURL *url = [NSURL URLWithString:@"http://dev.tinyview.com:9080/api/rest/shopping_lists?sort_by=recent"];
    
    NSData* data = [NSData dataWithContentsOfURL:url]; // fetches the data from the URL
    
    [self fetchedData:data];
    
    
}


- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
    UIBarButtonItem *insertButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
     
    
    self.navigationItem.rightBarButtonItem = insertButton;    
    
    // delete button
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem; // a property of table view controller.
   
    [self populateShoppingItems];
    
    // self.tableView.delegate = self;
   // self.tableView.dataSource = self;
    

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    if(section == 0)
    {
    return self.allAboutDrinks.count;

    }
    else 
    {
        return self.fetchedFromURL.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SaturdayGuide"; // the set of cells is given this identifier
    
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];  // if a cell is available in the available cells, one of tham that has been scrolled up is returned from teh set else a new one is allocated in the coming statememnts
       
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
}
    if(indexPath.section == 0)
    {
        cell.textLabel.text = [[self.allAboutDrinks objectAtIndex:indexPath.row] objectForKey:@"name"];
    
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    //cell.detailTextLabel.text = @"Its a name";
    
    // Configure the cell...
    }
    else 
    {
        cell.textLabel.text = [[self.fetchedFromURL objectAtIndex:indexPath.row] objectForKey:@"name"];
        
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
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




- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) // this style is set once the delete button is pressed
    {
        [self.allAboutDrinks removeObjectAtIndex:indexPath.row]; // model update
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];  // performs the deletion on the view with animation. view update
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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


-(void)tableView:(UITableView *)sender accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Tap is working");
}
//-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath://(NSIndexPath *)indexPath{
//    
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSMutableDictionary *tempDataDictionary = [[NSMutableDictionary alloc] init];    
    
    if(indexPath.section ==  0)
    {
    
        DetailViewController *dvc= [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    
    
        dvc.delegate = self;   
    
        dvc.selectedDrink = [[self.allAboutDrinks objectAtIndex:indexPath.row] objectForKey:@"name"];
    
        dvc.selectedDrinkDirections = [[self.allAboutDrinks objectAtIndex:indexPath.row] objectForKey:@"directions"];
     
        dvc.selectedDrinkIngredients = [[self.allAboutDrinks objectAtIndex:indexPath.row] objectForKey:@"ingredients"]; 
    
        dvc.selectedDrinkDetails = [self.allAboutDrinks objectAtIndex:indexPath.row];
        dvc.selectedIndexPath = indexPath;
        
        [self.navigationController pushViewController:dvc animated:YES];
    
    
     
}

    else
    {
        ShoppingListController *slc = [[ShoppingListController alloc] init];
        
        slc.selectedItem = [items objectAtIndex:indexPath.row];
        
        [self.navigationController pushViewController:slc animated:YES];
        
    }
}
@end
