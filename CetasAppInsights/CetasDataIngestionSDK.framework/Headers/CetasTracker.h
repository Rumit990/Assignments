//
// CetasTracker.h
// Cetas iOS Analytics Agent
// CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

//  Methods in this header file are for use with Cetas Analytics iOS SDK.


#import <Foundation/Foundation.h>
#import "CetasEventPreliminaryInfo.h"
#import "CetasEvent.h"
#import "CetasConfig.h"
#import "CetasTransaction.h"
#import "CetasGameTransaction.h"


/*!
 * @brief : Provides all the methods for defining and logging Analytics from use of your app.
 * 
 *  Provides set of methods that allow developers to log detailed and aggregate information  regarding the use of their app by end users.
 *
 */

@class CetasTracker;

/*!
 NSError objects returned by the CetasAnalytics SDK may have this error domain
 to indicate that the error originated in the CetasAnalytics SDK.
 */
extern NSString *const kCetasSDKErrorDomain;

/*
 * Following key are used in userInfo dictionary  of NSError Object returned by SDK.
 */
extern NSString *const kCetasSDKErrorUserInfoKeyServerResponse ;
extern NSString *const kCetasSDKErrorUserInfoKeyStatus ;
/*
 * Following key are used in result dictionary received from delegate methods.
 */
extern NSString *const kCetasSDKResultKeyStatus ;
extern NSString *const kCetasSDKResultKeyNumberOfEvents;
extern NSString *const kCetasSDKResultKeyData;
extern NSString *const kCetasSDKResultStatusValueSuccess;
extern NSString *const kCetasSDKResultStatusValueFailed ;

/*! Cetas Analytics error codes.  
 */
typedef enum{
    // This error code indicates that there was an unknown error.
    kCetasSDKUnknownError = 0,
    // This error code indicates that there was a network related error.
    kCetasSDKNetworkError,
    // This is returned when event tracker fails to register events to cetas server.
    kCetasSDKBackendError

} CetasiOSSDKErrorCode;


/*!
 *
 * @brief : Class implementing this protocol registers itself for a call back when the Cetas server's response is received.
 *
 */
@protocol CetasTrackerDelegate <NSObject>

@optional
/*!
 * @brief : This method should be implemented by the class that implements CetasTrackerDelegate protocol.
            It should be used as a call back method for the requesting class when the Cetas server's response is received.
 * @param : tracker, reference to the CetasTracker class's object.
 * @param : result, dictionary that represents result.
            Result Dictionary Structure Example: 
            {
                Data ={
                        NumberOfEvents = 20;
                       };
                Status = Failed;
            }
 
            Key : kCetasSDKResultKeyStatus  Possible Values : kCetasSDKResultStatusValueSuccess/kCetasSDKResultStatusValueFailed
            Key : kCetasSDKResultKeyData  Contains dictionary that contains key <kCetasSDKResultKeyNumberOfEvents, value> 
            Key :kCetasSDKResultKeyNumberOfEvents Values : NSNumber i.e the number of events tracked or failed to track.
 
 * @param : error, NSError error object specifying complete description of error.
 *        : The error codes are specified by enum  CetasiOSSDKErrorCode.
          : UserInfo key kCetasSDKErrorUserInfoKeyServerResponse value contains response dictionary received from server.
         : UserInfo key kCetasSDKErrorUserInfoKeyStatus value contains status received from the server.
 * @note : In order to get this call back when the Cetas server's response is received, a class needs to implement  CetasTrackerDelegate protocol and set itself as CetasTracker's delegate.
 */

-(void)tracker:(CetasTracker *)tracker didDispatchEventsWithResult:(NSDictionary *)result error:(NSError *)error;

@end

@interface CetasTracker : NSObject


/*
 * Holds reference to the CetasConfig object.
 */
@property (strong) CetasConfig *config;
/*
 * Holds reference to the CetasEventPreliminaryInfo object.
 */
@property (strong) CetasEventPreliminaryInfo *eventPreliminaryInfo;

/*
 * Holds reference to the CetasTracker's delegate. This delegate is given a call back when a response is received from the server for its request to handle errors, if any.
 */

@property (unsafe_unretained) id<CetasTrackerDelegate> delegate;


