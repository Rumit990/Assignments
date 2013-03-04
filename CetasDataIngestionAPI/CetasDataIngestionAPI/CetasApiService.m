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
#import "Event.h"
#import "ConfigUtil.h"
#import "EventUtil.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "JsonParser.h"

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

-(NSDictionary *)getSystemInfo{
    
    NSMutableDictionary *systemInfo = [[NSMutableDictionary alloc] init];
    UIDevice *currentDevice = [UIDevice currentDevice];
    NSArray *languageArray = [NSLocale preferredLanguages];
    NSString *language = @"null";
    if(languageArray.count){
        language = [languageArray objectAtIndex:0];
    }
    
    NSLocale *locale = [NSLocale currentLocale];
    NSString *country = [locale localeIdentifier];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    
    [systemInfo setValue:[currentDevice name] forKey:@"Name"];
    [systemInfo setValue:[currentDevice systemName] forKey:@"SystemName"];
    [systemInfo setValue:[currentDevice systemVersion] forKey:@"OSVersion"];
    [systemInfo setValue:[currentDevice model] forKey:@"DeviceModel"];
    [systemInfo setValue:language forKey:@"Language"];
    [systemInfo setValue:country forKey:@"Country"];
    [systemInfo setValue:appVersion forKey:@"AppVersion"];
    
    CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *ctCarrier = [netinfo subscriberCellularProvider];
    [systemInfo setValue:ctCarrier.carrierName forKey:@"CarrierName"];
    [systemInfo setValue:ctCarrier.mobileCountryCode forKey:@"MobileCountryCode"];
    [systemInfo setValue:ctCarrier.mobileNetworkCode forKey:@"MobileNetworkCode"];
    [systemInfo setValue:ctCarrier.isoCountryCode forKey:@"IsoCountryCode"];
    
    return systemInfo;
}


-(Request *)prepareRequest:(NSArray *)events apiKey:(NSString *)apiKey{
    
    Config *config = [self.delegate getConfigObject];
    Request *request = [[Request alloc] init];
    request.timeout = config.timeout;
    request.attributes =  [self getSystemInfo];
    request.user = config.userInfo;
    
    switch (self.messageType) {
        case kMessageRequestTypeLogin:{
            request.token = apiKey;
            Event *event = [[Event alloc] initWithType:kMessageRequestTypeLogin];
            [event setEventAtribute:kCetasAPIResponseKeyUserID  forKey:[config getUserId]];
            [event setEventAtribute:kUserInfoKeyUserName forKey:[config getUserName]];
            request.content = [NSArray arrayWithObject:event];
        }
            break;
        case kMessageRequestTypeMessage:{
            request.token = [self.delegate getSessionKey];
            request.content = events;
        }
            break;
        case kMessageRequestTypeLogout:{
            request.token = [self.delegate getSessionKey];
            Event *event = [[Event alloc] initWithType:kMessageRequestTypeLogin];
            [event setEventAtribute:[config getUserId]  forKey:kCetasAPIResponseKeyUserID];
            [event setEventAtribute:[config getUserName] forKey:kUserInfoKeyUserName];
            
            request.content = [NSArray arrayWithObject:event];
            request.user = nil;
            request.attributes = [NSDictionary dictionaryWithObject:[NSNumber numberWithDouble:[self.delegate getSessionDuration]] forKey:@"duration"];
        }
            break;
            
    }
    return request;
}


-(void)login:(NSString *)apiKey {
    
    self.messageType= kMessageRequestTypeLogin;
    Request *request = [self prepareRequest:nil apiKey:apiKey];
    NSString *requestJSON = [request getJSONRepresentation];
    [self sendPostRequestWithPostParamsString:requestJSON];
    
}

-(void)logout {
    self.messageType = kMessageRequestTypeLogout;
    Request *request = [self prepareRequest:nil apiKey:nil];
    NSString *requestJSON = [request getJSONRepresentation];
    [self sendPostRequestWithPostParamsString:requestJSON];
}

-(void) updateEvents:(NSArray *)events{
    self.messageType = kMessageRequestTypeMessage;
    Request *request = [self prepareRequest:events apiKey:nil];
    NSString *requestJSON = [request getJSONRepresentation];
    [self sendPostRequestWithPostParamsString:requestJSON];
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
    NSLog(@"apiResponseStr :%@",apiResponseStr);
    NSDictionary *apiResponseData=  [JsonParser JSONValue:apiResponseStr];
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
