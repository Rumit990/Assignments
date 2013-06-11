//
//  SingletonClass.h
//  CetasAppInsights
//
//  Copyright (c) 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import <Foundation/Foundation.h>

@interface SingletonClass : NSObject


/**
 * Called to get shared instance of this class. If not already exists, it creates one and returns that
 */
+ (id)sharedInstance;
+ (void) setNavigationTitleFont: (UINavigationItem *) navItem;
/*
 * Used to track running apps at regular inteval of time.
 */

-(void)trackRunningApps;
/*
 * Logs the Cetas Events for tacking installed /running application information.
 */
-(void)logCetasEvents:(NSArray *)appsInfoArray category:(NSString *)category;
//Hold reference to running app information for previous iteration.
@property (strong) NSMutableDictionary *prevAppInfoDictionaries;

@end
