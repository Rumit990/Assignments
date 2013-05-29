//
//  AppDelegate.h
//  CetasAppInsights
//
//  Copyright (c) 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>{
    UIBackgroundTaskIdentifier bgTask;
}

@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) dispatch_block_t expirationHandler;
@property (strong) CLLocationManager *locationManager;
@property BOOL locationUpdated;

@end
