//
// CetasTracker.h
// Cetas iOS Analytics Agent
// CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

//  Methods in this header file are for use with Cetas Analytics.


#import <Foundation/Foundation.h>
#import "Config.h"
#import "EventUtil.h"

/*!
 * @brief : Provides all the methods for defining and logging Analytics from use of your app.
 * 
 *  Provides set of methods that allow developers to log detailed and aggregate information  regarding the use of their app by end users.
 *
 */


@interface CetasTracker : NSObject


/*!
 * @brief : Initialize the tracker object. 
 *
 *  This method serves as starting point for tracking information.  It must be
 *  called in the scope of @c applicationDidFinishLaunching. This will create a session with the cetas service for timeout inteval as set in config object.
 *  Prior to calling this, Config Object must created with all user information and configuration flag set(example update inteval and timeout).
 * @code:
 *  
 - (void)applicationDidFinishLaunching:(UIApplication *)application
 {
   //....
    Config *config = [[Config alloc] init];
    [config setUserName:@"Some One"];
    [config setUserId:@"SomeOne"];
    [config setUserAge:age gender:kGenderMale remark:@"some remark"];
 
    // For setting location app developer has to include core location framework and call config class setter for location.
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    [locationManager startUpdatingLocation];
    CLLocation *location = locationManager.location;
 
    //Set user location in config.
    [config setLatitude:location.coordinate.latitude  longitude:location.coordinate.longitude
    horizontalAccuracy:location.horizontalAccuracy  verticalAccuracy:location.verticalAccuracy];
    //Create a Tracker Object
    CetasTracker *tracker = [[CetasTracker alloc] initWithApiKey:@"apiKey" config:config];
   //...
}
 
 * @params
 *   apikey : The API key for this project.
 *   confid : Configuration object having all user information and configuraion flags set.
 */
- (id)initWithApiKey:(NSString *)apiKey  config :(Config *)config;


/*!
 * @brief : Provides a singleton tracker object.
 * 
 * For convenience, this class provides a default CetasTracker instance.
 * This is initialized to `nil` and will be set to the tracker that is
 * instantiated in - (id)initWithApiKey:(NSString *)apiKey  config :(Config *)config .
 * It may be overridden as desired.
 * 
 */
+ (id)getDefaultTracker;

/*!
 * @name : Logs Single event.
 * @brief : Records a event specified by event object.
 *  This method allows you to specify custom events within your app. Usually  developer should log events related to navigation or page view, any user action, and other events as they are applicable to tracking progress towards your business goals.
 *  * The Events are stored on to buffer until capacity and time interval as set in config object are not exceeded. Events are stored on to buffer until capacity and time interval as set in config object are not exceeded.
 *
 * @code:
    //Log a single event in the app code:
    //Initialize event object.
    Event *event= [[Event alloc] init];
    // Add event detail to dictionary similar to filling map in Java.
    NSDictionary *eventDetail = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"1000",@"bonus",@"2" ,@"level", nil];
    //Set event Detail
    [event setEventDetail:eventDetail];
    // Logging a single event.
    [[CetasTracker getDefaultTracker] logEvent:event];
 
 * @note Private or confidential information about your users should not be passed while logging events.
 
 * @param
 * Event : Event Object with all its parameters set like details(event detail),date and time(optional).
 */
- (void)logEvent:(Event *)event;
/*!
 * @name : Logs multiple events.
 * @brief : Records multiple events together.
 *
 *  This method allows you to specify custom events within your app. Usually developers should log events related to navigation or page view, any user action, and other events as they are applicable to tracking progress towards their business goals.
 * The Events are stored on to buffer until capacity and time interval as set in config object are not exceeded.
 *
 * @code
    //Initialize event object.
    Event *event1= [[Event alloc] init];
    // Add event detail to dictionary similar to filling map in Java.
    NSDictionary *eventDetail1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"1000",@"bonus",@"2" ,@"level", nil];
     //Set event Detail
     [event1 setEventDetail:eventDetail];
 
    Event *event2= [[Event alloc] init];
    // Add event detail to dictionary similar to filling map in Java.
    NSDictionary *eventDetail2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"2000",@"bonus",@"3" ,@"level", nil];
    //Set event Detail
    [event2 setEventDetail:eventDetail];
 
 
    NSMutableArray *events =[NSMutableArray alloc] init];
    [events addObjects:event1]
    [events addObjects:event2]
    // Logging a single event.
    [[CetasTracker getDefaultTracker] logEvents:events];
 
 * @note Private or confidential information about your users should not be passed while logging events.
 
 * @param
 * Events :Array of Event class Objects with all its param set.
 */
