//
//  AppListViewController.m
//  CetasAppInsights
//  Copyright (c) 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import "AppListViewController.h"
#import "iHasApp.h"
#import "Constants.h"
#import "RunningApps.h"
#import "SingletonClass.h"
#import <CetasDataIngestionSDK/CetasTracker.h>
#import <QuartzCore/QuartzCore.h>
#import "AppInfoViewController.h"
//This class used to display information about detected apps and Running apps in table view.

@interface AppListViewController ()

//Store the app information for each app as recieved from itunes .It will be array of dictionaries.Each app has a dictionary entry.
@property (nonatomic, strong) NSArray *appsInfoArray;
//Store app icon images indexed by each row of table.
@property (strong) NSMutableDictionary *appIconImages;
//Stores iconDownloader Objects.
@property (strong) NSMutableDictionary *imageDownloadsInProgress;
//Keeps track of pushed detail view controlled.
@property int pushedRow;
//Hold reference to the AppInfoViewController.
@property AppInfoViewController *appInfoViewController;
@property (strong) UIActivityIndicatorView *loadingIndicator;

@end

@implementation AppListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.navigationItem.leftBarButtonItem.title = @"Back";
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
    self.navigationItem.leftBarButtonItem.title = @"Back";
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonPressed)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    self.view.backgroundColor = [UIColor whiteColor];
    self.appsInfoArray = [[NSMutableArray alloc] init];
    self.appIconImages = [[NSMutableDictionary alloc] init];
    self.imageDownloadsInProgress =[[NSMutableDictionary alloc] init];
    self.loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-25, self.view.frame.size.height/2-25, 50, 50)];
    self.loadingIndicator.backgroundColor =[UIColor colorWithWhite:0.37 alpha:1];
    self.loadingIndicator.layer.cornerRadius =5.0;
    [self.view addSubview:self.loadingIndicator];
    
    

    [self loadData];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1.0];
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
/*
 * Loads Data from backend(itunes store) and reload the table.
 */
-(void)loadData{
     [self.loadingIndicator startAnimating];
    id detectionObject = nil;
    if([self.appCategory isEqualToString:kApplicationCategoryInstalled]){
         //self.iHasAppObj = [[iHasApp alloc] init];
        detectionObject =[[iHasApp alloc] init];
    }else{
        //self.runningAppsObj = [[RunningApps alloc] init];
        detectionObject = [[RunningApps alloc] init];;
    }
    [detectionObject detectAppDictionariesWithIncremental:^(NSArray *appDictionaries) {
        //NSLog(@"Incremental appDictionaries.count: %i", appDictionaries.count);
        NSMutableArray *newAppDictionaries = [NSMutableArray arrayWithArray:self.appsInfoArray];
        [newAppDictionaries addObjectsFromArray:appDictionaries];
        self.appsInfoArray = newAppDictionaries;
        
        [self.tableView reloadData];
        [self.loadingIndicator stopAnimating];
    } withSuccess:^(NSArray *appDictionaries) {
        //Block for successfull response.
        NSLog(@"Successful appDictionaries.count: %i", appDictionaries.count);
        self.appsInfoArray = appDictionaries;
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if(appDictionaries.count){
            [self.tableView reloadData];
            // Track Cetas events for each app.
            [[SingletonClass sharedInstance] logCetasEvents:appDictionaries category:self.appCategory];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                                message:@"Unable to fetch data from itunes. Please reload again."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        [self.loadingIndicator stopAnimating];
    } withFailure:^(NSError *error) {
        //Block for error cases.
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
    

    self.appIconImages = [[NSMutableDictionary alloc] init];
    self.appsInfoArray = [[NSMutableArray alloc] init];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.tableView reloadData];
}
/*
* Called when refresh button is pressed.
*/
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
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *items = [self.appsInfoArray objectAtIndex:indexPath.row];
    if([items objectForKey:@"name"]){
        cell.textLabel.text = [items objectForKey:@"name"];
    }
    // Configure the cell...
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:13.0];
    cell.detailTextLabel.font =[UIFont systemFontOfSize:12.0];
    NSDictionary *appDictionary = [self.appsInfoArray objectAtIndex:indexPath.row];
    
    NSString *trackName = [appDictionary objectForKey:@"trackName"];
    //NSString *trackId = [[appDictionary objectForKey:@"trackId"] description];
    
    cell.textLabel.text = trackName;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"App Id: %@",trackId];
