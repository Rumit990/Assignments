//
//  TableViewController.m
//  TableViewControllerExample
//
//  Created by Chetan Sanghi on 27/10/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import "TableViewController.h"
#import "DetailViewController.h"


@implementation TableViewController 

@synthesize allAboutDrinks;


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

-(void)addChanges:(DetailViewController *)requester
{
    
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    
    
    
    [temp setObject:requester.nameOfDrink.text forKey:@"name"];
    [temp setObject:requester.ingredients.text forKey:@"ingredients"];
    [temp setObject:requester.directions.text forKey:@"directions"];
    
    [self.allAboutDrinks addObject:temp];
    
    [self dismissModalViewControllerAnimated:YES];
    
    [self.tableView reloadData];
}

-(void)updateChanges:(DetailViewController *)requester
{
    

}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
    UIBarButtonItem *insertButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
     
    
    self.navigationItem.rightBarButtonItem = insertButton;    
    
    // delete button
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem; // a property of table view controller.
    
    

    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.allAboutDrinks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SaturdayGuide"; // the set of cells is given this identifier
    
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];  // if a cell is available in the available cells, one of tham that has been scrolled up is returned from teh set else a new one is allocated in the coming statememnts
       
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
}
    
    cell.textLabel.text = [[self.allAboutDrinks objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    //cell.accessoryType = UI
    
    //cell.detailTextLabel.text = @"Its a name";
    
    // Configure the cell...
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     DetailViewController *dvc= [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    dvc.delegate = self;   
    
    dvc.selectedDrink = [[self.allAboutDrinks objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    dvc.selectedDrinkDirections = [[self.allAboutDrinks objectAtIndex:indexPath.row] objectForKey:@"directions"];
     
    dvc.selectedDrinkIngredients = [[self.allAboutDrinks objectAtIndex:indexPath.row] objectForKey:@"ingredients"]; 
    
    
    
    
    [self.navigationController pushViewController:dvc animated:YES];
    
    NSLog(@"after pushing the detail viee controller");
    
     
}

@end
