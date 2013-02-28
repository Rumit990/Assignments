//
//  EventVO.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//


#import <Foundation/Foundation.h>
#import "Event.h"


@interface Event (){
    
}

@property NSTimeInterval eventTime;
@property NSInteger sequenceNumber;
@property NSInteger type;
@property (strong) NSMutableDictionary *attributes;
@property (strong) NSString *attributesName;

-(NSString *)getEventJsonRepresentation;
-(id)initWithType:(NSInteger)paramType;

@end