//    if([self.appCategory isEqualToString:kApplicationCategoryActive]){
//        NSDate *date =[NSDate dateWithTimeIntervalSince1970:[[appDictionary objectForKey:kDictKeyStartTime] doubleValue]];
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//         [dateFormatter setDateFormat:@"MMM dd, MM yyyy hh:mm a "];
//        NSString *startTimeString =[NSString stringWithFormat:@"Launch Time: %@",[dateFormatter stringFromDate:date]];
//        cell.detailTextLabel.text = startTimeString;
//    }

    if(self.appIconImages && [self.appIconImages objectForKey:[NSNumber numberWithInt:indexPath.row]]){
        
        cell.imageView.frame = CGRectMake(5, 10, 30, 30);
        cell.imageView.image = [self.appIconImages objectForKey:[NSNumber numberWithInt:indexPath.row]];
    
        
    }else{
        NSString *iconUrlString = [appDictionary objectForKey:@"artworkUrl512"];
        NSArray *iconUrlComponents = [iconUrlString componentsSeparatedByString:@"."];
        NSMutableArray *mutableIconURLComponents = [[NSMutableArray alloc] initWithArray:iconUrlComponents];
        [mutableIconURLComponents insertObject:@"128x128-75" atIndex:mutableIconURLComponents.count-1];
        iconUrlString = [mutableIconURLComponents componentsJoinedByString:@"."];
        cell.imageView.image = [UIImage imageNamed:@"placeholder-icon"];
        [self startIconDownload:iconUrlString forIndexPath:indexPath];
    }
    return cell;
}
/*
 * Method to start app icon download.
 */
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
        
        [self.appIconImages setObject:iconDownloader.imageDownloaded forKey:[NSNumber numberWithInt:indexPath.row]];
        if(self.pushedRow == indexPath.row && !self.appInfoViewController.appIconImage){
            self.appInfoViewController.appIconImage = iconDownloader.imageDownloaded;
        }
        [self.imageDownloadsInProgress removeObjectForKey:indexPath];
    }
}



#pragma mark - Table view delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    return 185;
        
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(self.tableView.frame.origin.x,0, self.tableView.frame.size.width, 185)];
    headerView.backgroundColor = [UIColor clearColor];
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.tableView.frame.size.width-20, 120)];
    containerView.backgroundColor = [UIColor colorWithWhite:0.80 alpha:1.0];
    containerView.layer.cornerRadius = 10.0;
    containerView.layer.borderWidth = 1.0;
    containerView.layer.borderColor = [UIColor colorWithWhite:0.75 alpha:1.0].CGColor;
    UIView *innerContainerView = [[UIView alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width/2-70, 10, 120, 100)];
    innerContainerView.backgroundColor = [UIColor whiteColor];
    innerContainerView.layer.borderColor = [UIColor colorWithWhite:0.75 alpha:1.0].CGColor;
    innerContainerView.layer.borderWidth = 1.0;
    innerContainerView.layer.cornerRadius = 10.0;
    [containerView addSubview:innerContainerView];
    headerView.backgroundColor = [UIColor clearColor];
    
    NSString *imageFilePath = [NSString stringWithFormat:@"%@.%@",@"Logo",@"png"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 90, 60)];
    UIImage *logo = [UIImage imageNamed:imageFilePath];
    imgView.image = logo;
    [innerContainerView addSubview:imgView];
    
    UIView *labelBackView = [[UIView alloc] initWithFrame:CGRectMake(11, 145, self.tableView.frame.size.width-20, 25)];
    labelBackView.backgroundColor = [UIColor colorWithWhite:0.72 alpha:1.0];
    labelBackView.layer.cornerRadius = 25.0;
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 193, 25)];
    headerLabel.text = @"Please select an application";
    headerLabel.font = [UIFont boldSystemFontOfSize:14.0];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.backgroundColor = [UIColor clearColor];
    [labelBackView addSubview:headerLabel];
    
    [headerView addSubview:labelBackView];
    [headerView addSubview:containerView];
    return headerView;
}
/*
 * This method logs Inventory Events and App start event for each app detected.
 */

