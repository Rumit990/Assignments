//
//  CetasTracker.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import "CetasTracker.h"
#import "CetasApiService.h"

@interface CetasTracker () <CetasAPIServiceDelegate>
- (void)updateEvent:(Event *)event;
- (void)updateEvents:(NSArray *)event;

@property (strong) Config *configObj;
@property (strong) NSString *sessionID;
@property (strong) NSString *apiKey;
@property  NSTimeInterval lastUpdateTime;
@property NSTimeInterval startTime;
@property (strong) NSMutableArray *buffer;
@property (strong) NSMutableDictionary *requestItemsInProcess;

@end
@implementation CetasTracker 

static CetasTracker *defaultTracker = nil;
//default initializer
- (id)initWithApiKey:(NSString *)apiKey  config :(Config *)config
{
    self = [super init];
    
    if (self) {
        // Work your initialising magic here as you normally would
        self.configObj = config;
        self.buffer = [[NSMutableArray alloc] init];
        self.requestItemsInProcess =[[NSMutableDictionary alloc] init];
        self.apiKey = apiKey;
        self.startTime = [[NSDate date] timeIntervalSince1970];
    }
    
    return self;
}

/**
 * Called to get default shared instance of this class. If not already exists, it creates one and returns that
 */
+(id)getDefaultTracker{
    if (defaultTracker == nil) {
        defaultTracker = [[super allocWithZone:NULL] init];
               
    }
    return defaultTracker;
}

- (id)getTrackerWithApiKey:(NSString *)apiKey  config :(Config *)config {
    //TODO ADD all Validations Here
    // Validate config
    // Validate api key
    // User id validation
    defaultTracker= [self initWithApiKey:apiKey config:config];
    if(defaultTracker){
        CetasApiService *service = [[CetasApiService alloc] initWithDelegate:self];
        [service login:apiKey];
        // Add Repeat Timer for time interval.
    }
    return defaultTracker;
}

//- (void)logEvent:(Event *)event; // Later track event
//- (void)logEvents:(NSArray *)events;
//- (void)logEventWithEventDetails:(NSMutableDictionary *)eventDetail;
//- (void)stop;

#pragma Mark CetasApiServiceDelegate methods
-(Config *)getConfigObject{
    return self.configObj;
}

-(NSString *)getSessionKey{
    return self.sessionID;
}
-(NSTimeInterval)getSessionDuration{
    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
    
    return (endTime - self.startTime);
}

/**
 * Called when all the data successfully received from the backend
 */
-(void)dataLoadedSuccess:(CetasApiService *)service response:(NSDictionary *)response{
    
    
}

/**
 * Called when data loading failed from the backend
 */
-(void)dataLoadedFailure:(CetasApiService *)service error:(NSError *)error{
    
}




@end
