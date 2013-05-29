//
//  AppInfoViewController.h
//  CetasAppInsights
//  Copyright (c) 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//
//This class is used to display Application Information.


#import <UIKit/UIKit.h>
#import "Constants.h"

@interface AppInfoViewController : UITableViewController{
    UIImage *appIconImage;
}
//Stores app info item array.each item is dictionaries.
@property (strong) NSArray *appInfoItemArray;
//Store App icon Image
@property (strong) UIImage *appIconImage;
//Hold reference to app name.
@property (strong) NSString *appName;
@end
