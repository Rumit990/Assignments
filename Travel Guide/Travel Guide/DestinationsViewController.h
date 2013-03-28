//
//  DestinationsViewController.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

/*!
 * @brief : Displays the list of destination for the selected country.
 *
 */

#import <UIKit/UIKit.h>

@interface DestinationsViewController : UITableViewController


// Holds reference to the selected country.
@property (strong) NSString *country;

// Holds reference to the list of destinations corresponding to the selected conutry.
@property (strong) NSArray *destinations;

- (id)initWithStyle:(UITableViewStyle)style country:(NSString *)country andDestinations:(NSArray *)destinations;

@end
