//
//  AppDelegate.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import <UIKit/UIKit.h>
#import "CetasTracker.h"
#import "UserDetailsViewController.h"

#import <CoreLocation/CoreLocation.h>

@class AppDelegate;



#define kEnableAutoFireEvents NO 

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong) CLLocationManager *locationManager;
@property BOOL locationUpdated;


@end
