//
//  ConfigUtil.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

#import <Foundation/Foundation.h>

@interface Config (){
    
}
@property (strong) NSMutableDictionary *userInfo;
@property NSInteger capacity;
@property NSInteger interval;
@property NSInteger timeout;
@property BOOL showErrorInLogs;


@end
