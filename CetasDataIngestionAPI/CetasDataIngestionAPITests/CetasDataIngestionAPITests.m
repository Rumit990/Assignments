//
//  CetasDataIngestionAPITests.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//


#import "CetasDataIngestionAPITests.h"
#import "Config.h"
#import "Event.h"
#import "CetasTracker.h"

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
    Config *config = [[Config alloc] init];
    [config setUserName:@"someone"];
    [config setUserId:@"userid"];
    CetasTracker *tracker = [[CetasTracker alloc] getTrackerWithApiKey:@"mq28uQr94zM5yHMrBWGX5P3j+pNajzT9StMd+WoEyDsJj40U+ebzS5k0Nj1CCVc6efnohnFJeOOyWf0KAxqeD7RH5x+hB8dEOio8HQOWMjCJZnTV22yTOLBCeTsk+h1GdMeE1KOTl2X7USpLVUk6bw==" config:config];

    
    

    
    
}
@end