/*!
 * @brief : Setup API key ,configuration object and preliminary event information and delegate for the tracker object.
 *
 *  This method serves as starting point for tracking information.  It must be
 *  called in the scope of @c applicationDidFinishLaunching. 
 *  Prior to calling this, CetasConfig Object must be created with all configuration attributes set(for example update interval) and CetasEventPreliminaryInfo object must be created.
 *
 * @code:
 *  
 - (void)applicationDidFinishLaunching:(UIApplication *)application
 {
   //....
   //Prepare config object and set user information and other configuration parameter init.
    CetasEventPreliminaryInfo *userInfo = [CetasEventPreliminaryInfo eventPreliminaryInfo];// Optional
    [userInfo setUserName:@"Rob"]; // Optional
    [userInfo setUserId:@"robjordon"];// Optional
    [userInfo setUserGender:GenderMale];// Optional
    [userInfo setUserAge:26];// Optional
    [userInfo setRemark:@"A note on this user, up to 100 characters"];// Optional
 
    CetasConfig *config = [CetasConfig config];// Optional
    [config setUpdateInterval:120];// Optional
    [config setCapacity:100];// Optional
    config.showErrorInLogs = YES;
    
    // Prepare tracker object with api key and config object.
    //Here config  and userInfo both are optional. If not passed they will take default values.
    //API key is mandatory
    [[CetasTracker getDefaultTracker] startTrackerWithApiKey:kCetasApplicationKey config:config eventPreliminaryInfo:userInfo delegate:nil];
 
    //...
}
 * @endcode:
 * @param
 *   apikey : (Mandatory) The API key for your Cetas App project's application feed.
 *   config : (Optional) Configuration object with configuration flags set. 
 *   eventPreliminaryInfo :(Optional) It contains all user information and other necessary event  
                          contextual info to be sent along with events.
 *   delegate : (Optional) The class that is given a call back when server's response is received along with the result of  request.
 *
 * @note : 
        1. If config object is passed as nil, default values of all configuration parameter will be used.
        2. eventPreliminaryInfo (optional) : Set only if there is a need to track your app user information and other info along with events.

*/

- (void)startTrackerWithApiKey:(NSString *)apiKey
                       config :(CetasConfig *)config
          eventPreliminaryInfo:(CetasEventPreliminaryInfo *)info
                      delegate:(id<CetasTrackerDelegate>)trackerDelegate;


/*!
 * @brief : Provides a singleton tracker object.
 * 
 * For convenience, this class provides a default CetasTracker instance.
 * If not already initialized it will create one and return.  
 * 
 */
+ (id)getDefaultTracker;

/*!
 * @name : Logs Single event.
 * @brief : Records a event specified by event object.
 *  This method allows you to specify custom events within your app. Usually  developer should log events related to navigation or page view, any user action, and other events as they are applicable to tracking progress towards your business goals.
 *   The Events are stored on to buffer until capacity or time interval as set in config object are not exceeded. 
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
 * Event : CetasEvent Object with all its parameters set, for example details(event detail),date and time(optional).
 */
- (void)logEvent:(CetasEvent *)event;
/*!
 * @name : Logs multiple events.
 * @brief : Records multiple events together.
 *
 *  This method allows you to specify custom events within your app. Usually developers should log events related to navigation or page view, any user action, and other events as they are applicable to tracking progress towards their business goals.
 * The Events are stored on to buffer until capacity or time interval as set in config object are not exceeded.
 *
 * @code
    //Initialize event object.
    Event *event1= [[Event alloc] init];
    // Add event details to dictionary.
    NSDictionary *eventDetail1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"1000",@"bonus",@"2" ,@"level", nil];
     //Set event Detail
     [event1 setEventDetail:eventDetail];
 
    Event *event2= [[Event alloc] init];

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
 * Events :Array of CetasEvent class Objects with all its param set.Number of events must be less than maximum allowed otherwise method will simply log error message and return.
 */
- (void)logEvents:(NSArray *)events;



/*!
 * @brief : This method allows you to stop tracking for events. This will stop any furthur tracking of event within app. Once this method has been called, it is an error to call any of the tracking methods, and they will not result in the generation of any tracking information to be submitted to Cetas Analytics.
 */
- (void)stopTracker;

/*!
 * @name : Send an event information to service forcefully.
 * @brief : This method pushes the custom event to cetas service surpassing the criteria of capacity/update inteval.As soon as it is called, events are updated on Cetas Server.In case internet is not connected events are stored on to buffer.
 *
 * @code:
    //Log a single event in the app code:
    //Initialize event object.
    Event *event= [[Event alloc] init];
    // Add event detail to dictionary 
    NSDictionary *eventDetail = [NSDictionary dictionaryWithObjectsAndKeys:
        @"1000",@"bonus",@"2" ,@"level", nil];
    //Set event Detail
    [event setEventDetail:eventDetail];
    // Logging a single event.
    [[CetasTracker getDefaultTracker] pushEvent:event];
 * @endcode:

 * @note Private or confidential information about your users should not be passed while logging events.
 
 * @param
 * Event : CetasEvent Object with all its parameters set like details(event detail),date and time(optional).
 */
- (void)pushEvent:(CetasEvent *)event;

