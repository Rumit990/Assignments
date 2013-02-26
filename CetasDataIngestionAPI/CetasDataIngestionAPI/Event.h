//
//  Event.h
//  CetasDataIngestionAPI
//
//  Created by Prateek Pradhan on 26/02/13.
//  Copyright (c) 2013 Cetas Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

-(void)setDate:(NSDate *)date;
-(void)setTime:(NSTimeInterval)time;
-(void)setEventDetail:(NSDictionary *)eventDetail;
-(void)setEventAtribute:(NSString *)eventName forKey:(NSString *)eventValue;
-(NSString *)getEventAttributeForKey:(NSString *)key;


@end