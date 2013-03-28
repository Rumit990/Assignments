//
//  CountriesViewController.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//


#import "CountriesViewController.h"
#import "DestinationsViewController.h"
#import "CetasEvent.h"
#import "CetasTracker.h"
#import "AppDelegate.h"

@interface CountriesViewController ()


/*!
 * @brief : Timer to auto fire events periodically.
 *
 */
@property  NSTimer *autoEventsFireTimer;

@end

@implementation CountriesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        self.title = @"Countries";
        
        UILabel *titleView = (UILabel *)self.navigationController.navigationItem.titleView;
        titleView.font = [UIFont systemFontOfSize:12];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Prepare data model for the Travel Guide appilcation.
    NSArray *countries = [NSArray arrayWithObjects:@"Spain",@"United States",@"Portugal", nil];
    NSArray *spainDestinations = [NSArray arrayWithObjects:@"Madrid",@"Barcelona",@"Granada",@"Valencia", nil];
    NSArray *usaDestinations = [NSArray arrayWithObjects:@"Atlanta",@"Las Vegas",@"Los Angeles",@"Miami", nil];
    NSArray *portugalDestinations = [NSArray arrayWithObjects:@"Albufeira",@"Lagos",@"Porto",@"Cascais", nil];
    NSArray *destinations = [NSArray arrayWithObjects:spainDestinations,usaDestinations,portugalDestinations,nil];
    
    self.countriesAndDestinations = [NSDictionary dictionaryWithObjects:destinations forKeys:countries];
    self.countries = [self.countriesAndDestinations allKeys];
    
    
    // If auto fire flag is enabled, schedule the timer.
    if(kEnableAutoFireEvents){
        self.autoEventsFireTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(autoFireEvents) userInfo:nil repeats:YES];
    }

}



/*!
 *
 * @brief : Handler for auto fire timer. It automatically creates events and logs them.
 *
 */
-(void)autoFireEvents{
    
   
    CetasEvent *event= [[CetasEvent alloc] init];
    
    //for (int i = 0; i<5; i++) {
        
    for(NSString *country in self.countries){
        
        //Country visited auto event
        NSMutableDictionary *eventDetail = [NSMutableDictionary dictionaryWithObject:country forKey:@"Country_Visited_Auto"];
        [event setEventDetail:eventDetail];
        [[CetasTracker getDefaultTracker] logEvent:event];
        
        for(NSString *destination in [self.countriesAndDestinations objectForKey:country]){
            
            // Destination visited auto event
            NSMutableDictionary *eventDetail = [NSMutableDictionary dictionaryWithObject:destination forKey:@"Destination_Visited_Auto"];
            [event setEventDetail:eventDetail];
            [[CetasTracker getDefaultTracker] logEvent:event];
            
            
            // Favourite destination auto event
            NSString *favDestination = [NSString stringWithFormat:@"%@, %@",destination, country];
            eventDetail = [NSMutableDictionary dictionaryWithObject:favDestination forKey:@"Favourite_Destination_Auto"];
            [event setEventDetail:eventDetail];
            [[CetasTracker getDefaultTracker] logEvent:event];
            
            
            
        }
        
   // }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.countriesAndDestinations allKeys].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }

    NSString *imageFilePath = [NSString stringWithFormat:@"%@_%@.%@",[self.countries objectAtIndex:indexPath.row],@"Icon",@"png"];
    
  
    UIImageView *imgView = [[UIImageView alloc] init];
    UIImage *flagImage = [UIImage imageNamed:imageFilePath];
    imgView.image = flagImage;
    cell.imageView.image = imgView.image;
    cell.imageView.frame = CGRectMake(0, 0, 20, 20);
    cell.textLabel.text = [self.countries objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell...
    
    return cell;
}


#pragma mark - Table view delegate


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 56;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 56)];
    titleView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 15, self.view.frame.size.width, 36)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor darkGrayColor];
    titleLabel.text = @"Please select a country";
    [titleView addSubview:titleLabel];
    return titleView;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    // Track event when a country is selected.
    CetasEvent *event= [[CetasEvent alloc] init];
    
    NSString *country = [self.countries objectAtIndex:indexPath.row];
    NSArray *destinations = [self.countriesAndDestinations objectForKey:[self.countries objectAtIndex:indexPath.row]];
    
    NSMutableDictionary *eventDetail = [NSMutableDictionary dictionaryWithObject:country forKey:@"Country_Visited"];
    [event setEventDetail:eventDetail];
    [[CetasTracker getDefaultTracker] logEvent:event];
    
    DestinationsViewController *destinViewCont = [[DestinationsViewController alloc] initWithStyle:UITableViewStyleGrouped country:country andDestinations:destinations];
    
    [self.navigationController pushViewController:destinViewCont animated:YES];
    
}
//-(void)dealloc{
//    
//}

-(void)viewWillUnload{

    
    [self.autoEventsFireTimer invalidate];
    self.autoEventsFireTimer = nil;
    
}

//-(void)viewDidUnload{
//    
//    [super viewDidUnload];
//    
//}


@end
