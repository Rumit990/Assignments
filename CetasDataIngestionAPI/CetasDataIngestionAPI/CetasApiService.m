//
//  CetasApiService.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import "CetasApiService.h"
#import "Request.h"
#import "JSON.h"

#define kMessageTypeLogin 0
#define kMessageTypeUpdate 1
#define kMessageTypeLogout 2

@interface CetasApiService()

@property (strong) Request *requestData;


@end

@implementation CetasApiService

-(id) initWithDelegate:(id<CetasAPIServiceDelegate>)parameterDelegate
{
    self = [super init];
    if(self){
        //set delegate
        self.delegate = parameterDelegate;
        
    }
    return self;
}

-(void) sendPostRequestWithPostParamsString:(NSString *)paramsString{
    
    // set urlOrParamString by request param string (request param string should not contain cookie param)
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCetasRestAPIBaseURL,[self getAPIPath]]]];
    [request setHTTPMethod:@"POST"];
    
    [request setHTTPBody:[paramsString dataUsingEncoding:NSUTF8StringEncoding]];
    //[request setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //if connection couldn't be created
    if(self.connection == nil)
    {
        //NSLog(@"CetasAPIService:sendRequest Couldn't create connection");
        logIfRequired(@"CetasAPIService:sendRequest Couldn't create connection");
        //TODO:rare case but we should propagate this error to main controller
    }
    NSLog(@"API URL:%@%@ POST:%@", kCetasRestAPIBaseURL,[self getAPIPath], paramsString);
    
}

-(NSString *)getAPIPath{
    switch (self.messageType) {
        case kMessageTypeLogin:
            return @"login/";
            break;
        case kMessageTypeUpdate :
            return @"update";
            break;
        case kMessageTypeLogout:
            return @"logout";
            break;
    }
    return @"";
    
}


#pragma mark connection
/**
 * Called by IOS when connection received response header's information and response is OK = 200 or something else went wrong
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
	NSInteger statusCode = [httpResponse statusCode];
    if(statusCode == 200) {
		self.apiResponse = [NSMutableData data];
        
	} else {
		NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Http Error", @"Something went wrong.") forKey:NSLocalizedDescriptionKey];
		NSError *error = [[NSError alloc] initWithDomain:@"http" code:statusCode userInfo:userInfo];
		if ([self.delegate respondsToSelector:@selector(dataLoadedFailure:error:)]){
            [self.delegate dataLoadedFailure:self error:error];
        }
	}
}


/**
 * Called by IOS multiple times when there are some data received in the response, we just need to append that data in the api response
 */

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[self.apiResponse appendData:data];
}

/**
 * Called by IOS when complete data has been received from the server and once we have received complete data, we should let delegate's know that data loaded successfully
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *apiResponseStr = [[NSString alloc] initWithData:self.apiResponse encoding:NSUTF8StringEncoding];
    NSLog(@"apiResponseStr1 :%@",apiResponseStr);
    NSDictionary *apiResponseData= [apiResponseStr JSONValue];
    if (apiResponseData) {
        NSString *status = [apiResponseData objectForKey:kCetasAPIResponseKeyStatus];
        if ([status isEqualToString:kResponseStatusCode200]) {
            if ([self.delegate respondsToSelector:@selector(dataLoadedSuccess:response:)]){
                [self.delegate dataLoadedSuccess:self response:apiResponseData];
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(dataLoadedFailure:error:)]){
                [self.delegate dataLoadedFailure:self error:nil];
            }
        }
    }

    
}

/**
 * Called by IOS if connection failed in between
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(dataLoadedFailure:error:)]){
        [self.delegate dataLoadedFailure:self error:error];
    }

}

@end
