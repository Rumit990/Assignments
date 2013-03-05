//
//  Config.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

//  Methods in this header file are for use with Cetas Analytics.

#import <Foundation/Foundation.h>

/*
 * Enum specifying  possible values of Gender.
 */

typedef enum{
    GenderUnknown,
    GenderMale,
    GenderFemale,
} Gender;


/*!
 * @brief : Provides all the methods for setting user information and configuration parameters.
 *
 *  Provides set of methods that allow developers specify user information and configuration parameters.
 *
 */


@interface Config : NSObject
/*!
 * @brief : Provides a singleton config object.
 *
 * For convenience, this class provides a default config instance.
 * Static method called to get default shared instance of this class with default values for all configuration parameters. If not already exists, it creates one and returns that.
 * This is initialized to `nil` and will be set to the instance that is
 * instantiated in - init call. It may be overridden as desired.
 * 
 */

+(id)getDefaultInstance;


/*! @name : Sets the ID of the current active user.
 *  @brief Method to assign a unique id for the application end-user.
 *
 *  @param userId: The unique id for the the application user.
 */

-(void)setUserId:(NSString *)userId;


/*! 
 *  @name :  Sets the age of the current active user
 *  @brief Method to set user's age in years.
 *
 *
 *  This method can be used to capture the age of the app user. Use this method only if you collect this
 *  information explictly from your user (i.e. - there is no need to set a default value).
 *
 *  @param age : The age of user. 
 *
 */

-(void)setUserAge:(int)age;

/*!
 *  @name Sets the name of the current active user.
 *  @brief Method to set user's name.
 *
 *  This method can be used to capture the name of the application user. Use this method only if you collect this information explictly from your user (i.e. - there is no need to set a default value).
 *  @param name: The name of application user. 
 *
 */

-(void)setUserName:(NSString *)name;


/*!
 *  @name : Sets the gender of the current active user.
 *  @brief: Method to set user's gender.
 *
 * This method can be used to capture the gender of the application user. Use this method only if you collect this information explictly from your user (i.e. - there is no need to set a default value).
 *
 *  @param : gender: The gender of user. It can have three possible values from enum gender i.e (GenderUnknown, GenderMale, GenderFemale).
 *
 */

-(void)setUserGender:(Gender)gender;


/*! @name Location Reporting . Methods for setting location information.
 *  @brief Set user location.
 *
 *  Use information from the CLLocationManager to specify the location of the session. Cetas does not
 *  automatically track this information or include the CLLocation framework.
 
 *  @code
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    [locationManager startUpdatingLocation];
 
    CLLocation *location = locationManager.location;
    //Create Config object and set user location.
    Config *config = [[Config alloc] init];
    [config setLatitude:location.coordinate.latitude
    longitude:location.coordinate.longitude
    horizontalAccuracy:location.horizontalAccuracy
    verticalAccuracy:location.verticalAccuracy];
 
 *  @endcode
 *  @param latitude The latitude.
 *  @param longitude The longitude.
 *  @param horizontalAccuracy The radius of uncertainty for the location in meters.
 *  @param verticalAccuracy The accuracy of the altitude value in meters.
 *
 */
- (void)setUserLatitude:(double)latitude longitude:(double)longitude horizontalAccuracy:(float)horizontalAccuracy verticalAccuracy:(float)verticalAccuracy;


/*!
 *  @brief Method to set remarks, if any.
 *
 *  This method can be used by the developer to put some remark while setting user information.
 *  (i.e. - there is no need to set a default value).
 *  @param remark .
 *
 */
-(void)setRemark:(NSString *)remark;

/*!
 *  @brief Returns the ID of the active user.
 *  This method returns active user ID , as set by the developer while setting user information.
 *
 *  @note If not set it will return nil.
 */

-(NSString *)getUserId;
/*!
 *  @brief : Returns the name of the active user
 *
 *  This method returns active user name, as set by the developer while setting user information.
 *
 *  @note If not set it will return nil.
 */

-(NSString *)getUserName;


/*!
 *  @brief Returns the age of the active user
 *
 *  This method returns active user age, as set by the developer while setting user information.
 *
 *  @note If not set it will return nil.
 */

-(int)getUserAge;

/*!
 *  @brief Returns the gender of the active user.
 *
 *  This method returns active user's gender, as set by the developer while setting user information.
 *
 *  @note If not set it will return nil.It can have three possible values from enum gender i.e (GenderUnknown, GenderMale, GenderFemale). 

 */

-(int)getUserGender;


/*!
 *  @brief Returns the remark.
 *
 *  This method returns the remark as set by the developer while setting user information.
 *
 *  @note If not set it will return nil.

 */

-(NSString *)getUserRemark;

/*!
 *  @brief  Returns the latitude component of location for the active user.
 *
 *  This method returns active user's latitude component of location, as set by the developer while setting user information.
 *
 *
  * @note If not set it will return nil.

 */

-(double)getUserLatitude;
/*!
 *  @brief  Returns the longitude component of location for the active user.
 *
 *  This method returns active user's longitude component of location, as set by the developer while setting user information.
 *
 *
 * @note If not set it will return nil.
 
 */
-(double)getUserLongitude;

/*!
 *  @brief Returns the vertical accuracy in location of the active user.
 *
 *  This method returns vertical accuracy in location of the active user,  as set by the developer while setting user information.
 *
 * @note If not set it will return nil.
 */

-(float)getVerticalAccuracy;
/*!
 *  @brief Returns the horizontal accuracy in location of the active user.
 *
 *  This method returns horizontal accuracy in location of the active user,  as set by the developer while setting user information.
 *
 * @note If not set it will return nil.
 */

-(float)getHorizontalAccuracy;



/*!
 *  @brief Method to set the application user's age, gender and the remark in a single call.
 *
 *  This method can be used to capture app user's age, gender and the remark. Use this method only if you collect this information explictly from your user (i.e. - there is no need to set a default value).
 *
 *  @param age :  Age in years.
          gender : It can have three possible values from enum gender i.e (GenderUnknown, GenderMale,GenderFemale).
          remark :  remark if any.
 *
 */

-(void)setUserAge:(int)age gender:(Gender)gender remark:(NSString *)remark;


/*!
 *  @brief Method to set a time interval between each dispatch  of the generated events to the Cetas service. Until the interval is not reached events are buffered.
 *
 *  @note This method should be used by the application developer to explicitly set the time interval for which the Cetas Analytics would buffer the generated events (till the maximum capacity is reached), before they are dispatched to the Cetas service. Events will be dispatched periodically after every update time interval.
 *
 *  @param updateInterval: Number of seconds for update interval.
 */

-(void)setUpdateInterval:(NSInteger)updateInterval;


@end
