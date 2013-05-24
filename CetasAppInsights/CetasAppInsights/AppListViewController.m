//
//  AppListViewController.m
//  CetasAppInsights
//
//  Created by Vipin Joshi on 23/05/13.
//  Copyright (c) 2013 Cetas. All rights reserved.
//

#import "AppListViewController.h"
#import "iHasApp.h"
#import "Constants.h"
#import "RunningApps.h"
#import "SingletonClass.h"
#import <CetasDataIngestionSDK/CetasTracker.h>
#import <QuartzCore/QuartzCore.h>

@interface AppListViewController ()
@property (strong) iHasApp *iHasAppObj;
@property (strong)  RunningApps *runningAppsObj;
@property (nonatomic, strong) NSArray *appsInfoArray;
@property (strong) NSMutableArray *appIconImages;
@property (strong) NSMutableDictionary *imageDownloadsInProgress;
@property (strong) UIActivityIndicatorView *loadingIndicator;

@end

@implementation AppListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)initWithStyle:(UITableViewStyle)style category:(NSString *)paramCategory{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = paramCategory;
        self.appCategory = paramCategory;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [SingletonClass setNavigationTitleFont:self.navigationItem];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonPressed)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    self.view.backgroundColor = [UIColor whiteColor];
    self.appsInfoArray = [[NSMutableArray alloc] init];
    self.appIconImages = [[NSMutableArray alloc] init];
    self.imageDownloadsInProgress =[[NSMutableDictionary alloc] init];
    self.loadingIndicator  = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height)];
    [self.tableView addSubview:self.loadingIndicator];
    [self loadData];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1.0];
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)loadData{
    [self.loadingIndicator startAnimating];
    if([self.appCategory isEqualToString:kApplicationCategoryInstalled]){
        self.iHasAppObj = [[iHasApp alloc] init];
        
        
        
        [self.iHasAppObj detectAppDictionariesWithIncremental:^(NSArray *appDictionaries) {
            //NSLog(@"Incremental appDictionaries.count: %i", appDictionaries.count);
            NSMutableArray *newAppDictionaries = [NSMutableArray arrayWithArray:self.appsInfoArray];
            [newAppDictionaries addObjectsFromArray:appDictionaries];
            self.appsInfoArray = newAppDictionaries;
            
            [self.tableView reloadData];
        } withSuccess:^(NSArray *appDictionaries) {
            NSLog(@"Successful appDictionaries.count: %i", appDictionaries.count);
            self.appsInfoArray = appDictionaries;
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
            [self.tableView reloadData];
            [self logCetasEvents];
            [self.loadingIndicator stopAnimating];
        } withFailure:^(NSError *error) {
            NSLog(@"Error: %@", error.localizedDescription);
            self.appsInfoArray = [NSArray array];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:error.localizedDescription
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
            [self.tableView reloadData];
            [self.loadingIndicator stopAnimating];
        }];
    } if([self.appCategory isEqualToString:kApplicationCategoryActive]){
        self.runningAppsObj = [[RunningApps alloc] init];
        [self.runningAppsObj detectAppDictionariesWithIncremental:^(NSArray *appDictionaries) {
            //NSLog(@"Incremental appDictionaries.count: %i", appDictionaries.count);
            NSMutableArray *newAppDictionaries = [NSMutableArray arrayWithArray:self.appsInfoArray];
            [newAppDictionaries addObjectsFromArray:appDictionaries];
            self.appsInfoArray = newAppDictionaries;
            
            [self.tableView reloadData];
        } withSuccess:^(NSArray *appDictionaries) {
            NSLog(@"Successful appDictionaries.count: %i", appDictionaries.count);
            self.appsInfoArray = appDictionaries;
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [self.tableView reloadData];
            [self logCetasEvents];
            [self.loadingIndicator stopAnimating];
        } withFailure:^(NSError *error) {
            NSLog(@"Error: %@", error.localizedDescription);
            self.appsInfoArray = [NSArray array];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:error.localizedDescription
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
            [self.loadingIndicator stopAnimating];
            [self.tableView reloadData];
        }];
    }
    self.appIconImages = [[NSMutableArray alloc] init];
    self.appsInfoArray = [[NSMutableArray alloc] init];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.tableView reloadData];
}

