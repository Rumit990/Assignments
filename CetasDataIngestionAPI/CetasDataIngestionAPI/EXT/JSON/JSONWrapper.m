
//
//  JSONWrapper.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import <Foundation/Foundation.h>
#import "JSONWrapper.h"
#import "JSONKit.h"

@implementation NSString (NSString_JSON)

- (id)JSONValue
{
    return [self objectFromJSONString];
}
- (id)mutableJSONValue
{
    return [self mutableObjectFromJSONString];
}
@end

@implementation NSDictionary(NSDictionary_JSON)

- (NSString *)JSONRepresentation
{
    return [self JSONString];
}

@end

@implementation NSArray(NSArray_JSON)

- (NSString *)JSONRepresentation
{
    return [self JSONString];
}
@end

