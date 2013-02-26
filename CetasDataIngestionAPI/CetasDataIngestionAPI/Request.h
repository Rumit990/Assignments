//
//  Request.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import <Foundation/Foundation.h>

@interface Request : NSObject

@property (strong) NSString *token;
@property NSInteger timeout;
@property (strong) NSDictionary *attributes;
@property (strong) NSDictionary *user;
@property (strong) NSDictionary *content;

-(NSString *)getJSONRepresentation;

@end
