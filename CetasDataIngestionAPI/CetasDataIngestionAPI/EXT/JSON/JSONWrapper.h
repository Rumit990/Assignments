//
//  JSONWrapper.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

// This class is a wrapper class for JSON utility methods.

#import <Foundation/Foundation.h>

@interface JSONWrapper 

@end

@interface NSString (NSString_JSON)

- (id)JSONValue;
- (id)mutableJSONValue;
@end

@interface NSDictionary(NSDictionary_JSON)

- (NSString *)JSONRepresentation;

@end

@interface NSArray(NSArray_JSON)

- (NSString *)JSONRepresentation;

@end
