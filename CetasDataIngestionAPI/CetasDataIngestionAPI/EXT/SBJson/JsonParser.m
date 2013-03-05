//
//  JsonParser.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import "JsonParser.h"
// Json Parser: This class contains the methods to prepare json from object and vice versa.
@implementation JsonParser
/*!
 * @brief : Returns json representaion of object passed as param.
 * @param : Object needed to convert into json. This could be dictionary or array.
 */
+(NSString *)JSONRepresentation:(id)Object {
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *json = [writer stringWithObject:Object];
    if (!json)
        NSLog(@"-JSONRepresentation failed. Error is: %@", writer.error);
    return json;
}
/*!
 * @brief : Returns object specific to json passed.
 * @param : Json string that needed to parse.
 */
+ (id)JSONValue:(NSString *)jsonString {
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    id repr = [parser objectWithString:jsonString];
    if (!repr)
        NSLog(@"-JSONValue failed. Error is: %@", parser.error);
    return repr;
}


@end
