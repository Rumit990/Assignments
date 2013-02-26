//
//  Constants.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//


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

#define kMessageRequestTypeLogin 0
#define kMessageRequestTypeMessage 1
#define kMessageRequestTypeLogout 2
#define kMessageRequestTypeRequest 3
#define kMessageRequestTypeResponse 4


@interface Constants : NSObject

@end
