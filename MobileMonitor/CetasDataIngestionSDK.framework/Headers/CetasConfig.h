//
//  CetasConfig.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//
//  Methods in this header file are for use with Cetas Analytics.

#import <Foundation/Foundation.h>

/*!
 * @brief : Provides all the methods to set and retrieve configuration parameters.
 *
 *  Provides set of methods that allow developers to specify configuration parameters.
 *
 */


@interface CetasConfig : NSObject
/*
 * Flag to show error in logs.
 */
@property BOOL showErrorInLogs;
/*!
 * @brief :Static method that provides a config object with default values set. 
 * 
 *
 */

+(id)config;
/*!
 *  @brief Method to set a time interval between each dispatch  of the generated events to the Cetas service. Until the interval is not reached events are buffered.
     This method should be used by the application developer to explicitly set the time interval 
     for which the Cetas Analytics would buffer the generated events (till the maximum capacity is 
     reached), before they are dispatched to the Cetas service. Events will be dispatched 
     periodically after every update time interval.
 *   @note: If not set, the default value is set to 120 sec. Maximum possible value for update interval is 1800 sec (1/2 hr). If update interval exceeds the max value, it will adjust itself to max value(i.e 1800 sec).Allowable range is 60 to 1800 seconds.
     If value is not passed within allowed range(60-1800 sec) it is logged in console, if showErrorInLogs in config object is enabled.
 *
 *  @param updateInterval: Number of seconds for update interval.
 */

-(void)setUpdateInterval:(NSTimeInterval)updateInterval;


/*!
 * @brief : Method to set the size upto which buffer can accumulate events before sending request to the Cetas service within an interval. It 
 *          also denotes the batch size in which the events are dispatched to the server.
 *
 * @note :  If not set, the default value is set to 250 events. It is recommended for the developer     to set this property as per their application's need. Maximum possible batch size that can be set is 500 events. If batch size set exceeds the max value, it will adjust itself to the max value (i.e 500).
     It is recommended for the developer to set this limit as per their application's need.
     For example, a gaming application that has a high event logging rate can keep this value as 
     500. Other simple utility applications can keep this value upto 300.
     If value is not passed within allowed range(1-500 events) it is logged in console, if 
     showErrorInLogs in config object is enabled.
 *
 * @param : batchSize: Number of events.
 *
 */
-(void)setBatchSize:(NSInteger)batchSize;

/*!
 *  @brief Returns the batch size set in CetasConfig.
 */

-(NSInteger)getBatchSize;

/*!
 *
 * @brief : Method to set the maximum number of events that can be stored in SDK's database.
 *
 * @note : - If the number of events in the buffer continues to grow beyond this number, the oldest events are replaced by the incoming events , thus maintaining the buffer size.
 *         - If not explicitly set, it takes a default value of 30000, i.e. it will store 30000.    
             (which occupies approximately 15 MB of device
 *           space, assuming that the events have three keys value pairs.)
 *         - It is recommended that the developer estimate the buffer size, keeping in mind the 
             size of the events (in terms of the <key, value> pairs) that are being tracked and the
             frequency of event generation in the application, as event logging adds to the application's workspace .
 *           For example, a gaming application which has a relatively high event logging rate, may
             use a buffer size upto 30K events, while for a simple utility application, a buffer
             size of 15K may be sufficient.
          
 *
 */
-(void)setBufferSize:(NSInteger)bufferSize;


/*!
 *
 * @brief : This method returns the buffer size set in the CetasConfig object.
 *
 */
-(NSInteger)getBufferSize;

/*!
 *  @brief Returns the update interval set in CetasConfig.
 *  This method returns the update interval set in CetasConfig object.
 *
 */
-(NSTimeInterval)getUpdateInterval;
/*!
 *  @brief Retrieves the Current Cetas SDK Version.
 *
 *  This is an optional method that retrieves the Cetas SDK Version the app is running under.
 *  @return The agent version of the Cetas SDK.
 *
 */
+ (NSString *)getCetasSDKVersion;

@end