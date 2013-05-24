//
//  RunningApps.m
//  RunningApps
//
//  Created by Surendra on 23/05/13.
//  Copyright (c) 2013 Tinyview Inc. All rights reserved.
//

#import "RunningApps.h"
#include <sys/sysctl.h>

@implementation RunningApps

@synthesize country = _country;

#pragma mark - Public methods
- (void)detectAppIdsWithIncremental:(void (^)(NSArray *appIds))incrementalBlock
                        withSuccess:(void (^)(NSArray *appIds))successBlock
                        withFailure:(void (^)(NSError *error))failureBlock {
    dispatch_queue_t detection_thread = dispatch_queue_create(NULL, NULL);
    dispatch_async(detection_thread, ^{
        
        [self retrieveAppNameDictionaryWithSuccess:^(NSDictionary *appNameAppsDictionary) {
            
            NSArray *runningProcesses = [self runningProcesses];
            NSLog(@"Running Processes : %@",runningProcesses);
            
            NSMutableArray *appNameDictionaries = [[NSMutableArray alloc] init];
            for (NSString *appName in appNameAppsDictionary.allKeys) {
                NSArray *appIds = [appNameAppsDictionary objectForKey:appName];
                NSDictionary *appNameDictionary = @{@"appName" : appName, @"ids" : appIds};
                [appNameDictionaries addObject:appNameDictionary];
            }
            
            __block BOOL successBlockExecuted = FALSE;
            NSMutableSet *successfulAppIds = [[NSMutableSet alloc] init];
            NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
            NSArray *arrayOfArrays =  [self subarraysOfArray:appNameDictionaries withCount:1000];
            for (NSArray *appNameDictionariesArray in arrayOfArrays) {
                [operationQueue addOperationWithBlock: ^{
                    NSMutableSet *incrementalAppIds = [[NSMutableSet alloc] init];
                    for (NSDictionary *appNameDictionary in appNameDictionariesArray) {
                        NSString *appName = [appNameDictionary objectForKey:@"appName"];
                        NSDictionary *processDict = [self isRunningProcess:appName processes:runningProcesses];
                        if(processDict) {
                            
                            NSArray *appIds = [appNameDictionary objectForKey:@"ids"];
                            for (NSString *appId in appIds) {
                                BOOL containsObj = NO;
                                for (NSDictionary *dict in successfulAppIds.allObjects) {
                                    if ([[[dict objectForKey:@"appId"] stringValue] isEqualToString:appId]) {
                                        containsObj = YES;
                                        break;
                                    }
                                }
                                if (!containsObj) {
                                    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:appId,@"appId",[processDict objectForKey:@"appStartTime"],@"appStartTime", nil];
                                    [successfulAppIds addObject:dict];
                                    [incrementalAppIds addObject:dict];
                                }
                            }
                        }
                    }
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        if (incrementalBlock && incrementalAppIds.count) {
                            incrementalBlock(incrementalAppIds.allObjects);
                        }
                    });
                    /* Unhappy with this implementation */
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1f * NSEC_PER_SEC),
                                   dispatch_get_main_queue(), ^{
                                       if (operationQueue.operationCount == 0 && successBlock && !successBlockExecuted) {
                                           successBlockExecuted = TRUE;
                                           successBlock(successfulAppIds.allObjects);
                                       }
                                   });
                }];
            }
        } failure:failureBlock];
        
    });
    #if !OS_OBJECT_USE_OBJC
        dispatch_release(detection_thread);
    #endif
}

- (void)detectAppDictionariesWithIncremental:(void (^)(NSArray *appDictionaries))incrementalBlock
                                 withSuccess:(void (^)(NSArray *appDictionaries))successBlock
                                 withFailure:(void (^)(NSError *error))failureBlock {
    __block BOOL successBlockExecuted = FALSE;
    __block BOOL appIdDetectionComplete = FALSE;
    __block NSInteger netAppIncrements = 0;
    NSMutableArray *successfulAppDictionaries = [[NSMutableArray alloc] init];
    [self detectAppIdsWithIncremental:^(NSArray *appIds) {
        netAppIncrements += 1;
        [self retrieveAppDictionariesForAppIds:appIds
                                   withSuccess:^(NSArray *appDictionaries) {
                                       [successfulAppDictionaries addObjectsFromArray:appDictionaries];
                                       incrementalBlock(appDictionaries);
                                       netAppIncrements -= 1;
                                       /* Unhappy with this implementation */
                                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1f * NSEC_PER_SEC),
                                                      dispatch_get_main_queue(), ^{
                                                          if (appIdDetectionComplete &&
                                                              !netAppIncrements &&
                                                              successBlock &&
                                                              !successBlockExecuted) {
                                                              successBlockExecuted = TRUE;
                                                              successBlock(successfulAppDictionaries);
                                                          }
                                                      });
                                   } withFailure:^(NSError *error) {
                                       netAppIncrements -= 1;
                                       /* Unhappy with this implementation */
                                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1f * NSEC_PER_SEC),
                                                      dispatch_get_main_queue(), ^{
                                                          if (appIdDetectionComplete &&
                                                              !netAppIncrements &&
                                                              successBlock &&
                                                              !successBlockExecuted) {
                                                              successBlockExecuted = TRUE;
                                                              successBlock(successfulAppDictionaries);
                                                          }
                                                      });
                                   }];
    } withSuccess:^(NSArray *appIds) {
        appIdDetectionComplete = TRUE;
    } withFailure:failureBlock];
}

