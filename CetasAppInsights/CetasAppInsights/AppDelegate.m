//
//  AppDelegate.m
//  CetasAppInsights
//
//  Copyright (c) 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import "AppDelegate.h"
#import "AppCategoriesViewController.h"
#import <CetasDataIngestionSDK/CetasTracker.h>
#import "SingletonClass.h"
//#import "iHasApp.h"
/*
 * Cetas App Insights Application Feed Keys
 */
NSString *const kCetasApplicationKey =  @"2DBBY7dlxokfi62TJrd6ds1QfRlYvQtiBNl428uVUEYoz78N+QiGUwWJsWdxzIZ74G7zlErNCGN0LyFjeI9UZFIzb/MTBHrSorn3CIf+/J/naagjHfKc6l4w+JCbbh0P2zCaHxUSjiV5kf1e0H9jTg==";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    AppCategoriesViewController *appCategoriesVC = [[AppCategoriesViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *appNav = [[UINavigationController alloc] initWithRootViewController:appCategoriesVC];
    appNav.navigationBar.barStyle = UIBarStyleBlack;
    appNav.navigationBar.tintColor = [UIColor darkGrayColor];
    self.window.rootViewController = appNav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self setupCetasSDK];
    [self.window makeKeyAndVisible];
    self.timer =[NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(fireLoggingEvents) userInfo:nil repeats:YES];
    
    return YES;
}

-(void)fireLoggingEvents{
    NSLog(@"Timer fired ..");
    [[SingletonClass sharedInstance] trackRunningApps];
    [self.locationManager stopUpdatingLocation];
     NSLog(@"Background remaning time %f",[[UIApplication sharedApplication] backgroundTimeRemaining]);
}


/*
 * setupCetasSDK
 * Initializes and setup the config and tracker objects
 *
 */

-(void)setupCetasSDK{
    
    
    //Prepare config object and set  configuration parameters.
    CetasConfig *config = [CetasConfig config];
    // Flag to show error in logs
    config.showErrorInLogs = NO;
    [config setUpdateInterval:60]; // Optional
    [config setBatchSize:50];// Optional
    
    
    //Default User Info
    CetasEventPreliminaryInfo *info = [CetasEventPreliminaryInfo eventPreliminaryInfo];
    [info setUserName:@"Cetas App Insights"];
    [info setUserId:@"cetas_app_insights"];
    
    
    // Prepare tracker object with api key and config object.
    // Here CetasConfig  and eventPreliminaryInfo parameters both are optional. If not passed they will take default values.
    // API key is mandatory.
    [[CetasTracker getDefaultTracker] startTrackerWithApiKey:kCetasApplicationKey config:config eventPreliminaryInfo:info delegate:nil];
    
    //Used to setup location information
    //Used to setup location information
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter =kCLDistanceFilterNone;
    [self.locationManager startUpdatingLocation];
  
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
//    NSLog(@"Enter background . ");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    self.expirationHandler = ^{
        // Clean up any unfinished task business by marking where you
        // stopped or ending the task outright.
        
        
        NSLog(@"Timer expired Enter background . ");
        // UIApplication* app = [UIApplication sharedApplication];
        
        NSLog(@"Before start updating location : Background remaning time %f",[[UIApplication sharedApplication] backgroundTimeRemaining]);
        [self.locationManager startUpdatingLocation];
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
        bgTask = [application beginBackgroundTaskWithExpirationHandler:self.expirationHandler];
        NSLog(@"Background remaning time %f",[[UIApplication sharedApplication] backgroundTimeRemaining]);
        
    };
    bgTask = [application beginBackgroundTaskWithExpirationHandler:self.expirationHandler];
   // [self dispatchTheEvents];
    
    
}



-(void)dispatchTheEvents{
    // Start the long-running task and return immediately.
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIApplication* application = [UIApplication sharedApplication];
        // Do the work associated with the task, preferably in chunks.
        while (([application applicationState] == UIApplicationStateBackground) || ([application applicationState] == UIApplicationStateInactive)) {
            
            NSLog(@"Enter background >> ");
            [self.locationManager stopUpdatingLocation];
                
            [[SingletonClass sharedInstance] trackRunningApps];
            NSLog(@"Background remaning time %f",[application backgroundTimeRemaining]);
           if([application backgroundTimeRemaining]< 580.0){
                [self.locationManager startUpdatingLocation];
            }
            [NSThread sleepForTimeInterval:30.0];
            
        }
        
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    });
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    //NSLog(@"Location Manager : Failed to track location, %@",error);
    self.locationUpdated = NO;
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)location fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location manager : Location updated, %@",location);
    [self.locationManager stopUpdatingLocation];
//    [[[CetasTracker getDefaultTracker] eventPreliminaryInfo] setUserLatitude:location.coordinate.latitude
//                                                                   longitude:location.coordinate.longitude
//                                                          horizontalAccuracy:location.horizontalAccuracy
//                                                            verticalAccuracy:location.verticalAccuracy];
    
    
}


@end
