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
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) dispatch_block_t expirationHandler;
@property (strong) CLLocationManager *locationManager;
@property  UIBackgroundTaskIdentifier bgTask;
@property BOOL locationUpdated;
@property NSTimer *timer;
@property BOOL isBackground;
@property (strong) NSString *lastLoggingTime;
 

@end
