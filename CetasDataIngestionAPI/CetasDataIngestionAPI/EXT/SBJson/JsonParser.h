//
//  JsonParser.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"

@interface JsonParser : NSObject
+(NSString *)JSONRepresentation:(id)Object;
+ (id)JSONValue:(NSString *)jsonString ;
@end
