//
//  SingletonClass.m
//  CetasAppInsights
//
//  Created by Prateek Pradhan on 23/05/13.
//  Copyright (c) 2013 Cetas. All rights reserved.
//

#import "SingletonClass.h"

@implementation SingletonClass
static SingletonClass *sharedInstance = nil;

/**
 * Called to get shared instance of this class. If not already exists, it creates one and returns that
 */
+ (SingletonClass *)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

//default initializer
- (id)init
{
    self = [super init];
    
    if (self) {
        // Work your initialising magic here as you normally would
     
    }
    
    return self;
}

+ (void) setNavigationTitleFont: (UINavigationItem *) navItem  {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    //label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.text = navItem.title;
    
    label.textColor =[UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:13.0];
    
    navItem.titleView = label;
    [navItem.titleView sizeToFit];
    
}

@end
