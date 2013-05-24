//
//  AppListViewController.h
//  CetasAppInsights
//
//  Created by Vipin Joshi on 23/05/13.
//  Copyright (c) 2013 Cetas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconDownloader.h"

@class AppListViewController;

@protocol AppListViewDelegate <NSObject>


@end

@interface AppListViewController : UITableViewController<IconDownloaderDelegate>


@property (unsafe_unretained) id<AppListViewDelegate> delegate;
@property (strong) NSString *appCategory;

- (id)initWithStyle:(UITableViewStyle)style category:(NSString *)paramCategory;

@end
