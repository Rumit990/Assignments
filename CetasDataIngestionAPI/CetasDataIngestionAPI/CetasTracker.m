//
//  CetasTracker.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import "CetasTracker.h"
#import "CetasApiService.h"
#import "ConfigUtil.h"


/*
 * Private interface for Cetas Tracker.
 * This class implements CetasAPIServiceDelegate protocol methods.
 */
@interface CetasTracker () <CetasAPIServiceDelegate>{
    //instance variable.
    BOOL performLogout;
}
/*!
 *
 *  @brief : Check wheather time to update events to Cetas Service is arrived.
 *
 *  This method calculates the time elapsed since the last update events call and compares it with the config's update time interval. It returns the result of this comparison as a
 *   1. YES : If the time elapsed surpasses the set update time interval.
 *   2. NO:  If the time elapsed is less than the set update time interval.
 */

-(BOOL)isUpdateTime;


/*
 * Holds reference to the config object.
 */
@property (strong) Config *configObj;

/*
 * Holds reference to the session ID, returned by the backend in login request.
 *
 */
@property (strong) NSString *sessionID;
/*
 * Holds reference to the apiKey, used for establishing user session.
 *
 */
@property (strong) NSString *apiKey;
/*
 * Holds the value of time when the last event update was sent to the backend.
 */
@property  NSTimeInterval lastUpdateTime;
/*
 * Holds the value of time when the session started.
 */
@property NSTimeInterval startTime;
/*
 * Holds reference to the array that buffers events until the next update events call.
 *
 */
@property (strong) NSMutableArray *buffer;
/*
 * Holds all request events data until event are updated successfully to the backend.
 * Format : 
   [request-tag1] = > [events1 array],
   [request-tag2] = > [events2 array],
 */
@property (strong) NSMutableDictionary *requestItemsInProcess;
/*
 * Counter for tag of service request.
 */
@property int serviceObjTag;
/*
 * Timer to fire after every update interval.
 */
@property  NSTimer *updateTimer;

@end


/*!
 * @brief : Provides all the methods for defining and logging Analytics from use of your app.
 *
 *  Provides implementation of all the methods that allow developers to log detailed and aggregate information regarding the use of their app by end users.
 *
 */

@implementation CetasTracker
// Static variable holds singleton object of CetasTracker class.
static CetasTracker *defaultTracker = nil;


/*!
 * @brief : Custom initializer . Initialize the tracker object.
 *
 *  This method serves as starting point for tracking information.  It must be
 *  called in the scope of @c applicationDidFinishLaunching. This will create a session with the cetas service for timeout inteval as set in config object.
 *  Prior to calling this, Config Object must created with all user information and configuration flag set(example update inteval and timeout).
 * @param : apikey : The API key for this project.
 *          config : Configuration object having all user information and configuraion flags set.
 */

- (id)initWithApiKey:(NSString *)apiKey  config :(Config *)config
{    
    // Validate api key
    if (![CetasTracker validateCredential:apiKey minimumLength:10]){
        NSLog(@"Cetas Tracker : Api Key must be of six characters.");
        return nil;
    }
    // User id validation
    if (![CetasTracker validateCredential:[config getUserId] minimumLength:6]){
        NSLog(@"Cetas Tracker : Invalid User ID : User ID must be minimum of 6 characters.");
        return nil;
    }
    // Validate config
    if (!config){
        //Invalid Config Object
        NSLog(@"Cetas Tracker : Invalid Config Object");
        return nil;
    }
    
    self = [super init];
    
    if (self) {
        // Work your initialising magic here as you normally would
        self.configObj = config;
        self.buffer = [[NSMutableArray alloc] init];
        self.requestItemsInProcess =[[NSMutableDictionary alloc] init];
        self.apiKey = apiKey;
        self.startTime = [[NSDate date] timeIntervalSince1970];
        CetasApiService *service = [[CetasApiService alloc] initWithDelegate:self];
        [service login:apiKey];
        self.serviceObjTag = 1;
        defaultTracker = self;
        self.lastUpdateTime = [[NSDate date] timeIntervalSince1970];
        // Add Repeat Timer for time interval.
        self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:self.configObj.interval target:self selector:@selector(fireUpdateTimer) userInfo:nil repeats:YES];
        performLogout = NO;
        
    }
    
    return self;
}

/*!
 *  @brief : Method to validate token sent as a parameter.
 *
 *  This method checks the validity of a string parameter on two grounds :
 *  1. Checks if the string reference points to nil or is an empty string. Returns 'nil' if any of the cases holds true.
 *  2. Compares the string length with the minimum permissible length for string parameter. Returns 'nil' if the condition is voilated.
 *  If the string passes both the tests, the string's reference is returned, else 'nil' is returned.
 *
 *
 *  @param : token:  The string to be validated.
             minLength: the minimum permissible length for the string token.
 *
 */


