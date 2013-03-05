//
//  JsonParser.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
// Json Parser: This class contains the methods to prepare json from object and vice versa.
@interface JsonParser : NSObject

/*!
 * @brief : Returns json representaion of object passed as param.
 * @param : Object needed to convert into json. This could be dictionary or array.
 */
+(NSString *)JSONRepresentation:(id)Object;

/*!
 * @brief : Returns object specific to json passed.
 * @param : Json string that needed to parse.
 */
+ (id)JSONValue:(NSString *)jsonString ;
@end
