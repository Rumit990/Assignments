//
//  DestinationInfoViewController.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//


/*!
 * 
 * @brief : Displays information for the selected destination.
 *
 */

#import <UIKit/UIKit.h>

@interface DestinationInfoViewController : UIViewController


@property (strong) IBOutlet UIImageView *imageView;

// Holds reference to the selected country.
@property (strong) NSString *country;

// Holds reference to the selected destination.
@property (strong) NSString *destination;

-(id)initWithCountry:(NSString*)country destination:(NSString *)destination;

@end
