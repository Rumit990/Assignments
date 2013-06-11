//
//  CetasEventPreliminaryInfo.h
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
 * @brief : Provides the methods for setting user information and other additional information to be sent along with event.
 *
 *  Provides set of methods that allows developers specify user information and other additional information to be sent along with event.
 *
 */


@interface CetasEventPreliminaryInfo : NSObject


/*!
 * @brief : Provides a EventPreliminaryInfo object.
 *
 */
+(id)eventPreliminaryInfo;


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
 *  information explicitly from your user (i.e. - there is no need to set a default value).
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
    #import <CoreLocation/CoreLocation.h>
    //....Other Code...
    //...Method Code...
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    [locationManager startUpdatingLocation];
 
    CLLocation *location = locationManager.location;
    //Create CetasEventPreliminaryInfo object and set user location.
    CetasEventPreliminaryInfo *info = [[CetasTracker getDefaultTracker] eventPreliminaryInfo];
    [info setUserLatitude:location.coordinate.latitude
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



/*! @name Carrier Reporting. Methods for setting carrier information.
 *  @brief Set user's carrier information
 *
 *  Use information from the CTTelephonyNetworkInfo class to specify the carrier information. Cetas does not automatically track this information or include the CoreTelephony framework.
 * Use the below code to specify carrier information
 *  @code
 #import <CoreTelephony/CTCarrier.h>
 #import <CoreTelephony/CTTelephonyNetworkInfo.h>
 //....Other Code...
 //...Method Code...
 CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
 CTCarrier *ctCarrier = [netinfo subscriberCellularProvider];
 //Create CetasEventPreliminaryInfo object and set user location.
 CetasEventPreliminaryInfo *info = [[CetasTracker getDefaultTracker] eventPreliminaryInfo];
 [info setUserCarrierName:ctCarrier.carrierName mobileCode:ctCarrier.mobileCountryCode mobileNetworkCode:ctCarrier.mobileNetworkCode isoCountryCode:ctCarrier.isoCountryCode];

 *  @endcode
 *  @param carrierName String representing carrier name.
 *  @param mobileCode  String representing mobile code.
 *  @param mobileNetworkCode String representing mobile network code.
 *  @param isoCountryCode String representing isoCountryCode
 *
 */

- (void)setUserCarrierName:(NSString *)carrierName mobileCode:(NSString *)mobileCode mobileNetworkCode:(NSString *)mobileNetworkCode isoCountryCode:(NSString *)isoCountryCode;

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
 *  @name Sets the flag wheather user is paid or not.
 *  @brief This method allows setting the current user type, to a paid user or just a guest. If the API is not invoked, the paid flag will be set to "unknown"(i.e N/A).
 *  @param isPaid as a Bool.
 *
 */
-(void)setUserIsPaid:(BOOL)isPaid;

@end
