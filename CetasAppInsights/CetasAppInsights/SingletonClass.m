//
//  SingletonClass.m
//  CetasAppInsights
//
//  Copyright (c) 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import "SingletonClass.h"
#import "RunningApps.h"
#import "Constants.h"
#import <CetasDataIngestionSDK/CetasTracker.h>

@implementation SingletonClass
static SingletonClass *sharedInstance = nil;

/**
 * Called to get shared instance of this class. If not already exists, it creates one and returns that
 */
+ (SingletonClass *)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

//default initializer
- (id)init
{
    self = [super init];
    
    if (self) {
        // Work your initialising magic here as you normally would
     
    }
    
    return self;
}

+ (void) setNavigationTitleFont: (UINavigationItem *) navItem  {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    //label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.text = navItem.title;
    
    label.textColor =[UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:13.0];
    
    navItem.titleView = label;
    [navItem.titleView sizeToFit];
    
}
/*
 * Used to track running apps at regular inteval of time.
 */

-(void)trackRunningApps{
    
   
    RunningApps *runningApps =[[RunningApps alloc] init];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [runningApps detectAppDictionariesWithIncremental:^(NSArray *appDictionaries) {
        //NSLog(@"Incremental appDictionaries.count: %i", appDictionaries.count);
        //Do nothing.
    } withSuccess:^(NSArray *appDictionaries) {
        //Block for successfull response.
        NSLog(@"Successful appDictionaries.count: %i", appDictionaries.count);
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if(appDictionaries.count){
            
            // Track Cetas events for each app.
            [self logCetasEvents:appDictionaries category:kApplicationCategoryActive];
            

        }
    } withFailure:^(NSError *error) {
        //Block for error cases.
        NSLog(@"Error: %@", error.localizedDescription);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    }];    
}
/*
 * Logs the Cetas Events for running app information.
 */
-(void)logCetasEvents:(NSArray *)appsInfoArray category:(NSString *)category{
    
    
    
    NSString *categoryName = @"Installed";
    if([category isEqualToString:kApplicationCategoryActive]){
        categoryName = @"Running";
    }
    // Track running app/ installed app event for each app.
    for (NSMutableDictionary *appInfo in appsInfoArray) {
        NSMutableDictionary *eventInfoDic =[[NSMutableDictionary alloc] init];
        [eventInfoDic setObject:[appInfo objectForKey:@"trackName"] forKey:@"App Name"];
        NSString *appID  = [NSString stringWithFormat:@"%@",[appInfo objectForKey:@"trackId"]];
        
        [eventInfoDic setObject:appID   forKey:@"App Id"];
        if([category isEqualToString:kApplicationCategoryActive]){
            NSDate *date =[NSDate dateWithTimeIntervalSince1970:[[appInfo objectForKey:kDictKeyStartTime] doubleValue]];
            if(date){
                [eventInfoDic setObject:[appInfo objectForKey:kDictKeyStartTime]  forKey:@"App Launch Time"];
            }
        }
        
        [[CetasTracker getDefaultTracker] trackEventWithCategory:categoryName eventDetail:eventInfoDic];
        
    }
    
    if([category isEqualToString:kApplicationCategoryActive]){
        
        //Check if app id was there is previously running app.Send the total run time for the app to Cetas if app stopped running.
        NSMutableDictionary *currAppInfo =[[NSMutableDictionary alloc] init];
        for (NSMutableDictionary *dic in appsInfoArray) {
            NSString *appID  = [NSString stringWithFormat:@"%@",[dic objectForKey:@"trackId"]];
            [currAppInfo setObject:dic forKey:appID];
        }
        //Comparing with previos running apps and track app running time those were closed.
        for (NSString *appId in self.prevAppInfoDictionaries) {
            if(![currAppInfo objectForKey:appId]){
                //It means now the app is closed.
                NSMutableDictionary *preAppInfo = [self.prevAppInfoDictionaries objectForKey:appId];
                                                   
                NSDate *date =[NSDate dateWithTimeIntervalSince1970:[[preAppInfo objectForKey:kDictKeyStartTime] doubleValue]];
                if(date){
                    NSNumber *sec = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970] - [date timeIntervalSince1970]];
                    
                    NSMutableDictionary *eventInfo =[[NSMutableDictionary alloc] init];
                    [eventInfo setObject:sec forKey:@"App Running Time (Sec)"];
                    [eventInfo setObject:[preAppInfo objectForKey:@"trackName"] forKey:@"App Name"];
                    [eventInfo setObject:appId forKey:@"App Id"];
                    
                    [[CetasTracker getDefaultTracker] trackEventWithCategory:@"Terminated" eventDetail:eventInfo];
                }
            }
        }
        // Track the apps which runs together and the same time.
//        NSMutableArray  *trackNames =[[NSMutableArray alloc] init];
//        for (NSMutableDictionary *appInfo in appsInfoArray) {
//            
//            [trackNames addObject:[appInfo objectForKey:@"trackName"]];
//            
//        }
//        NSMutableDictionary *eventInfoDic =[NSMutableDictionary dictionaryWithObject:[trackNames componentsJoinedByString:@","] forKey:@"Running Apps"];
//        [[CetasTracker getDefaultTracker] trackEventWithCategory:@"Set of " eventDetail:eventInfoDic];
        
        self.prevAppInfoDictionaries =[[NSMutableDictionary alloc] init];
        for (NSMutableDictionary *dic in appsInfoArray) {
            NSString *appID  = [NSString stringWithFormat:@"%@",[dic objectForKey:@"trackId"]];
            [self.prevAppInfoDictionaries setObject:dic forKey:appID];
        }
    }
    
    NSLog(@"Cetas Events Info logged.");
    
}



@end
