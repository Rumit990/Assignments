//
//  Config.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import <Foundation/Foundation.h>

#define kGenderUnknown 0
#define kGenderMale 1
#define kGenderFemale 2

@interface Config : NSObject

/**
 * Static method called to get default shared instance of this class. If not already exists, it creates one and returns that.
 */
+(id)getDefaultInstance;
/*
 * Sets the ID of the current user
 */
-(void)setUserId:(NSString *)userId;
/*
 * Sets the Age of the current user
 */
-(void)setUserAge:(int)age;
/*
 * Sets the name of the current user
 */
-(void)setUserName:(NSString *)name;
/*
 * Sets the gender of the current user
 */
-(void)setUserGender:(int)gender;
/*
 * Sets the location of the current user
 */
- (void)setUserLatitude:(double)latitude longitude:(double)longitude horizontalAccuracy:(float)horizontalAccuracy verticalAccuracy:(float)verticalAccuracy;
/*
 * Sets the remarks if any
 */
-(void)setRemark:(NSString *)remark;
/*
 * Returns the ID of the active user
 */
-(NSString *)getUserId;
/*
 * Returns the name of active user
 */
-(NSString *)getUserName;
/*
 * Returns the age of the active user
 */
-(int)getUserAge;
/*
 * Returns the gender of the active user
 */
-(int)getUserGender;
/*
 * Returns the remark set by user 
 */
-(NSString *)getUserRemark;
/*
 * Returns the user current latitude.
 */

-(double)getUserLatitude;
/*
 * Returns the user current longitude
 */
-(double)getUserLongitude;
/*
 * Returns the user vertical accuracy. 
 */
-(float)getVerticalAccuracy;
/*
 * Returns the user horizontal accuracy.
 */
-(float)getHorizontalAccuracy;
-(void)setUserAge:(int)age gender:(int)gender remark:(NSString *)remark;

-(void)setUpdateInterval:(NSInteger)updateInterval;




+(void)test;
@end
