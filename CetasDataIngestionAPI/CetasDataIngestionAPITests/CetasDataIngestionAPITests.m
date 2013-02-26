//
//  CetasDataIngestionAPITests.m
//  CetasDataIngestionAPITests
//
//  Created by Prateek Pradhan on 25/02/13.
//  Copyright (c) 2013 Cetas Software. All rights reserved.
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
