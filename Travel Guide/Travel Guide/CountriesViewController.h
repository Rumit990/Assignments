//
//  CountriesViewController.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//


/*!
 * @brief : Displays the list of countries.
 *
 */

#import <UIKit/UIKit.h>

@interface CountriesViewController : UITableViewController

// Holds the list of countries.
@property (strong) NSArray *countries;

// Holds the Countries and their coresponding destinations in <key,value> format.
@property (strong) NSDictionary *countriesAndDestinations;



@end