- (void)retrieveAppDictionariesForAppIds:(NSArray *)appIdsDicts
                             withSuccess:(void (^)(NSArray *appDictionaries))successBlock
                             withFailure:(void (^)(NSError *error))failureBlock {
    dispatch_queue_t retrieval_thread = dispatch_queue_create(NULL, NULL);
    dispatch_async(retrieval_thread, ^{
        NSMutableArray *appIds = [NSMutableArray array];
        for (NSDictionary *appDict in appIdsDicts) {
            [appIds addObject:[appDict objectForKey:kDictKeyAppId]];
        }
        
        NSString *appString = [appIds componentsJoinedByString:@","];
        NSMutableString *requestUrlString = [[NSMutableString alloc] init];
        [requestUrlString appendFormat:@"http://itunes.apple.com/lookup"];
        [requestUrlString appendFormat:@"?id=%@", appString];
        [requestUrlString appendFormat:@"&country=%@", self.country];
        
        NSURLResponse *response;
        NSError *connectionError;
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:requestUrlString]];
        [request setTimeoutInterval:20.0f];
        [request setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
        NSData *result = [NSURLConnection sendSynchronousRequest:request
                                               returningResponse:&response
                                                           error:&connectionError];
        if (connectionError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failureBlock) {
                    failureBlock(connectionError);
                }
            });
        } else {
            NSError *jsonError;
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:result
                                                                           options:0
                                                                             error:&jsonError];
            if (jsonError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (failureBlock) {
                        failureBlock(jsonError);
                    }
                });
            } else {
                NSArray *results = [jsonDictionary objectForKey:@"results"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (successBlock) {
                        NSMutableArray *mResult = [NSMutableArray array];
                        for (NSDictionary *dict in results) {
                            for (NSDictionary *appDict in appIdsDicts) {

                                NSString *appId1 = [[appDict objectForKey:kDictKeyAppId] stringValue];
                                NSString *appId2 = [[dict objectForKey:@"trackId"] stringValue];
                                if ([appId1 isEqualToString:appId2]) {
                                    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:dict];
                                    [mDict setObject:[appDict objectForKey:kDictKeyStartTime] forKey:kDictKeyStartTime];
                                    [mResult addObject:[NSDictionary dictionaryWithDictionary:mDict]];
                                }
                            }
                            
                        }
                        
                        successBlock([NSArray arrayWithArray:mResult]);
                    }
                });
            }
        }
    });
    #if !OS_OBJECT_USE_OBJC
        dispatch_release(retrieval_thread);
    #endif
}

#pragma mark - Internal methods

- (void)retrieveAppNameDictionaryWithSuccess:(void (^)(NSDictionary *appNamesDictionary))successBlock
                                        failure:(void (^)(NSError *error))failureBlock {
    [self retrieveAppNamesDictionaryFromLocalWithSuccess:successBlock
                                                   failure:^(NSError *error) {
                                                       [self retrieveAppNamesDictionaryFromWebWithSuccess:successBlock
                                                                                                    failure:failureBlock];
                                                   }];
}

- (void)retrieveAppNamesDictionaryFromLocalWithSuccess:(void (^)(NSDictionary *appNameDictionary))successBlock
                                                 failure:(void (^)(NSError *error))failureBlock {
    dispatch_queue_t retrieval_thread = dispatch_queue_create(NULL, NULL);
    dispatch_async(retrieval_thread, ^{
        
        NSBundle *selfBundle = [NSBundle bundleForClass:[self class]];
        NSString *appNamesDictionaryPath = [selfBundle pathForResource:@"AppNames"
                                                                  ofType:@"json"];
        if (!appNamesDictionaryPath) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failureBlock) {
                    failureBlock(nil);
                }
            });
        } else {
            NSError *dataError;
            NSData *appNamesData = [NSData dataWithContentsOfFile:appNamesDictionaryPath
                                                            options:0
                                                              error:&dataError];
            if (dataError)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (failureBlock) {
                        failureBlock(dataError);
                    }
                });
            } else {
                NSError *jsonError;
                NSDictionary *appNamesDictionary = [NSJSONSerialization JSONObjectWithData:appNamesData
                                                                                     options:0
                                                                                       error:&jsonError];
                if (jsonError) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (failureBlock) {
                            failureBlock(jsonError);
                        }
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (successBlock) {
                            successBlock(appNamesDictionary);
                        }
                    });
                }
            }
        }
    });
    #if !OS_OBJECT_USE_OBJC
        dispatch_release(retrieval_thread);
    #endif
}

