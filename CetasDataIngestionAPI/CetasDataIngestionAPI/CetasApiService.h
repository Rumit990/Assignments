//
//  CetasApiService.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import <Foundation/Foundation.h>
#import "Config.h"
#import "Constants.h"

@class CetasApiService;
/**
 -----------------------------------------------------------------
 CetasAPIServiceDelegate
 -----------------------------------------------------------------
 This protocol publishes methods related to data loaded success and failure and getting configuration/session information from tracker.
 Cetas Tracker implements this protocol.
 */
@protocol CetasAPIServiceDelegate<NSObject>

/*
 * Called to get config object of tracker.
 */
-(Config *)getConfigObject;
/*
 * Called to get session key from tracker. Session key get set when user login first time.
 */
-(NSString *)getSessionKey;
/*
 * Called to get session duration from tracker.Used during logout request.
 */
-(NSTimeInterval)getSessionDuration;

/**
 * Called when all the data successfully received from the backend
 */
-(void)dataLoadedSuccess:(CetasApiService *)service response:(NSDictionary *)response;

/**
 * Called when data loading failed from the backend.
 */
-(void)dataLoadedFailure:(CetasApiService *)service error:(NSError *)error;

@end

/**
 * Service layer for making rest calls to Cetas server
 * This class has public methods login, logout and update events data to backend.
 * This class makes asynchronous request to server (means it doesn't not block the main thread of the app)
 * After making connection control waits for connection delegates methods, which are called when server starts returning response to app
 * These methods are called by IOS in below given order:
 * - (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
 * - (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
 * - (void)connectionDidFinishLoading:(NSURLConnection *)connection
 
 * OR if failed to connect then
 * - (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
 */
@interface CetasApiService : NSObject

//API service delegate
@property (unsafe_unretained) id<CetasAPIServiceDelegate> delegate;
//response data
@property (strong) NSMutableData *apiResponse;
//Connection Object to the server.
@property (strong) NSURLConnection *connection;
//Tag distinguishes each request from each other.
@property NSInteger tag;
// Type of request sent to cetas server.
//Possible values
// LOGIN (0)
// MESSAGE (1)
// LOGOUT (2)
// REQUEST (3)
// RESPONSE (4)
@property NSInteger messageType;

/**
 * Initializes CetasAPIService with the delegate
 */
-(id) initWithDelegate: (id <CetasAPIServiceDelegate>) parameterDelegate;
/*
 * Makes login rest call to Cetas Service.
 * Called by tacker object during initilization to start tracking.
 */
-(void)login:(NSString *)apiKey;
/*
 * Makes logout rest call to Cetas Service.
 * Called by tacker to make logout call. In genral called when application stops.
 */
-(void)logout;
/*
 * Updates event information to Cetas Service.
 * Called by tacker object during initilization to start tracking.
 */
-(void)updateEvents:(NSArray *)events;
@end

