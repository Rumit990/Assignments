//
//  Config.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import <Foundation/Foundation.h>

/*
 *
 */

typedef enum{
    GenderUnknown,
    GenderMale,
    GenderFemale,
} Gender;

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
/*
 * Sets the ID of the current user
 */

/*!
 *  @brief Method to assign a unique id for the application end-user.
 *
 *
 *  @note Please be sure not to use this method to pass any private or confidential information
 *  about the user.
 *
 *  @param userId, The unique id for the the application user.
 */

-(void)setUserId:(NSString *)userId;
/*
 * Sets the Age of the current user
 */


/*!
 *  @brief Method to set user's age in years.
 *
 *
 *  This method can be impelemted to capture the age of teh applcation user. Use this method only if you collect this
 *  information explictly from your user (i.e. - there is no need to set a default value).
 *
 *  @note The age is aggregated across all users of your app and not available on a per user
 *  basis.
 *
 *  @param age, The age of user. (provided by the developer)
 *
 */

-(void)setUserAge:(int)age;
/*
 * Sets the name of the current user
 */

/*!
 *  @brief Method to set user's name.
 *
 *
 *  This method can be impelemted to capture the name of the applcation user. Use this method only if you collect this
 *  information explictly from your user (i.e. - there is no need to set a default value).
 *
 *
 *  @param name, The name of applcation user. (provided by the developer)
 *
 */

-(void)setUserName:(NSString *)name;
/*
 * Sets the gender of the current user
 */


/*!
 *  @brief Method to set user's gender.
 *
 *
 *  This method can be impelented to capture applcation user's gender. Use this method only if you collect this
 *  information explictly from your user (i.e. - there is no need to set a default value).
 *
 *  @note The gender is aggregated across all users of your app and not available on a per user
 *  basis.
 *
 *  @param gender, The gender of user. (provided by the developer)
 *
 */

-(void)setUserGender:(Gender)gender;
/*
 * Sets the location of the current user
 */


/** @name Location Reporting
 *  Methods for setting location information.
 */
//@{
/*!
 *  @brief Set user location.
 *
 *  Use information from the CLLocationManager to specify the location of the session. 
 * // revisit the below statements.
 *  @note Only the last location entered is captured per session.
 *  Location is aggregated across all users of your app and not available on a per user basis. 
 *  This information should only be captured if it is germaine to the use of your app.
 *
 *  @code
 CLLocationManager *locationManager = [[CLLocationManager alloc] init];
 [locationManager startUpdatingLocation];
 
 CLLocation *location = locationManager.location;
 [Flurry setLatitude:location.coordinate.latitude
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
/*
 * Sets the remarks if any
 */

/*!
 *  @brief Method to set remarks, if any.
 *
 *
 *  This method can be impelented by the developer to put remarks on the occurance of a particular event.
 *  (i.e. - there is no need to set a default value).
 *
 *
 *  @param remark (provided by the developer)
 *
 */


-(void)setRemark:(NSString *)remark;
/*
 * Returns the ID of the active user
 */


/*!
 *  @brief Returns the ID of the active user
 *
 *  This method returns applcation user's ID , as recorded by the developer by implementing userId setter method. 
 *
 *  @note Use this method only if you collect this information explictly from your user.
 */

-(NSString *)getUserId;
/*
 * Returns the name of active user
 */

/*!
 *  @brief Returns the name of the active user
 *
 *  This method returns applcation user's name, as recorded by the developer by implementing userName setter method. 
 *
 *  @note Use this method only if you collect this information explictly from your user.

 */

-(NSString *)getUserName;
/*
 * Returns the age of the active user
 */

/*!
 *  @brief Returns the age of the active user
 *
 *  This method returns applcation user's age, as recorded by the developer by implementing userAge setter method.
 *
 *  @note Use this method only if you collect this information explictly from your user.
 */

-(int)getUserAge;
/*
 * Returns the gender of the active user
 */

/*!
 *  @brief Returns the gender of the active user.
 *
 *  This method returns applcation user's gender, as recorded by the developer by implementing userGender setter method. 
 *
 *  @note Use this method only if you collect this information explictly from your user.

 */

-(int)getUserGender;
/*
 * Returns the remark set by user 
 */

/*!
 *  @brief Returns the remark provided by the developer on a particular event's occourance.
 *
 *  This method returns the remark associated with the occourance of a particular event, as recorded by the developer by implementing userRemark setter method. 
 *
 *  @note Use this method only if you set a remark explicitly for the occourance of a particular event.

 */

-(NSString *)getUserRemark;
/*
 * Returns the user current latitude component of location coordinate.
 */

/*!
 *  @brief  Returns the current latitude component of location coordinate for the active user.

 *
 *  This method returns applcation user's latitude component of location coordinate, as recorded by the developer by implementing userLatitude setter method.
 *
 *
  * @note Use this method only if you collect this information explictly from your user.

 */

-(double)getUserLatitude;
/*
 * Returns the user current longitude component of location coordinate.
 */

/*!
 *  @brief Returns the current longitude component of location coordinate for the active user.
 *
 *  This method returns applcation user's longitude component of location coordinate, as recorded by the developer by implementing userLongitude setter method.
 *
 *  @note Use this method only if you collect this information explictly from your user.

 */
-(double)getUserLongitude;
/*
 * Returns the user vertical accuracy. 
 */

/*!
 *  @brief Returns the vertical accuracy in location of the active user.
 *
 *  This method returns vertical accuracy in location of the active user, as recorded by the developer by implementing userVerticalAccuracy setter method.
 *
 *  @note Use this method only if you collect this information explictly from your user.

 */

-(float)getVerticalAccuracy;
/*
 * Returns the user horizontal accuracy.
 */

/*!
 *  @brief Returns the horizontal accuracy in location of the active user.
 *
 *  This method returns returns the horizontal accuracy in location of the active user, as recorded by the developer by implementing userHorizontalAccuracy setter method.
 
 *
 *  @note Use this method only if you collect this information explictly from your user.

 */

-(float)getHorizontalAccuracy;

/*
 * Returns the application user's age, gender and the remark.
 */

/*!
 *  @brief Method to set the application user's age, gender and the remark provided by the developer on a particular event's occourance, in one call.
 *
 *  This method can be impelented to capture applcation user's age, gender and the remark provided by the developer on a particular event's occourance. Use this method only if you collect this
 *  information explictly from your user (i.e. - there is no need to set a default value).
 *  
 *  @note Use this method only if you collect the application user's age and gender explicitly, and need to set a remark on the occurance of an event.
 *
 *
 *  @param age, gender, remark
 *
 *
 
 */

-(void)setUserAge:(int)age gender:(int)gender remark:(NSString *)remark;


/*!
 *  @brief Method to set a time window for which the generated events are buffered before they being dispatched to the Cetas service.
 *
 *
 *  @note This method should be used by the application developer to explicitly set the time interval for which the Cetas Analytics would buffer the generated events (till the maximum capacity is reached), before they are dispatched to the Cetas service. Events will be dispatched periodically after every update time interval.
 *
 *  @param updateInterval, the event buffering time inte
 */

-(void)setUpdateInterval:(NSInteger)updateInterval;


@end
