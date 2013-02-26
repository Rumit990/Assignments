//
//  EventVO.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//


#import "EventUtil.h"
#import "Event.h"
#import "Constants.h"
#import "JSON.h"

@interface Event()

@property NSTimeInterval eventTime;
@property NSInteger sequenceNumber;
@property NSInteger type;
@property (strong) NSMutableDictionary *attributes;
@property (strong) NSString *attributesName;

@end


@implementation Event

- (id)init
{
    self = [super init];
    if (self) {
        // Work your initialising magic here as you normally would
        self.type = kMessageRequestTypeMessage;
        self.attributesName = @"custom";
        self.attributes = [[NSMutableDictionary alloc] init];
        
    }
    return self;
}


-(void)setDate:(NSDate *)date{
    self.time = [date timeIntervalSinceNow];
}
-(void)setTime:(NSTimeInterval)time{
    self.eventTime = time;
}
-(void)setEventDetail:(NSDictionary *)eventDetail{
    self.attributes = [[NSMutableDictionary alloc] initWithDictionary:eventDetail];
}
-(void)setEventAtribute:(NSString *)eventName forKey:(NSString *)eventValue{
    
    [self.attributes setObject:eventValue forKey:eventName];
}

-(NSString *)getEventAttributeForKey:(NSString *)key{
    return [self.attributes objectForKey:key];
}
-(NSString *)getEventJsonRepresentation{
    
    NSMutableDictionary *eventDic = [[NSMutableDictionary alloc] init];
    NSNumber *time = [NSNumber numberWithDouble:self.eventTime];
    [eventDic setObject:time forKey:@"time"];
    [eventDic setObject:[NSNumber numberWithInteger:self.sequenceNumber] forKey:@"sequence"];
    [eventDic setObject:[NSNumber numberWithInteger:self.type] forKey:@"type"];
    [eventDic setObject:self.attributes forKey:self.attributesName];
    return [eventDic JSONRepresentation];
}
@end
