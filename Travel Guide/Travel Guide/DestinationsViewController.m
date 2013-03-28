//
//  DestinationsViewController.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//


#import "DestinationsViewController.h"
#import "CetasEvent.h"
#import "CetasTracker.h"
#import "DestinationInfoViewController.h"

@interface DestinationsViewController ()

@end

@implementation DestinationsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style country:(NSString *)country andDestinations:(NSArray *)destinations
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.destinations = destinations;
        self.country = country;
        self.title = self.country;
        UILabel *titleView = (UILabel *)self.navigationController.navigationItem.titleView;
        titleView.font = [UIFont systemFontOfSize:12];
    }
    return self;
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
    
    return self.destinations.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.destinations objectAtIndex:indexPath.row];
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
    titleLabel.text = @"Please select a destination";
    [titleView addSubview:titleLabel];
    return titleView;
    
}


// Code to display country flag in the section header.
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//  
//    return 150;
//    
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    UIView *view = nil;
//    UIImageView *imgView = nil;
//
//    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 150)];
//    view.backgroundColor = [UIColor clearColor];
//   
//    NSString *imageFilePath = [NSString stringWithFormat:@"%@_%@.%@",self.country,@"Flag",@"png"];
//    imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageFilePath]];
//    imgView.center = view.center;
//    [view addSubview:imgView];
////    UILabel *countryName = [[UILabel alloc] initWithFrame:view.frame];
////    countryName.backgroundColor = [UIColor clearColor];
////    countryName.text = [self.country uppercaseString];
////    countryName.font = [UIFont systemFontOfSize:20];
////    CGRect labelFrame = CGRectMake(0, 105, view.frame.size.width, 50);
////    countryName.frame = labelFrame;
////    [self.view addSubview:countryName];
//    return view;
//
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    // Track event when a country is selected.
    CetasEvent *event = [[CetasEvent alloc] init];
    
    NSString *destination = [self.destinations objectAtIndex:indexPath.row];
    
     NSMutableDictionary *eventDetail = [NSMutableDictionary dictionaryWithObject:destination forKey:@"Destination_Visited"];
    [event setEventDetail:eventDetail];
    [[CetasTracker getDefaultTracker] logEvent:event];
    
    DestinationInfoViewController *detViewCont = [[DestinationInfoViewController alloc] initWithCountry:self.country destination:destination];
    [self.navigationController pushViewController:detViewCont animated:YES];
}

@end