+(NSString *)validateCredential:(NSString *)token minimumLength:(int)minLength
{
    if (!token || ([token isEqualToString:@""]))
    {
        return nil;
    }
    token = [token stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (token.length < minLength)
    {
        return nil;
    }
    
    return token;
}

/*!
 *  @brief : Method, periodically initiates an update request to send the events buffered in the last update interval to the Cetas Service if update interval arrives.
 */

-(void)fireUpdateTimer{
    if([self isUpdateTime]){
        self.lastUpdateTime = [[NSDate date] timeIntervalSince1970];
        [self updateEvents:nil];
    }
    
}

/*!
 *  @brief : Check wheather time to update events to Cetas Service is arrived.
 *
 *  This method calculates the time elapsed since the last update events call and compares it with the config's update time interval. It returns the result of this comparison as a
 *   1. YES : If the time elapsed surpasses the set update time interval.
 *   2. NO:  If the time elapsed is less than the set update time interval.
 */


-(BOOL)isUpdateTime{
    NSTimeInterval timeElapsed = [[NSDate date] timeIntervalSince1970] - self.lastUpdateTime;
    if( timeElapsed >= self.configObj.interval){
        return YES;
    }
    return NO;
}

/*!
 * @brief : Provides a singleton tracker object.
 *
 * For convenience, this class provides a default CetasTracker instance.
 * This is initialized to `nil` and will be set to the tracker that is
 * instantiated in - (id)initWithApiKey:(NSString *)apiKey  config :(Config *)config.
 * It may be overridden as desired.
 *
 */

+(id)getDefaultTracker{
    
    return defaultTracker;
}


/*!
 * @name : Send an event information to service forcefully.
 * @brief : This method updates the custom event to cetas service surpassing the criteria of capacity/update inteval.As soon as it is called, events are updated on Cetas Server.In case internet is not connected events are stored on to buffer.
 *
 * @note Private or confidential information about your users should not be passed while logging events.
 
 * @param
 * Event : Event Object with all its parameters set like details(event detail),date and time(optional).
 */

- (void)updateEvent:(Event *)event{
    if(!event){
        return;
    }
    [self updateEvents:[NSArray arrayWithObject:event]];
}


/*!
 * @name : Logs Single event.
 * @brief : Records a event specified by event object.
 *  This method allows you to specify custom events within your app. Usually  developer should log events related to navigation or page view, any user action, and other events as they are applicable to tracking progress towards your business goals.
 *  * The Events are stored on to buffer until capacity and time interval as set in config object are not exceeded. Events are stored on to buffer until capacity and time interval as set in config object are not exceeded.
 *
 * @note Private or confidential information about your users should not be passed while logging events.
 
 * @param
 * Event : Event Object with all its parameters set like details(event detail),date and time(optional).
 */

-(void)logEvent:(Event *)event{
    if (!event) {
        NSLog(@"CetasTracker::logEvent:  Empty event is passed.");
        return;
    }
    if(self.buffer.count  >= self.configObj.capacity-1){
        [self updateEvent:event];
    }else{
        
        [self.buffer addObject:event];
        
    }
    // [self logEvents:[NSArray arrayWithObject:event]];
}


/*!
 * @name : Logs multiple events.
 * @brief : Records multiple events together.
 *
 *  This method allows you to specify custom events within your app. Usually developers should log events related to navigation or page view, any user action, and other events as they are applicable to tracking progress towards their business goals.
 * The Events are stored on to buffer until capacity and time interval as set in config object are not exceeded.
 *
 * @note Private or confidential information about your users should not be passed while logging events.
 
 * @param
 * Events :Array of Event class Objects with all its param set.
 */


-(void)logEvents:(NSArray *)events{
    
    if(!events && !events.count){
        NSLog(@"CetasTracker::logEvent:  Empty event is passed.");
        return;
    }
    
    int allowed  = MIN(events.count, self.configObj.capacity);
    if((self.configObj.capacity - self.buffer.count) < allowed){
        //Not enough space left. Make backend call to update event and clean buffer.
        [self updateEvents:nil];
    }
    
    if(events.count < self.configObj.capacity){
        // if the number of received events is less than the total capacity, the events are added to the buffer.
        [self.buffer addObjectsFromArray:events];
    }else{
        // if the number of events exceeds the capacity, the update event call is made upto a maximum of three folds to cover all the events in the events array.
        int counter = 0;
        int index = 0;
        do{
            for(int i=0 ; i < allowed ;i++){
                index = counter*allowed + i;
                if(! (index < events.count)){
                    break;
                }
                [self.buffer addObject:[events objectAtIndex:index]];
            }
            counter++;
            if(events.count > counter*allowed){
                [self updateEvents:nil];
            }
            
        }while(counter < 2 );
    }
}

/*!
 * @name : Send an multiple event information to service forcefully.
 * @brief : This method updates the custom events to cetas service surpassing the criteria of capacity/update inteval. As Soon as it is called,  events are updated on Cetas Server.In case internet is not connected events are stored on to buffer.
 *
 *  This method allows you to specify custom events within your app. Usually developers should log events related to navigation or page view, any user action, and other events as they are applicable to tracking progress towards their business goals.
 *
 * @note Private or confidential information about your users should not be passed while logging events.
 
 * @param
 * Events :Array of Event class Objects with all its param set.
 */



- (void)updateEvents:(NSArray *)events{
    
    CetasApiService *service = [[CetasApiService alloc] initWithDelegate:self];
    if (!self.sessionID && events) {
        [self.buffer addObjectsFromArray:events];
        return;
    }
    NSMutableArray *allEvents = [NSMutableArray array];
    if(self.buffer.count){
        [allEvents addObjectsFromArray:self.buffer];
    }
    if(events.count){
        [allEvents addObjectsFromArray:events];
    }
    
    if(allEvents.count){
        self.serviceObjTag++;
        service.tag =self.serviceObjTag;
        [service updateEvents:allEvents];
        self.buffer = [NSMutableArray array];
        [self.requestItemsInProcess setObject:allEvents forKey:[NSString stringWithFormat:@"%d",self.serviceObjTag]];
    }
}

/*!
 * @name : Logs event with details.
 * @brief : This method allows you record event in a single call. Developer don't need to create a event object in this call.
 * The Events are stored on to buffer until capacity and time interval as set in config object are not exceeded.
 * @note Private or confidential information about your users should not be passed while logging events.
 * @param
 * eventDetail : NSMutableDictionary having event details to log.
 */

- (void)logEventWithEventDetails:(NSMutableDictionary *)eventDetail{
    Event *event = [[Event alloc] init];
    [event setEventDetail:eventDetail];
    [self logEvent:event];
}


/*!
 * @brief : This method allows you to stop tracking for events. This will stop any furthur tracking of event within app. This method closes the session with cetas analytics service. Once this method has been called, it is an error to call any of the tracking methods, and they will not result in the generation of any tracking information to be submitted to Cetas Analytics.
 */

- (void)stopTracker{
    if ([self.updateTimer isValid]) {
        [self.updateTimer invalidate];
        self.updateTimer = nil;
    }
    if(!self.sessionID){
        //It means already logged out.
        return;
    }
    
    if (self.buffer.count) {
        performLogout = true;
        [self updateEvents:nil];
        
    }else{
        CetasApiService *service =[[CetasApiService alloc] initWithDelegate:self];
        [service logout];
    }
    
}


//- (void)stop;

#pragma Mark CetasApiServiceDelegate delegate methods

/*!
 *  @brief :This method returns reference to the config object held by the tracker.
 *
 */

-(Config *)getConfigObject{
    return self.configObj;
}


/*!
 *  @brief :  This method returns reference to the session key string held by the tracker.
 *
 */


-(NSString *)getSessionKey{
    return self.sessionID;
}

/*
 * @brief :  This methods returns session duration from tracker.Used during logout request.
 */


-(NSTimeInterval)getSessionDuration{
    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
    
    return (endTime - self.startTime);
}

/*!
 * @brief : Method called when all the data is successfully received from the backend.
 *
 * This method is publised by the Cetas Api Service when the data is successfully received, with a reference to itself and the response dictionary received.
 *
 * @param : service : Reference to the service object
            response : The dictionary received as a response.
 *
 */
-(void)dataLoadedSuccess:(CetasApiService *)service response:(NSDictionary *)response{
    self.lastUpdateTime = [[NSDate date] timeIntervalSince1970];
    if(service.tag){
        [self.requestItemsInProcess removeObjectForKey:[NSString stringWithFormat:@"%d",service.tag]];
    }
    
    switch (service.messageType) {
        case kMessageRequestTypeLogin:{
            self.sessionID = [response objectForKey:kCetasAPIResponseKeyToken];
        }
            break;
        case kMessageRequestTypeLogout:{
            self.sessionID = nil;
        }
            break;
        case kMessageRequestTypeMessage:{
            if(performLogout){
                //During logout first update event call is made and then logout call is done here.
                CetasApiService *service =[[CetasApiService alloc] initWithDelegate:self];
                [service logout];
                performLogout = NO;
            }
        }
            break;
    }
}


/*!
 * @brief : Method called when the data loading from the backend fails.
 *
 * This method is publised by the Cetas Api Service when the data is successfully received with a reference to itself and the error.
 *
 * @param : service : Reference to the service instance
 *          error : Reference to the error instance.
 *
 */

-(void)dataLoadedFailure:(CetasApiService *)service error:(NSError *)error{
    self.lastUpdateTime = [[NSDate date] timeIntervalSince1970];
    NSString *key = [NSString stringWithFormat:@"%d",service.tag];
    NSArray *pendingEvents = [self.requestItemsInProcess objectForKey:key];
    if(pendingEvents){
        [self.buffer arrayByAddingObject:pendingEvents];
    }
    [self.requestItemsInProcess removeObjectForKey:key];
}




@end
