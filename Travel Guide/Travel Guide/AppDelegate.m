//
//  AppDelegate.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import "AppDelegate.h"


NSString *const kCetasApplicationKey =  @"yMhPiAPfU09S8pNxRLFJJn3N/i394MbxTiyBw9OKfP386qNMLZioU268WmaCnNOOU438C4Oojjmf4qKIaVP1RICM04qkedR+x1xjJU0/DHCMUgvdMNCCp4SQ2R9PMONTw/KI5ij6TzvCu6mEXZsLUg==";


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UserDetailsViewController *userDVC = [[UserDetailsViewController alloc] initWithDelegate:self];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:userDVC];
    navController.navigationBar.translucent = YES;
   
    
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
     //Setup Cetas event tracking.
    [self setupCetasSDK];
    
    return YES;
}

/*
 * setupCetasSDK
 * Initializes and setup the config and tracker objects
 *
 */
-(void)setupCetasSDK{
    
    //Prepare config object and set user information and other configuration parameter init.
    CetasConfig *config = [CetasConfig getDefaultInstance];
    config.showErrorInLogs = YES;
    //Location information
    self.locationManager = [[CLLocationManager alloc] init];
    // [self.locationManager startUpdatingLocation];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    
    //Create Config object and set user location.
    // Prepare tracker object with api key and config object.
    [[CetasTracker getDefaultTracker] startTrackerWithApiKey:kCetasApplicationKey config:config];
}




#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    NSLog(@"Location Manager : Failer to track location, %@",error);
    //    UIAlertView *errorAlert = [[UIAlertView alloc]
    //                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //    [errorAlert show];
    self.locationUpdated = NO;

}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)location fromLocation:(CLLocation *)oldLocation
{
    //NSLog(@"Current location updated : %@", location);
    NSLog(@"Location manager : Location updated, %@",location);
    [self.locationManager stopUpdatingLocation];
    [[CetasConfig getDefaultInstance] setUserLatitude:location.coordinate.latitude
                       longitude:location.coordinate.longitude
              horizontalAccuracy:location.horizontalAccuracy
                verticalAccuracy:location.verticalAccuracy];
    
    self.locationUpdated = YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
    [[CetasTracker getDefaultTracker] stop];
    
    self.locationManager = nil;
    
}
#pragma UserCheckInDelegate



-(void)checkInWithUserName:(NSString *)name userId:(NSString *)userID userAge:(NSString *)userAge{
    
    CetasConfig *config = [CetasConfig getDefaultInstance];
    [config setUserName:name];
    [config setUserId:userID];
    [config setUpdateInterval:30];
    [config setUserAge:[userAge intValue]];
    
}


@end