- (void)logEvents:(NSArray *)events;


/*!
 * @name : Logs event with details.
 * @brief : This method allows you record event in a single call. Developer don't need to create a event object in this call.
  * The Events are stored on to buffer until capacity and time interval as set in config object are not exceeded.
 * @code:
 * [[CetasTracker getDefaultTracker] logEventWithEventDetails:[NSDictionary dictionaryWithObjectsAndKeys:@"2000",@"bonus",@"3" ,@"level", nil]];
 *
 * @note Private or confidential information about your users should not be passed while logging events.
 * @param
 * eventDetail : NSMutableDictionary having event details to log.
 */
- (void)logEventWithEventDetails:(NSMutableDictionary *)eventDetail;

/*!
 * @brief : This method allows you to stop tracking for events. This will stop any furthur tracking of event within app.This method closes the session with cetas analytics service. Once this method has been called, it is an error to call any of the tracking methods, and they will not result in the generation of any tracking information to be submitted to Cetas Analytics.
 */
- (void)stopTracker;
/*!
 * @name : Send an event information to service forcefully.
 * @brief : This method updates the custom event to cetas service surpassing the criteria of capacity/update inteval.As soon as it is called, events are updated on Cetas Server.In case internet is not connected events are stored on to buffer.
 *
 * @code:
    //Log a single event in the app code:
    //Initialize event object.
    Event *event= [[Event alloc] init];
    // Add event detail to dictionary similar to filling map in Java.
    NSDictionary *eventDetail = [NSDictionary dictionaryWithObjectsAndKeys:
        @"1000",@"bonus",@"2" ,@"level", nil];
    //Set event Detail
    [event setEventDetail:eventDetail];
    // Logging a single event.
    [[CetasTracker getDefaultTracker] updateEvent:event];
 
 * @note Private or confidential information about your users should not be passed while logging events.
 
 * @param
 * Event : Event Object with all its parameters set like details(event detail),date and time(optional).
 */
- (void)updateEvent:(Event *)event;

/*!
 * @name : Send an multiple event information to service forcefully.
 * @brief : This method updates the custom events to cetas service surpassing the criteria of capacity/update inteval. As Soon as it is called,  events are updated on Cetas Server.In case internet is not connected events are stored on to buffer.
 *
 *  This method allows you to specify custom events within your app. Usually developers should log events related to navigation or page view, any user action, and other events as they are applicable to tracking progress towards their business goals.
 * @code
    //Initialize event object.
    Event *event1= [[Event alloc] init];
    // Add event detail to dictionary similar to filling map in Java.
    NSDictionary *eventDetail1 = [NSDictionary dictionaryWithObjectsAndKeys:
        @"1000",@"bonus",@"2" ,@"level", nil];
    //Set event Detail
    [event1 setEventDetail:eventDetail];
 
    Event *event2= [[Event alloc] init];
    // Add event detail to dictionary similar to filling map in Java.
    NSDictionary *eventDetail2 = [NSDictionary dictionaryWithObjectsAndKeys:
        @"2000",@"bonus",@"3" ,@"level", nil];
    //Set event Detail
    [event2 setEventDetail:eventDetail];
 
 
    NSMutableArray *events =[NSMutableArray alloc] init];
    [events addObjects:event1]
    [events addObjects:event2]
    // Logging a single event.
    [[CetasTracker getDefaultTracker] updateEvents:events];
 
 * @note Private or confidential information about your users should not be passed while logging events.
 
 * @param
 * Events :Array of Event class Objects with all its param set.
 */

- (void)updateEvents:(NSArray *)events;

@end
