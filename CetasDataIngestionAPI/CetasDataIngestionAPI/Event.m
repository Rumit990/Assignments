//
//  Event.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

//  Event Class : Encapsulates custom events to be submitted to the Cetas Analytics Service.

#import "EventUtil.h"
#import "Event.h"
#import "Constants.h"
#import "JsonParser.h"


@implementation Event
/*
 * Default Initializer.
 */
- (id)init
{
    self = [super init];
    if (self) {
        // By default set the event type as message.
        self.type = kMessageRequestTypeMessage;
        self.attributesName = @"custom";
        self.attributes = [[NSMutableDictionary alloc] init];
        
    }
    return self;
}
/*!
 * @brief: Custom Initializer. Used to create event with certain type.
 * In case of login type is kMessageTypeLogin.
 */
-(id)initWithType:(NSInteger)paramType{
    self = [super init];
    if (self) {
        // Work your initialising magic here as you normally would
        self.type = paramType;
        self.attributesName = @"attributes";
        self.attributes = [[NSMutableDictionary alloc] init];
        self.sequenceNumber = 1;
        
    }
    return self;
}

/*!
 *  @brief: Sets the event time to the specified date (using its epoch value).
 */
-(void)setDate:(NSDate *)date{
    self.time = [date timeIntervalSince1970];
}
/*!
 *  @brief: Sets the event time to the specified epoch value.
 */
-(void)setTime:(NSTimeInterval)time{
    self.eventTime = time;
}
/*!
 *  @brief: Adds all the specified <name, value> pairs to the Event attributes
 */
-(void)setEventDetail:(NSDictionary *)eventDetail{
    self.attributes = [[NSMutableDictionary alloc] initWithDictionary:eventDetail];
}
/*!
 *  @brief: Adds a new attribute <name, value> pair to the Event class.
 */

-(void)setEventAtribute:(NSString *)eventName forKey:(NSString *)eventValue{
    
    [self.attributes setObject:eventValue forKey:eventName];
}

/*!
 *  @brief: Retrieves an existing event attribute with the specified name.
 */
-(NSString *)getEventAttributeForKey:(NSString *)key{
    return [self.attributes objectForKey:key];
}
/*!
 *  @brief: Returns json representation of an event.
 *
 */
-(NSString *)getEventJsonRepresentation{
    
    NSMutableDictionary *eventDic = [[NSMutableDictionary alloc] init];
    NSNumber *time = [NSNumber numberWithDouble:self.eventTime];
    [eventDic setObject:time forKey:@"time"];
    //[eventDic setObject:@"10.6" forKey:@"osVerion"];
    [eventDic setObject:[NSNumber numberWithInteger:self.sequenceNumber] forKey:@"sequence"];
    [eventDic setObject:[NSNumber numberWithInteger:self.type] forKey:@"type"];
    [eventDic setObject:self.attributes forKey:self.attributesName];
    return [JsonParser JSONRepresentation:eventDic];
}
@end
