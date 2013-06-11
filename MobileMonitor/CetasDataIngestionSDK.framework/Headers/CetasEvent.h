//
//  CetasEvent.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

//  Event Class : Encapsulates custom events to be submitted to the Cetas Analytics Service.

#import <Foundation/Foundation.h>

@interface CetasEvent : NSObject

/*!
*  @brief: Sets the event time to the specified date (using its epoch value).
   @param: date: Date of event occurrence. 
*/
-(void)setDate:(NSDate *)date;

/*!
 *  @brief: Sets the event time to the specified epoch value.
 *  @param: time: Time of event occurrence.
 */
-(void)setTime:(NSTimeInterval)time;

/*!
 *  @brief: Adds all the specified <name, value> pairs to the Event attributes
 *  @note Private or confidential information about your users should not be passed while logging events.
 *  @code : 
    //Initialize event object.
    Event *event = [[Event alloc] init];
    // Add event detail to dictionary similar to filling map in Java.
    NSDictionary *eventDetail = [NSDictionary dictionaryWithObjectsAndKeys:
            @"1000",@"bonus",@"2" ,@"level", nil];
    [event setEventDetail:eventDetail];
    @param: eventDetail : NSDictionary for specifying the event attributes. A map containing Name-Value pairs of parameters.
 */
-(void)setEventDetail:(NSDictionary *)eventDetail;
/*!
 *  @brief: Adds a new attribute <name, value> pair to the Event class.
    @note Private or confidential information about your users should not be passed while logging events.
    @code :
    //Initialize event object.
    Event *event = [[Event alloc] init];
    // Add event detail to dictionary similar to filling map in Java.
    [event setEventAtribute:@"bonus" forKey:@"2000"];
 @param:  attributeValue:  String representing event attribute value.
 @param: attributeKey : String representing event attribute key.
 */
-(void)setEventAttribute:(NSString *)attributeValue forKey:(NSString *)attributeKey;

/*!
 *  @brief: Retrieves an existing event attribute with the specified name.
 *  @param:key: String specifying the event attribute key whose value needs to be retrieved.
 */
-(NSString *)getEventAttributeForKey:(NSString *)key;


@end