-(void)refreshButtonPressed{
    
    
    [self loadData];
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
    return self.appsInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *items = [self.appsInfoArray objectAtIndex:indexPath.row];
    if([items objectForKey:@"name"]){
        cell.textLabel.text = [items objectForKey:@"name"];
    }
    // Configure the cell...
    
    
    NSDictionary *appDictionary = [self.appsInfoArray objectAtIndex:indexPath.row];
    
    NSString *trackName = [appDictionary objectForKey:@"trackName"];
    NSString *trackId = [[appDictionary objectForKey:@"trackId"] description];
    //NSString *artworkUrl60 = [appDictionary objectForKey:@"artworkUrl60"];
    
    
    
    cell.textLabel.text = trackName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"App Id: %@",trackId];
    if([self.appCategory isEqualToString:kApplicationCategoryActive]){
        NSDate *date =[NSDate dateWithTimeIntervalSince1970:[[appDictionary objectForKey:kDictKeyStartTime] doubleValue]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd MM yyyy hh:mm:ss "];
        NSString *startTimeString =[NSString stringWithFormat:@"Launch Time: %@",[dateFormatter stringFromDate:date]];
        cell.detailTextLabel.text = startTimeString;
    }
    
    
    
    
    if(self.appIconImages && self.appIconImages.count > indexPath.row){
        
        cell.imageView.frame = CGRectMake(5, 10, 30, 30);
        cell.imageView.image = [self.appIconImages objectAtIndex:indexPath.row];
    
        
    }else{
        NSString *iconUrlString = [appDictionary objectForKey:@"artworkUrl512"];
        NSArray *iconUrlComponents = [iconUrlString componentsSeparatedByString:@"."];
        NSMutableArray *mutableIconURLComponents = [[NSMutableArray alloc] initWithArray:iconUrlComponents];
        [mutableIconURLComponents insertObject:@"128x128-75" atIndex:mutableIconURLComponents.count-1];
        iconUrlString = [mutableIconURLComponents componentsJoinedByString:@"."];
        cell.imageView.image = [UIImage imageNamed:@"placeholder-icon"];
        [self startIconDownload:iconUrlString forIndexPath:indexPath];
    }
    
    
    
    //    [cell.imageView setImageWithURL:[NSURL URLWithString:iconUrlString]
    //                   placeholderImage:[UIImage imageNamed:@"placeholder-icon"]];
    
    
    
    return cell;
}

- (void)startIconDownload:(NSString *)iconURL forIndexPath:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [self.imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader == nil)
    {
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.imageURL = iconURL;;
        iconDownloader.indexPathInTableView = indexPath;
        iconDownloader.delegate = self;
        [self.imageDownloadsInProgress setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
    }
}
#pragma mark iconDownloader delegate methods
- (void)appImageDidLoad:(NSIndexPath *)indexPath iconDownloader:(IconDownloader *)paramIconDownloader
{
    IconDownloader *iconDownloader = [self.imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader != nil)
    {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:iconDownloader.indexPathInTableView];
        
        // Display the newly loaded image
        cell.imageView.frame = CGRectMake(5, 10, 30, 30);
        cell.imageView.image = iconDownloader.imageDownloaded;
        
        [cell setNeedsLayout]; // must!!
        
        [self.appIconImages insertObject:iconDownloader.imageDownloaded atIndex:indexPath.row];
        [self.imageDownloadsInProgress removeObjectForKey:indexPath];
    }
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
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 185;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(self.tableView.frame.origin.x,0, self.tableView.frame.size.width, 185)];
    headerView.backgroundColor = [UIColor clearColor];
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.tableView.frame.size.width-20, 120)];
    containerView.backgroundColor = [UIColor colorWithWhite:0.80 alpha:1.0];
    containerView.layer.cornerRadius = 10.0;
    UIView *innerContainerView = [[UIView alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width/2-70, 10, 120, 100)];
    innerContainerView.backgroundColor = [UIColor whiteColor];
    innerContainerView.layer.cornerRadius = 10.0;
    [containerView addSubview:innerContainerView];
    headerView.backgroundColor = [UIColor clearColor];
    
    NSString *imageFilePath = [NSString stringWithFormat:@"%@.%@",@"Logo",@"png"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 90, 60)];
    UIImage *logo = [UIImage imageNamed:imageFilePath];
    imgView.image = logo;
    [innerContainerView addSubview:imgView];
    
    //    UIView *labelBackView = [[UIView alloc] initWithFrame:CGRectMake(11, 145, self.tableView.frame.size.width-20, 25)];
    //    labelBackView.backgroundColor = [UIColor colorWithWhite:0.72 alpha:1.0];
    //    labelBackView.layer.cornerRadius = 20.0;
    //    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, headerView.frame.size.width, 25)];
    //    headerLabel.text = @"";
    //    headerLabel.font = [UIFont systemFontOfSize:14.0];
    //    headerLabel.textColor = [UIColor whiteColor];
    //    headerLabel.backgroundColor = [UIColor clearColor];
    //    [labelBackView addSubview:headerLabel];
    //
    //    [headerView addSubview:labelBackView];
    [headerView addSubview:containerView];
    return headerView;
    
}


-(void)logCetasEvents{
    
    
    NSString *categoryName = @"Installed";
    if([self.appCategory isEqualToString:kApplicationCategoryActive]){
        categoryName = @"Running";
    }
    
    for (NSMutableDictionary *appInfo in self.appsInfoArray) {
        NSMutableDictionary *eventInfoDic =[[NSMutableDictionary alloc] init];
        [eventInfoDic setObject:[appInfo objectForKey:@"trackName"] forKey:@"App Name"];
        NSString *appID  = [NSString stringWithFormat:@"%@",[appInfo objectForKey:@"trackId"]];
        
        [eventInfoDic setObject:appID   forKey:@"App"];
        if([self.appCategory isEqualToString:kApplicationCategoryActive]){
            NSDate *date =[NSDate dateWithTimeIntervalSince1970:[[appInfo objectForKey:kDictKeyStartTime] doubleValue]];
            if(date){
                [eventInfoDic setObject:[appInfo objectForKey:kDictKeyStartTime]  forKey:@"App Launch Time"];
            }
        }
        
        [[CetasTracker getDefaultTracker] trackEventWithCategory:categoryName eventDetail:eventInfoDic];
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
