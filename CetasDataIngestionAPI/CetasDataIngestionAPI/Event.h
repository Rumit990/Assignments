//
//  Event.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//


#import <Foundation/Foundation.h>

@interface Event : NSObject

-(void)setDate:(NSDate *)date;
-(void)setTime:(NSTimeInterval)time;
-(void)setEventDetail:(NSDictionary *)eventDetail;
-(void)setEventAtribute:(NSString *)eventName forKey:(NSString *)eventValue;
-(NSString *)getEventAttributeForKey:(NSString *)key;


@end