- (void)retrieveAppNamesDictionaryFromWebWithSuccess:(void (^)(NSDictionary *appNamesDictionary))successBlock
                                               failure:(void (^)(NSError *error))failureBlock {
    dispatch_queue_t retrieval_thread = dispatch_queue_create(NULL, NULL);
    dispatch_async(retrieval_thread, ^{
        
        NSURLResponse *response;
        NSError *connectionError;
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [[NSURLCache sharedURLCache] setMemoryCapacity:1024*1024*2];
        [request setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
        [request setURL:[NSURL URLWithString:@"https://file-path/AppNames.json"]];
        [request setTimeoutInterval:30.0f];
        NSData *result = [NSURLConnection sendSynchronousRequest:request
                                               returningResponse:&response
                                                           error:&connectionError];
        if (connectionError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failureBlock) {
                    failureBlock(connectionError);
                }
            });
        } else {
            NSError *jsonError;
            NSDictionary *appNamesDictionary = [NSJSONSerialization JSONObjectWithData:result
                                                                                 options:0
                                                                                   error:&jsonError];
            if (jsonError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (failureBlock) {
                        failureBlock(jsonError);
                    }
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (successBlock) {
                        successBlock(appNamesDictionary);
                    }
                });
            }
        }
    });
    #if !OS_OBJECT_USE_OBJC
        dispatch_release(retrieval_thread);
    #endif
}


#pragma mark - Helper methods

- (NSArray *)subarraysOfArray:(NSArray *)array withCount:(NSInteger)subarraySize {
    NSInteger j = 0;
    NSInteger itemsRemaining = [array count];
    NSMutableArray *arrayOfArrays = [[NSMutableArray alloc] init];
    while(j < [array count]) {
        NSRange range = NSMakeRange(j, MIN(subarraySize, itemsRemaining));
        NSArray *subarray = [array subarrayWithRange:range];
        [arrayOfArrays addObject:subarray];
        itemsRemaining -= range.length;
        j += range.length;
    }
    return arrayOfArrays;
}

#pragma mark - Property methods

- (NSString *)country {
    if (!_country) {
        _country = [(NSLocale *)[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    }
    return _country;
}

#pragma mark - Methods to get running processes

-(NSDictionary *)isRunningProcess:(NSString *)pName processes:(NSArray *)processes{
    for (NSDictionary *process in processes) {
        NSString *processName = [process objectForKey:@"ProcessName"];
        if ([[processName lowercaseString] isEqualToString:[pName lowercaseString]]) {
            return process;
        }
    }
    return NO;
    
}

- (NSArray *)runningProcesses {
    
    int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
    size_t miblen = 4;
    
    size_t size;
    int st = sysctl(mib, miblen, NULL, &size, NULL, 0);
    
    struct kinfo_proc * process = NULL;
    struct kinfo_proc * newprocess = NULL;
    
    do {
        
        size += size / 10;
        newprocess = realloc(process, size);
        
        if (!newprocess){
            
            if (process){
                free(process);
            }
            
            return nil;
        }
        
        process = newprocess;
        st = sysctl(mib, miblen, process, &size, NULL, 0);
        
    } while (st == -1 && errno == ENOMEM);
    
    if (st == 0){
        
        if (size % sizeof(struct kinfo_proc) == 0){
            int nprocess = size / sizeof(struct kinfo_proc);
            
            if (nprocess){
                
                NSMutableArray * array = [[NSMutableArray alloc] init];
                
                for (int i = nprocess - 1; i >= 0; i--){
                    
                    NSString * processID = [[NSString alloc] initWithFormat:@"%d", process[i].kp_proc.p_pid];
                    NSString * processName = [[NSString alloc] initWithFormat:@"%s", process[i].kp_proc.p_comm];
                    NSString *startTime =[[NSString alloc] initWithFormat:@"%ld ", process[i].kp_proc.p_un.__p_starttime.tv_sec];
                    NSDictionary * dict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:processID, processName,startTime, nil]
                                                                        forKeys:[NSArray arrayWithObjects:@"ProcessID", @"ProcessName",@"appStartTime", nil]];
                    [array addObject:dict];
                    
                }
                
                free(process);
                return array ;
            }
        }
    }
    
    return nil;
}
@end
