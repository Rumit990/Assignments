//
//  JsonParser.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import "JsonParser.h"

@implementation JsonParser

+(NSString *)JSONRepresentation:(id)Object {
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *json = [writer stringWithObject:Object];
    if (!json)
        NSLog(@"-JSONRepresentation failed. Error is: %@", writer.error);
    return json;
}
+ (id)JSONValue:(NSString *)jsonString {
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    id repr = [parser objectWithString:jsonString];
    if (!repr)
        NSLog(@"-JSONValue failed. Error is: %@", parser.error);
    return repr;
}


@end