/*!
 * @name : Send an multiple event information to service forcefully.
 * @brief : This method pushes the custom events to cetas service surpassing the criteria of capacity/update interval. As soon as it is called,  events are updated on Cetas Server.In case internet is not connected, events are stored on to buffer.
 *
 *  This method allows you to specify custom events within your app. Usually developers should log events related to navigation or page view, any user action, and other events as they are applicable to tracking progress towards their business goals.
 * @code
    //Initialize event object.
    Event *event1= [[Event alloc] init];
    // Add event detail to dictionary 
    NSDictionary *eventDetail1 = [NSDictionary dictionaryWithObjectsAndKeys:
        @"1000",@"bonus",@"2" ,@"level", nil];
    //Set event Detail
    [event1 setEventDetail:eventDetail];
 
    Event *event2= [[Event alloc] init];
    // Add event detail to dictionary 
    NSDictionary *eventDetail2 = [NSDictionary dictionaryWithObjectsAndKeys:
        @"2000",@"bonus",@"3" ,@"level", nil];
    //Set event Detail
    [event2 setEventDetail:eventDetail];
 
 
    NSMutableArray *events =[NSMutableArray alloc] init];
    [events addObjects:event1]
    [events addObjects:event2]
    // Logging a single event.
    [[CetasTracker getDefaultTracker] pushEvents:events];
 
 * @note Private or confidential information about your users should not be passed while logging events.
 
 * @param
 * Events : Array of CetasEvent class Objects with all its param set. Number of events must be less than maximum allowed otherwise method will simply log error message and return.
 */

- (void)pushEvents:(NSArray *)events;

/*!
 *  @brief : This method could be used by the user to forcefully send the events present in the
 *          buffer to the service. By default update operation is performed periodically after every update interval as set in CetasConfig object.
 *
 */
-(void)pushEvents;

/*!
 *  @brief Track an app error. The method report errors in app to Cetas Analytics.
 *  @param errorName Name of the error.
 *  @param description The description associate with the exception.
 *  @param error The error object to report.
 */
-(void)logError:(NSString *)errorName description:(NSString *)description error:(NSError *)error;
/*!
 *  @brief Track an app exception. Generally used to catch unhandled exceptions.
 *
 *  The method report exception in app to Cetas Analytics. It is recommended to add an uncaught
 *  exception listener to capture any exceptions that occur during usage that is not
 *  anticipated by your app.
 *
 *  @code
 * (void) uncaughtExceptionHandler(NSException *exception)
 {
 [[CetasTracker getDefaultTracker] logError:@"Uncaught" description:@"Crash!" exception:exception];
 }
 
 - (void)applicationDidFinishLaunching:(UIApplication *)application
 {
 NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
 // .code to setup SDK...
 }
 *  @endcode
 *
 *  @param errorName Name of the error.
 *  @param description The description associate with the exception.
 *  @param exception The exception object to report.
 */
- (void)logError:(NSString *)errorName description:(NSString *)description exception:(NSException *)exception;



/*!
 * @brief : This method tracks gaming events such as 'start game', 'stop game' and 'level upgrade'. This method creates a gaming event and logs 
            it.
 *
 * @param : actionName, the name of the action performed. Required parameter, i.e. cannot be left 'nil'. Eg: 'START','UPGRADE','STOP'. 
 * @param : gameId, the game id, required parameter, i.e. cannot be left 'nil'.
 * @param : gameName, the game name, required parameter, i.e. cannot be left 'nil'.
 * @param : gameVersion, the game version, optional, can be set to 'nil'.
 * @param : gameLevel, The game level, as an NSInteger.
 *
 * @code
    
 * Example :
 
    [[CetasTracker getDefaultTracker] trackGameWithAction:@"START" gameID:@"00002" gameName:@"Three Kingdoms"
    gameVersion:@"2.1" gameLevel:1];

 *
 */
-(void)trackGameWithAction:(NSString *)actionName
                    gameID:(NSString *)gameID
                  gameName:(NSString *)gameName
               gameVersion:(NSString *)gameVersion
                 gameLevel:(NSInteger) gameLevel;


/*!
 *
 * @brief : This method facilitates tracking of virtual good purchases. It tracks the player's purchase event when they are playing the game .
            This method logs the gaming transaction and details of the purchased items involved in that transaction.
 *
 * @param : gameTransaction, instance of the CetasGameTransaction class with all the required parameters set. (please see the
 *          CetasGameTransaction class for the detailed description of its parameters and methods.)
 * 
 * @code :

 *  Example :
 
    CetasGameTransaction *transaction = [CetasGameTransaction gameTransactionWithGameId:@"00002" transactionId:@"order_001" totalAmount:18.89 gameVersion:@"2.1" gameLevel:1];
 
    [transaction addItemWithItemName:@"magic_ball" itemPrice:9.99 itemQuantity:2];
 
    [[CetasTracker getDefaultTracker] trackGameTransaction:transaction];
 *
 
 *
 */

