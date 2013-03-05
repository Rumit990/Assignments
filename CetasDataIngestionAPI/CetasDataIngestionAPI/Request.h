//
//  Request.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//
//  Request Class : Encapsulates request params to be submitted to the Cetas Analytics Service.

#import <Foundation/Foundation.h>

@interface Request : NSObject


/*!
 *  @brief: Authentication token sent in each request to Cetas server.
 *   There are two cases:
 *  1. User's Cetas Analytics API key during a login request.
 *  2. Session key sent by the Cetas Service, once the user has logged in.
 */
@property (strong) NSString *token;
/*! 
 * @brief: Session time out interval with the cetas service.
 */
@property NSInteger timeout;

/*!
 * @brief : Contains the device contextual information like name, system name, iOS version etc.
 */
@property (strong) NSDictionary *attributes;

/*!
 *  @brief : Contains the user information like user's name, age, gender, location.
 */
@property (strong) NSDictionary *user;

/*!
 * @brief :  Stores all the events recorded in the last update time interval, in the form of array.
 * @example : 
 1. In case of login:
    "content":"{\"time\":1335845767533, \"sequence\":1, \"type\":0, \"attributes\":{\"userName\":\"Some One\", \"userID\":\"someone\"}}"
 2. In case of event update:
 "content": "{\"time\":1335845773254, \"sequence\":7, \"type\":1, \"custom\":{\"bonus\":\"1200\", \"score\":\"17592\", \"level\":\"1\", \"time\":\"43.5\"}}\n
 {\"time\":1335845773254, \"sequence\":8, \"type\":1, \"custom\":{\"bonus\":\"1000\"}}\n
 *
 */
@property (strong) NSArray *content;

/*!
 *  @brief : Returns the  a JSON  representation of request object.
 *
 *  This method generates a dictionary with all the request parameters and converts the dictinary into a JSON string using JSON parser.
 */

-(NSString *)getJSONRepresentation;

@end
