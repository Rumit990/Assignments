//
//  Request.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import "Request.h"
#import "Constants.h"
#import "JSON.h"
#import "Event.h"
#import "EventUtil.h"

@implementation Request


-(NSString *)getJSONRepresentation{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:self.token forKey:kCetasAPIResponseKeyToken];
    [dic setValue:[NSNumber numberWithInteger:self.timeout] forKey:kCetasAPIResponseKeyTimeout];
    [dic setValue:self.attributes forKey:kCetasAPIResponseKeyAttributes];
    [dic setValue:self.user forKey:kCetasAPIResponseKeyUser];
    
    // Prepare content as a string.
    NSMutableArray *events = [[NSMutableArray alloc] init];
    for (Event *event in self.content) {
        [events addObject:[event getEventJsonRepresentation]];
    }
    NSString *eventStr = [events componentsJoinedByString:@"\n"];
    if(!events.count)
        eventStr = @"null";
    
    [dic setValue:eventStr forKey:kCetasAPIResponseKeyContent];
    return [dic JSONRepresentation];
}


@end
