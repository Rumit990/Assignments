//
//  Config.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import "Config.h"
#import "Constants.h"

#define kGenderUnknown 0
#define kGenderMale 1
#define kGenderFemale 2

@interface Config (){
    
}
@property (strong) NSMutableDictionary *userInfo;
@property NSInteger capacity;
@property NSInteger interval;
@property NSInteger timeout;
@property BOOL showErrorInLogs;


@end
@implementation Config
static Config *defaultInstance = nil;
/**
 * Called to get default shared instance of this class. If not already exists, it creates one and returns that
 */
+(id)getDefaultInstance{
    if (defaultInstance == nil) {
        defaultInstance = [[super allocWithZone:NULL] init];
        if(!defaultInstance.userInfo){
            defaultInstance.userInfo = [[NSMutableDictionary alloc] init];
        }
        [defaultInstance.userInfo setObject:@"default_user" forKey:kUserInfoKeyUserID];
        [defaultInstance.userInfo setObject:@"Default User" forKey:kUserInfoKeyUserName];
        [defaultInstance.userInfo setObject:[[NSNumber alloc] initWithInt:0] forKey:kUserInfoKeyUserAge];
        [defaultInstance.userInfo setObject:[[NSNumber alloc] initWithInt:kGenderUnknown] forKey:kUserInfoKeyUserGender];
        [defaultInstance.userInfo setObject:[[NSNumber alloc] initWithDouble:0] forKey:kUserInfoKeyUserLongitude];
        [defaultInstance.userInfo setObject:[[NSNumber alloc] initWithDouble:0] forKey:kUserInfoKeyUserLatitude];
        [defaultInstance.userInfo setObject:[[NSNumber alloc] initWithFloat:0.0] forKey:kUserInfoKeyUserHorizontalAccuracy];
        [defaultInstance.userInfo setObject:[[NSNumber alloc] initWithFloat:0.0] forKey:kUserInfoKeyUserVerticalAccuracy];
        
        [defaultInstance.userInfo setObject:@"" forKey:kUserInfoKeyUserRemark];
        defaultInstance.capacity = 1000;
        defaultInstance.interval = 60;
        defaultInstance.timeout = 1800;
        
    }
    
    return defaultInstance;
}

//default initializer
- (id)init
{
    self = [super init];
    
    if (self) {
        // Work your initialising magic here as you normally would
        self.userInfo =[[NSMutableDictionary alloc] init];
    }
    
    return self;
}

+(void)test{
    NSLog(@"test");
}


-(void)setUserId:(NSString *)userId{
    [self.userInfo setObject:userId forKey:kUserInfoKeyUserID];

}
-(void)setUserAge:(int)age{

    [self.userInfo setObject:[[NSNumber alloc] initWithInt:age] forKey:kUserInfoKeyUserAge];

}

-(void)setUserGender:(int)gender{
    [self.userInfo setObject:[[NSNumber alloc] initWithInt:gender] forKey:kUserInfoKeyUserGender];
}
- (void)setUserLatitude:(double)latitude longitude:(double)longitude horizontalAccuracy:(float)horizontalAccuracy verticalAccuracy:(float)verticalAccuracy{
    
    [self.userInfo setObject:[[NSNumber alloc] initWithDouble:longitude] forKey:kUserInfoKeyUserLongitude];
    [self.userInfo setObject:[[NSNumber alloc] initWithDouble:latitude] forKey:kUserInfoKeyUserLatitude];
    [self.userInfo setObject:[[NSNumber alloc] initWithFloat:horizontalAccuracy] forKey:kUserInfoKeyUserHorizontalAccuracy];
    [self.userInfo setObject:[[NSNumber alloc] initWithFloat:verticalAccuracy] forKey:kUserInfoKeyUserVerticalAccuracy];
}

-(void)setRemark:(NSString *)remark{
    [self.userInfo setObject:remark forKey:kUserInfoKeyUserRemark];
}

-(NSString *)getUserId{
    return [self.userInfo objectForKey:kUserInfoKeyUserID];
}

-(int)getUserAge{
    return [[self.userInfo objectForKey:kUserInfoKeyUserAge] intValue];

}

-(int)getUserGender{
    return [[self.userInfo objectForKey:kUserInfoKeyUserGender] intValue];

}
-(NSString *)getUserRemark{
    return [self.userInfo objectForKey:kUserInfoKeyUserRemark];

}

-(double)getUserLatitude{
    return [[self.userInfo objectForKey:kUserInfoKeyUserLatitude] doubleValue];

}

-(double)getUserLongitude{
    return [[self.userInfo objectForKey:kUserInfoKeyUserLongitude] doubleValue];

}

-(float)getVerticalAccuracy{
    return [[self.userInfo objectForKey:kUserInfoKeyUserVerticalAccuracy] floatValue];

}
-(float)getHorizontalAccuracy{
    return [[self.userInfo objectForKey:kUserInfoKeyUserHorizontalAccuracy] floatValue];

}


@end
