//
//  Config.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import <Foundation/Foundation.h>


@interface Config : NSObject

/**
 * Called to get default shared instance of this class. If not already exists, it creates one and returns that
 */
+(id)getDefaultInstance;
-(void)setUserId:(NSString *)userId;
-(void)setUserAge:(int)age;
-(void)setUserName:(NSString *)name;
-(void)setUserGender:(int)gender;
- (void)setUserLatitude:(double)latitude longitude:(double)longitude horizontalAccuracy:(float)horizontalAccuracy verticalAccuracy:(float)verticalAccuracy;
-(void)setRemark:(NSString *)remark;
-(NSString *)getUserId;
-(int)getUserAge;
-(int)getUserGender;
-(NSString *)getUserRemark;
-(double)getUserLatitude;
-(double)getUserLongitude;
-(float)getVerticalAccuracy;
-(float)getHorizontalAccuracy;
-(NSString *)getUserName;


+(void)test;
@end
