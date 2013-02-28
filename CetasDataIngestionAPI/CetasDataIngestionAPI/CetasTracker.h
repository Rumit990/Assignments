//
//  CetasTracker.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import <Foundation/Foundation.h>
#import "Config.h"
#import "EventUtil.h"

@interface CetasTracker : NSObject


- (id)getTrackerWithApiKey:(NSString *)apiKey  config :(Config *)config ;
+ (id)getDefaultTracker;
- (void)logEvent:(Event *)event; // Later track event
- (void)logEvents:(NSArray *)events;
- (void)logEventWithEventDetails:(NSMutableDictionary *)eventDetail;
- (void)stop;


@end