//-(void)logCetasEvents{
//    
//    
//    NSString *categoryName = @"Installed";
//    if([self.appCategory isEqualToString:kApplicationCategoryActive]){
//        categoryName = @"Running";
//    }
//    
//    for (NSMutableDictionary *appInfo in self.appsInfoArray) {
//        NSMutableDictionary *eventInfoDic =[[NSMutableDictionary alloc] init];
//        [eventInfoDic setObject:[appInfo objectForKey:@"trackName"] forKey:@"App Name"];
//        NSString *appID  = [NSString stringWithFormat:@"%@",[appInfo objectForKey:@"trackId"]];
//        
//        [eventInfoDic setObject:appID   forKey:@"App Id"];
//        if([self.appCategory isEqualToString:kApplicationCategoryActive]){
//            
//            NSDate *date =[NSDate dateWithTimeIntervalSince1970:[[appInfo objectForKey:kDictKeyStartTime] doubleValue]];
//            if(date){
//                [eventInfoDic setObject:[appInfo objectForKey:kDictKeyStartTime]  forKey:@"App Launch Time"];
//            }
//            
//        }
//        
//        [[CetasTracker getDefaultTracker] trackEventWithCategory:categoryName eventDetail:eventInfoDic];
//        
//    }
//    if([self.appCategory isEqualToString:kApplicationCategoryActive]){
//        NSMutableArray  *trackNames =[[NSMutableArray alloc] init];
//        for (NSMutableDictionary *appInfo in self.appsInfoArray) {
//            
//            [trackNames addObject:[appInfo objectForKey:@"trackName"]];
//            
//        }
//        NSMutableDictionary *eventInfoDic =[NSMutableDictionary dictionaryWithObject:[trackNames componentsJoinedByString:@","] forKey:@"Running Apps"];
//        [[CetasTracker getDefaultTracker] trackEventWithCategory:@"Set of " eventDetail:eventInfoDic];
//    
//    }
//       
//    
//    
//    NSLog(@"Cetas Events Info logged.");
//    
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
     self.appInfoViewController = [[AppInfoViewController alloc] initWithNibName:@"AppInfoViewController" bundle:nil];
    self.appInfoViewController.appInfoItemArray =  [self _getAppInfo:[self.appsInfoArray objectAtIndex:indexPath.row]];
   // Set the App Icon for app detail page.
    if(self.appIconImages && [self.appIconImages objectForKey:[NSNumber numberWithInt:indexPath.row]]){
        self.appInfoViewController.appIconImage = [self.appIconImages objectForKey:[NSNumber numberWithInt:indexPath.row]];
    }
    //set the app name for for app detail page.
    self.appInfoViewController.appName =[[self.appsInfoArray objectAtIndex:indexPath.row] objectForKey:@"trackName"];
    self.pushedRow = indexPath.row;
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:self.appInfoViewController animated:YES];
    
}
/*
 * This method prepares information to display on app detail page and returns it in form of array.
 * @param: App info as recieved from itunes as an dictionary.
 */
-(NSArray *)_getAppInfo:(NSMutableDictionary *)appDictionary{
    
    NSMutableArray *info = [[NSMutableArray alloc] init];
    
    if([self.appCategory isEqualToString:kApplicationCategoryActive]){
        NSDate *date =[NSDate dateWithTimeIntervalSince1970:[[appDictionary objectForKey:kDictKeyStartTime] doubleValue]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd, MM yyyy hh:mm a "];
        //May 22, 2013 4:15pm
        NSString *launchTimeString =[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"Launch Time" forKey:kAppInfoItemKeyTitle];
        [dict setObject:launchTimeString forKey:kAppInfoItemKeyValue];
        [info addObject:dict];
    }
    NSArray *keyNames =[NSArray arrayWithObjects:@"trackId",@"version",@"primaryGenreName",@"trackContentRating",@"trackViewUrl", nil];
    NSArray *titleNames =[NSArray arrayWithObjects:@"App ID",@"Version",@"Primary Genre Name",@"Content Rating",@"View Url", nil];
    
    for (int i=0 ; i<keyNames.count; i++) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[titleNames objectAtIndex:i] forKey:kAppInfoItemKeyTitle];
        [dict setObject:[appDictionary objectForKey:[keyNames objectAtIndex:i]] forKey:kAppInfoItemKeyValue];
        [info addObject:dict];
    }
    return info;
}
@end
