//
//  Config.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//
//

#import "Config.h"
#import "Constants.h"
#import "ConfigUtil.h"
/*!
 * @name:  Implementation file for config class.
 * @brief: Provides all the methods for setting user information and configuration parameters.
 */

@implementation Config

// Static variable holds singleton object of config class.

static Config *defaultInstance = nil;
/*!
 * @brief : Provides a singleton config object.
 *
 * For convenience, this class provides a default config instance.
 * Static method called to get default shared instance of this class with default values for all configuration parameters. If not already exists, it creates one and returns that.
 * This is initialized to `nil` and will be set to the instance that is
 * instantiated in - init call. It may be overridden as desired.
 *
 */
+(id)getDefaultInstance{
    if (defaultInstance == nil) {
        defaultInstance = [[super allocWithZone:NULL] init];
        [Config setDefaultValues:defaultInstance];
        
    }
    return defaultInstance;
}
/*!
 * @brief : Set the default value of all configuration information.
 * @param : Config : Config object for which default values to set. 
 *
 *
 */
+(void)setDefaultValues:(Config *)config{
    if(!config.userInfo){
        config.userInfo = [[NSMutableDictionary alloc] init];
    }
    [config.userInfo setObject:@"default_user" forKey:kUserInfoKeyUserID];
    [config.userInfo setObject:@"Default User" forKey:kUserInfoKeyUserName];
    [config.userInfo setObject:[[NSNumber alloc] initWithInt:0] forKey:kUserInfoKeyUserAge];
    [config.userInfo setObject:[[NSNumber alloc] initWithInt:GenderUnknown] forKey:kUserInfoKeyUserGender];
    [config.userInfo setObject:[[NSNumber alloc] initWithDouble:0] forKey:kUserInfoKeyUserLongitude];
    [config.userInfo setObject:[[NSNumber alloc] initWithDouble:0] forKey:kUserInfoKeyUserLatitude];
    [config.userInfo setObject:[[NSNumber alloc] initWithFloat:0.0] forKey:kUserInfoKeyUserHorizontalAccuracy];
    [config.userInfo setObject:[[NSNumber alloc] initWithFloat:0.0] forKey:kUserInfoKeyUserVerticalAccuracy];
    
    [config.userInfo setObject:@"" forKey:kUserInfoKeyUserRemark];
    config.capacity = 1000;
    config.interval = 60;
    config.timeout = 1800;
}

//default initializer
- (id)init
{
    self = [super init];
    
    if (self) {
        // Set the default values
        [Config setDefaultValues:self];
        //Set the singleton object.
        defaultInstance = self;
    }
    
    return self;
}


/*! @name : Sets the ID of the current active user.
 *  @brief Method to assign a unique id for the application end-user.
 *
 *  @param userId: The unique id for the the application user.
 */
-(void)setUserId:(NSString *)userId{

    if(userId && ![userId isEqualToString:@""]){
        
        [self.userInfo setObject:userId forKey:kUserInfoKeyUserID];

    }
}
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
-(void)setUserAge:(int)age{

    [self.userInfo setObject:[[NSNumber alloc] initWithInt:age < 0 ? 0 : age] forKey:kUserInfoKeyUserAge];

}
/*!
 *  @name : Sets the gender of the current active user.
 *  @brief: Method to set user's gender.
 *
 * This method can be used to capture the gender of the application user. Use this method only if you collect this information explictly from your user (i.e. - there is no need to set a default value).
 *
 *  @param : gender: The gender of user. It can have three possible values from enum gender i.e (GenderUnknown, GenderMale, GenderFemale).
 *
 */
-(void)setUserGender:(Gender)gender{
    
    if(gender < GenderUnknown || gender >GenderFemale)
    {
        gender = GenderUnknown; // set to unknown in case of invalid parameters.
    }
    else  [self.userInfo setObject:[[NSNumber alloc] initWithInt:gender] forKey:kUserInfoKeyUserGender];
}
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
-(void)setUserAge:(int)age gender:(Gender)gender remark:(NSString *)remark{
    
    [self setUserAge:age];    
    [self setUserGender:gender];
    [self setRemark:remark];

}
/*! @name Location Reporting . Methods for setting location information.
 *  @brief Set user location.
 *
 *  Use information from the CLLocationManager to specify the location of the session. Cetas does not
 *  automatically track this information or include the CLLocation framework.
 
 *  @endcode
 *  @param latitude The latitude.
 *  @param longitude The longitude.
 *  @param horizontalAccuracy The radius of uncertainty for the location in meters.
 *  @param verticalAccuracy The accuracy of the altitude value in meters.
 *
 */
- (void)setUserLatitude:(double)latitude longitude:(double)longitude horizontalAccuracy:(float)horizontalAccuracy verticalAccuracy:(float)verticalAccuracy{
    
    [self.userInfo setObject:[[NSNumber alloc] initWithDouble:longitude] forKey:kUserInfoKeyUserLongitude];
    [self.userInfo setObject:[[NSNumber alloc] initWithDouble:latitude] forKey:kUserInfoKeyUserLatitude];
    [self.userInfo setObject:[[NSNumber alloc] initWithFloat:horizontalAccuracy] forKey:kUserInfoKeyUserHorizontalAccuracy];
    [self.userInfo setObject:[[NSNumber alloc] initWithFloat:verticalAccuracy] forKey:kUserInfoKeyUserVerticalAccuracy];
}
/*!
 *  @brief Method to set remarks, if any.
 *
 *  This method can be used by the developer to put some remark while setting user information.
 *  (i.e. - there is no need to set a default value).
 *  @param remark .
 *
 */
