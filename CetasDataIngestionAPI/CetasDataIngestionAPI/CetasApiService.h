//
//  CetasApiService.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import <Foundation/Foundation.h>
#import "Config.h"
#import "Constants.h"

@class CetasApiService;

@protocol CetasAPIServiceDelegate<NSObject>

-(Config *)getConfigObject;
-(NSString *)getSessionKey;
-(NSTimeInterval)getSessionDuration;

/**
 * Called when all the data successfully received from the backend
 */
-(void)dataLoadedSuccess:(CetasApiService *)service response:(NSDictionary *)response;

/**
 * Called when data loading failed from the backend
 */
-(void)dataLoadedFailure:(CetasApiService *)service error:(NSError *)error;

@end


@interface CetasApiService : NSObject

@property (unsafe_unretained) id<CetasAPIServiceDelegate> delegate;
@property (strong) NSMutableData *apiResponse;
@property (strong) NSString *action;
@property (strong) NSURLConnection *connection;
@property NSInteger tag;
@property NSInteger messageType;


/**
 * Initializes CetasAPIService with the delegate
 */
-(id) initWithDelegate: (id <CetasAPIServiceDelegate>) parameterDelegate;
-(void)login:(NSString *)apiKey;
-(void)logout;
-(void)updateEvents:(NSArray *)events;
@end