-(void)trackGameTransaction:(CetasGameTransaction *)gameTransaction;


/*!
 *
 * @brief : This method track player's invitations to friends from inside the game. It is used to perform engagement analysis.This method creates 
            a game invitation event and logs it.
 *
 * @param : gameId, the ID of the game. Required parameter, i.e. cannot be left 'nil'.
 * @param : inviteeList, array of names of invitees to whom the game invitation is to be addressed. Required parameter, i.e. cannot be left 
 *          nil' and the array must have atleast one invitee name.
 
 * @param : channel, the medium through the invitation is sent (eg: facebook, SMS, email), optional, can be set to 'nil'.
 * @param : gameVersion, the game version, optional, can be set to 'nil'.
 * @param : gameLevel, The game level, as an NSInteger.
 
 * @code

 *  Example :
 
    NSArray *invitedFriends = [NSArray arrayWithObjects:@"Bob@game.net",@"Alice@abc.com",nil];
    [[CetasTracker getDefaultTracker] trackGameInvitationWithGameID:@"001_002" inviteeList:invitedFriends channel:@"Facebook"
    gameVersion:@"1.2" gameLevel:3];
 *
 */
-(void)trackGameInvitationWithGameID:(NSString *)gameID
                         inviteeList:(NSArray *)inviteeList
                             channel:(NSString *)channel
                         gameVersion:(NSString *)gameVersion
                           gameLevel:(NSInteger)gameLevel;



/*!
 *
 * @brief : This method enables the developer to track an order of goods along with the goods contained in the order. This method logs the e-commerce transaction and details of the purchased items involved in that transaction.
 *
 * @param : transaction, instance of the CetasTransaction class with all the required parameters set. (please see the
 *          CetasTransaction class for the detailed description of parameters and methods)
 *
 * @code 
 
 *  Example :
    
    CetasTransaction *ecomTrans = [CetasTransaction transactionWithOrderId:@"order123" storeName:@"walmart" totalAmount:200.22 tax:10.25 shipping:20.5 paymentGateway:@"paypal" city:@"Palo Alto" state:@"CA" country:@"United States"];
    [ecomTrans addItemWithSkuNumber:@"SKU123" productName:@"iPad" categoryName:@"Electronics" unitPrice:500.3 quantity:1];
    [[CetasTracker getDefaultTracker] trackTransaction:ecomTrans];
 *
 */
-(void)trackTransaction:(CetasTransaction *)transaction;

/*!
 *
 * @brief : Tracks the pageview passed in the arguement.
 *
 * @param : pageName, the name of the page that needs to be tracked when visited. Required, must not be 'nil'.
 *
 * @note : A pageview is a standard means to measure traffic volume to a traditional website. Because mobile apps don't contain HTML pages, you
 *         must decide when (and how often) to trigger a pageview request.
 * @code :
 
 [[CetasTracker getDefaultTracker] trackPageView:@"Trending"];
 *
 *
 */
-(void)trackPageView:(NSString *) pageName;

/*!
 *
 * @brief : This method tracks user actions.
 *
 * @param : category, the category or group that the action belongs to. Required, must not be 'nil'.
 * @param : actionName, the name of the action performed. Required, must not be 'nil'.
 * @param : actionLabel, the action label. Required, must not be 'nil'.
 * @param : actionValue, the value associated with the action, may be 'nil'.
 *
 * @code :
 
 [[CetasTracker getDefaultTracker] trackActionWithCategory:@"comment" actionName:@"publish" actionLabel:@"number" actionValue:[NSNumber numberWithInteger:10]];
 */

-(void)trackActionWithCategory:(NSString *)category actionName:(NSString *)actionName actionLabel:(NSString *)actionLable actionValue:(NSNumber *)value;
/*!
 *
 * @brief : This method tracks custom events. It is the responsibility of application developer to choose the appropriate event categories.
 *
 *
 * @param : category, required, must not be 'nil'.
 * @param : eventDetail, NSMutableDictionary having event details to log.
 *
 * @code :
 
 NSMutableDictionary *details = [[NSMutableDictionary alloc] init];
 [details setObject:@"Phillips" forKey:@"product_brand"];
 [details setObject:@"amazon" forKey:@"name"];
 [[CetasTracker getDefaultTracker] trackEventWithCategory:@"store" eventDetail:details];
 
 
 */
-(void)trackEventWithCategory:(NSString *)category eventDetail:(NSDictionary *)eventDetails;
@end
