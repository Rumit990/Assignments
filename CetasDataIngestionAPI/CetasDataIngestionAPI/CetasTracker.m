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
#import "ConfigUtil.h"

@interface CetasTracker () <CetasAPIServiceDelegate>
- (void)updateEvent:(Event *)event;
- (void)updateEvents:(NSArray *)events;

@property (strong) Config *configObj;
@property (strong) NSString *sessionID;
@property (strong) NSString *apiKey;
@property  NSTimeInterval lastUpdateTime;
@property NSTimeInterval startTime;
@property (strong) NSMutableArray *buffer;
@property (strong) NSMutableDictionary *requestItemsInProcess;
@property int serviceObjTag;

@end
@implementation CetasTracker 

static CetasTracker *defaultTracker = nil;
//default initializer
- (id)initWithApiKey:(NSString *)apiKey  config :(Config *)config
{
    //TODO ADD all Validations Here
    // Validate config
    // Validate api key
    // User id validation
    
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
        // Add Repeat Timer for time interval.
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

- (void)updateEvent:(Event *)event{
    if(!event){
        return;
    }
    [self updateEvents:[NSArray arrayWithObject:event]];
}

-(void)logEvent:(Event *)event{
    if (!event) {
        NSLog(@"CetasTracker::logEvent:  Empty event is passed.");
        return;
    }
    if(self.buffer.count  > self.configObj.capacity){
        [self updateEvent:event];
    }else{
     
        [self.buffer addObject:event];
        
    }
}

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
        [self.buffer addObjectsFromArray:events];
    }else{
        
        int counter = 0;
        int index = 0;
        do{
            for(int i=0 ; i < allowed ;i++){
                index = counter*allowed + i;
                [self.buffer addObject:[events objectAtIndex:index]];
            }
            if(events.count > counter*allowed ){
               [self updateEvents:nil];
                break;
            }
            counter++;
        }while(counter < 2 );
    }
}
- (void)updateEvents:(NSArray *)events{
    
    CetasApiService *service = [[CetasApiService alloc] initWithDelegate:self];
    NSMutableArray *allEvents = nil;
    if(self.buffer.count){
        [allEvents addObjectsFromArray:self.buffer];
    }
    if(events.count){
        [allEvents addObjectsFromArray:events];
    }
    
    if(allEvents.count){
       self.serviceObjTag++;
       service.tag =self.serviceObjTag;
       [service updateEvents:events];
       self.buffer = [NSMutableArray array];
       [self.requestItemsInProcess setObject:allEvents forKey:[NSString stringWithFormat:@"%d",self.serviceObjTag]];
    }
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
    //this.lastUpdateTime = System.currentTimeMillis();
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
            
        }
        break;
    }
}

/**
 * Called when data loading failed from the backend
 */
-(void)dataLoadedFailure:(CetasApiService *)service error:(NSError *)error{
    NSString *key = [NSString stringWithFormat:@"%d",service.tag];
    NSArray *pendingEvents = [self.requestItemsInProcess objectForKey:key];
    if(pendingEvents){
        [self.buffer arrayByAddingObject:pendingEvents];
    }
    [self.requestItemsInProcess removeObjectForKey:key];
}




@end