-(void)setRemark:(NSString *)remark{
    if(remark.length >100)
    {
         // a max of 100 characters are permissible in remark.
        [self.userInfo setObject:[remark substringToIndex:kValidationLimitRemarkLengthMax]  forKey:kUserInfoKeyUserRemark];
    }
    else{
        [self.userInfo setObject:remark forKey:kUserInfoKeyUserRemark];
    }

}
/*!
 *  @name Sets the name of the current active user.
 *  @brief Method to set user's name.
 *
 *  This method can be used to capture the name of the application user. Use this method only if you collect this information explictly from your user (i.e. - there is no need to set a default value).
 *  @param name: The name of application user.
 *
 */
-(void)setUserName:(NSString *)name{
    if(name && ![name isEqualToString:@""]){

        [self.userInfo setValue:name forKey:kUserInfoKeyUserName];

    }
}
/*!
 *  @brief : Returns the name of the active user
 *
 *  This method returns active user name, as set by the developer while setting user information.
 *
 *  @note If not set it will return nil.
 */
-(NSString *)getUserName{
    return [self.userInfo objectForKey:kUserInfoKeyUserName];
}
/*!
 *  @brief Returns the ID of the active user.
 *  This method returns active user ID , as set by the developer while setting user information.
 *
 *  @note If not set it will return nil.
 */
-(NSString *)getUserId{
    return [self.userInfo objectForKey:kUserInfoKeyUserID];
}
/*!
 *  @brief Returns the age of the active user
 *
 *  This method returns active user age, as set by the developer while setting user information.
 *
 *  @note If not set it will return nil.
 */

-(int)getUserAge{
    return [[self.userInfo objectForKey:kUserInfoKeyUserAge] intValue];

}
/*!
 *  @brief Returns the gender of the active user.
 *
 *  This method returns active user's gender, as set by the developer while setting user information.
 *
 *  @note If not set it will return nil.It can have three possible values from enum gender i.e (GenderUnknown, GenderMale, GenderFemale).
 
 */
-(int)getUserGender{
    return [[self.userInfo objectForKey:kUserInfoKeyUserGender] intValue];

}
/*!
 *  @brief Returns the remark.
 *
 *  This method returns the remark as set by the developer while setting user information.
 *
 *  @note If not set it will return nil.
 
 */
-(NSString *)getUserRemark{
    return [self.userInfo objectForKey:kUserInfoKeyUserRemark];

}
/*!
 *  @brief  Returns the latitude component of location for the active user.
 *
 *  This method returns active user's latitude component of location, as set by the developer while setting user information.
 *
 *
 * @note If not set it will return nil.
 
 */
-(double)getUserLatitude{
    return [[self.userInfo objectForKey:kUserInfoKeyUserLatitude] doubleValue];

}
/*!
 *  @brief  Returns the longitude component of location for the active user.
 *
 *  This method returns active user's longitude component of location, as set by the developer while setting user information.
 *
 *
 * @note If not set it will return nil.
 
 */
-(double)getUserLongitude{
    return [[self.userInfo objectForKey:kUserInfoKeyUserLongitude] doubleValue];

}
/*!
 *  @brief Returns the vertical accuracy in location of the active user.
 *
 *  This method returns vertical accuracy in location of the active user,  as set by the developer while setting user information.
 *
 * @note If not set it will return nil.
 */
-(float)getVerticalAccuracy{
    return [[self.userInfo objectForKey:kUserInfoKeyUserVerticalAccuracy] floatValue];

}
/*!
 *  @brief Returns the horizontal accuracy in location of the active user.
 *
 *  This method returns horizontal accuracy in location of the active user,  as set by the developer while setting user information.
 *
 * @note If not set it will return nil.
 */
-(float)getHorizontalAccuracy{
    return [[self.userInfo objectForKey:kUserInfoKeyUserHorizontalAccuracy] floatValue];

}

/*!
 *  @brief Method to set a time interval between each dispatch  of the generated events to the Cetas service. Until the interval is not reached events are buffered.
 *
 *  @note This method should be used by the application developer to explicitly set the time interval for which the Cetas Analytics would buffer the generated events (till the maximum capacity is reached), before they are dispatched to the Cetas service. Events will be dispatched periodically after every update time interval.
 *
 *  @param updateInterval: Number of seconds for update interval.
 */
-(void)setUpdateInterval:(NSInteger)interval{
    
    int updateInterval = [self validateValue:interval minValue:kMinUpdateTimeInterval
                                           maxValue:kMaxUpdateTimeInterval];
    self.interval = updateInterval;
}

/*!
 *  @brief Method to check if value lies within specified range. If value exceeds the range nearest of max or min value is returned.
 *
 *  @param updateInterval: Number of seconds for update interval.
 */
-(int)validateValue:(int)value minValue:(int)min maxValue:(int)max{
    
    if (value < min){
        return min;
    }
    if (value > max){
        return max;
    }
    return value;
}

@end
