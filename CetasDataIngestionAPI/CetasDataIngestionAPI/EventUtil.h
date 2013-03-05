//
//  EventVO.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//


#import <Foundation/Foundation.h>
#import "Event.h"

/*
 * Private interface for Event class. This is visible only inside the project (i.e  inner class of static library).
 */
@interface Event (){
    
}
/*
 * Specify event time.
 */
@property NSTimeInterval eventTime;
/*
 * Specify sequence number of event. It must be unique for each event.
 */
@property NSInteger sequenceNumber;
/*
 *  Integer value denoting the event type. Possible values are:
 *  kMessageTypeLogin 0
 *  kMessageTypeUpdate 1
 *  kMessageTypeLogout 2
 */
@property NSInteger type;
/*
 * Dictionary carring event characteristic information. In case of login message type this will contain device context information.
 *
 */
@property (strong) NSMutableDictionary *attributes;
/*
 * Attribute Name: Key for event attributes dictionary.This will be 'custom' in case of event and 'attributes' in case of login.
 *
 */
@property (strong) NSString *attributesName;
/*! 
 *  @brief: Returns json representation of an event.
 *
 */
-(NSString *)getEventJsonRepresentation;
/*!
 * @brief: Custom Initializer. Used to create event with certain type.
 * In case of login type is kMessageTypeLogin.
 */
-(id)initWithType:(NSInteger)paramType;

@end
