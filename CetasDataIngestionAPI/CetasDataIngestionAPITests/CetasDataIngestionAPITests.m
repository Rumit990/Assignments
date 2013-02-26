//
//  CetasDataIngestionAPITests.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//


#import "CetasDataIngestionAPITests.h"
#import "Config.h"
#import "Event.h"
#import "EventUtil.h"

@implementation CetasDataIngestionAPITests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


-(void)testDataIngestionAPI{
    Config *config =[[Config alloc] init];
    [config test];
    Event *event =[[EventVO alloc] init];
    [event getEventJsonRepresentation];

    
    
}
@end
