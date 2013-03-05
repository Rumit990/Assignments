//
//  ConfigUtil.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import <Foundation/Foundation.h>

/*
 * Private interface for Config class. This is visible only inside the project.
 */
@interface Config (){
    
}

/* Dictionary to Store User Information.
 * Following Information can be saved:
 kUserInfoKeyUserID = @"ID";
 kUserInfoKeyUserName = @"Name";
 kUserInfoKeyUserAge = @"Age";
 kUserInfoKeyUserGender = @"Gender";
 kUserInfoKeyUserLongitude = @"Longitude";
 kUserInfoKeyUserLatitude = @"Latitude";
 kUserInfoKeyUserHorizontalAccuracy = @"HorizontalAccuracy";
 kUserInfoKeyUserVerticalAccuracy = @"VerticalAccuracy";
 kUserInfoKeyUserRemark = @"Remark";
 */
@property (strong) NSMutableDictionary *userInfo;
/*
 * Buffer capacity .Capacity upto which events can be buffered before being dispatch to Cetas service.
 */
@property NSInteger capacity;
/*
 * Update inteval between in dispatch of buffered to Cetas Service.
 */
@property NSInteger interval;
/*
 * Session time out interval with the cetas service.
 */
@property NSInteger timeout;
/*
 * Flag to show error in logs.
 */
@property BOOL showErrorInLogs;


@end
