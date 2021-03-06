//
//  Constants.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//
/**
 * This class has all the constants used throughout the project
 */


#import <Foundation/Foundation.h>

extern NSString * const kUserInfoKeyUserID ;
extern NSString * const kUserInfoKeyUserName ;
extern NSString * const kUserInfoKeyUserAge ;
extern NSString * const kUserInfoKeyUserGender ;
extern NSString * const kUserInfoKeyUserLongitude;
extern NSString * const kUserInfoKeyUserLatitude;
extern NSString * const kUserInfoKeyUserHorizontalAccuracy;
extern NSString * const kUserInfoKeyUserVerticalAccuracy ;
extern NSString * const kUserInfoKeyUserRemark;
extern NSString * const kCetasRestAPIBaseURL;
extern NSString * const kResponseStatusCode200;
extern NSString * const kCetasAPIResponseKeyStatus;
extern NSString * const kCetasAPIResponseKeyToken;
extern NSString * const kCetasAPIResponseKeyTimeout;
extern NSString * const kCetasAPIResponseKeyAttributes;
extern NSString * const kCetasAPIResponseKeyUserID;
extern NSString * const kCetasAPIResponseKeyContent;
extern NSString * const kCetasAPIResponseKeyUser;
extern NSInteger const kMinUpdateTimeInterval;
extern NSInteger const kMaxUpdateTimeInterval;
extern NSInteger const kValidationLimitTimeoutIntervalMin; // check on this
extern NSInteger const kValidationLimitTimeoutIntervalMax;
extern NSInteger const kValidationLimitRemarkLengthMax;

#define kMessageRequestTypeLogin 0
#define kMessageRequestTypeMessage 1
#define kMessageRequestTypeLogout 2
#define kMessageRequestTypeRequest 3
#define kMessageRequestTypeResponse 4

#define logIfRequired(string) NSLog(string)

@interface Constants : NSObject

@end
