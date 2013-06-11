//
//  AppListViewController.h
//  CetasAppInsights
//  Copyright (c) 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.

//This class used to display information about detected apps and Running apps in table view.
#import <UIKit/UIKit.h>
#import "IconDownloader.h"


@class AppListViewController;

@protocol AppListViewDelegate <NSObject>


@end

@interface AppListViewController : UITableViewController<IconDownloaderDelegate>


@property (unsafe_unretained) id<AppListViewDelegate> delegate;
// Two Values : Running apps or Installed Apps
@property (strong) NSString *appCategory;

//Custom Initializer
- (id)initWithStyle:(UITableViewStyle)style category:(NSString *)paramCategory;

@end
