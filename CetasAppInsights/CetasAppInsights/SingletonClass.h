//
//  SingletonClass.h
//  CetasAppInsights
//
//  Created by Prateek Pradhan on 23/05/13.
//  Copyright (c) 2013 Cetas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonClass : NSObject

/**
 * Called to get shared instance of this class. If not already exists, it creates one and returns that
 */
+ (id)sharedInstance;
+ (void) setNavigationTitleFont: (UINavigationItem *) navItem;
@end
