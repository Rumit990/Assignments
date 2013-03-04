//
//  Constants.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import "Constants.h"

@implementation Constants

NSString * const kUserInfoKeyUserID = @"ID";
NSString * const kUserInfoKeyUserName = @"Name";
NSString * const kUserInfoKeyUserAge = @"Age";
NSString * const kUserInfoKeyUserGender = @"Gender";
NSString * const kUserInfoKeyUserLongitude = @"Longitude";
NSString * const kUserInfoKeyUserLatitude = @"Latitude";
NSString * const kUserInfoKeyUserHorizontalAccuracy = @"HorizontalAccuracy";
NSString * const kUserInfoKeyUserVerticalAccuracy = @"VerticalAccuracy";
NSString * const kUserInfoKeyUserRemark = @"Remark";
NSString * const kCetasRestAPIBaseURL = @"http://webfeeds.cetas.net:8080/rest/agent/";
NSString * const kResponseStatusCode200= @"200 OK";
NSString * const kCetasAPIResponseKeyStatus = @"status";
NSString * const kCetasAPIResponseKeyToken = @"token";
NSString * const kCetasAPIResponseKeyTimeout = @"timeout";
NSString * const kCetasAPIResponseKeyAttributes = @"attributes";
NSString * const kCetasAPIResponseKeyUserID = @"userID";
NSString * const kCetasAPIResponseKeyContent = @"content";
NSString * const kCetasAPIResponseKeyUser = @"user";
NSInteger const kMinUpdateTimeInterval = 1;
NSInteger const kMaxUpdateTimeInterval = 1800;
NSInteger const kValidationLimitTimeoutIntervalMin = 60;
NSInteger const kValidationLimitTimeoutIntervalMax = 36000;
NSInteger const kValidationLimitRemarkLengthMax = 99;

@end
