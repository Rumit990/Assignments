//
//  RunningApps.h
//  RunningApps
//
//  Copyright (c) 2013 Tinyview Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDictKeyAppId @"appId"
#define kDictKeyStartTime @"appStartTime"
#define kDictKeyProcessName @"ProcessName"

/**  
 *Requirements:* iOS base SDK 5.0+, Internet connectivity
 */
@interface RunningApps : NSObject

/**---------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------
 */

/** The two-letter country code for the store you want to search. The search uses the default store front for the specified country. Default is [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode].
 
 See http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2 for a list of ISO Country Codes.
 
    //To determine device-specific country codes, use:
    NSString *countryCode = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
 
 */
@property (nonatomic, copy) NSString *country;


/**---------------------------------------------------------------------------------------
 * @name Detection Methods
 * ---------------------------------------------------------------------------------------
 */

/** Starts an appId detection process.
 
    RunningApps *detectionObject = [[RunningApps alloc] init];
    [detectionObject detectAppIdsWithIncremental:^(NSArray *appIds) {
        NSLog(@"Incremental appIds.count: %i", appIds.count);
    } withSuccess:^(NSArray *appIds) {
        NSLog(@"Successful appIds.count: %i", appIds.count);
    } withFailure:^(NSError *error) {
        NSLog(@"Failure: %@", error.localizedDescription);
    }];
 
 @param incrementalBlock The block invoked after a chunk of appIds are detected.
 @param successBlock The block invoked after all possible appIds are detected.
 @param failureBlock The block to invoke if the access operation fails—for example, if there is a network error.
 @see detectAppDictionariesWithIncremental:withSuccess:withFailure:
 */
- (void)detectAppIdsWithIncremental:(void (^)(NSArray *appIds))incrementalBlock
                        withSuccess:(void (^)(NSArray *appIds))successBlock
                        withFailure:(void (^)(NSError *error))failureBlock;

/** Starts an appDictionary detection process.
 
    RunningApps *detectionObject = [[RunningApps alloc] init];
    [detectionObject detectAppDictionariesWithIncremental:^(NSArray *appDictionaries) {
        NSLog(@"Incremental appDictionaries.count: %i", appDictionaries.count);
    } withSuccess:^(NSArray *appDictionaries) {
        NSLog(@"Successful appDictionaries.count: %i", appDictionaries.count);
    } withFailure:^(NSError *error) {
        NSLog(@"Failure: %@", error.localizedDescription);
    }];
 
 @param incrementalBlock The block invoked after a chunk of appDictionaries are detected.
 @param successBlock The block invoked after all possible appDictionaries are detected.
 @param failureBlock The block to invoke if the access operation fails—for example, if there is a network error.
 @see detectAppIdsWithIncremental:withSuccess:withFailure:
 */
- (void)detectAppDictionariesWithIncremental:(void (^)(NSArray *appDictionaries))incrementalBlock
                                 withSuccess:(void (^)(NSArray *appDictionaries))successBlock
                                 withFailure:(void (^)(NSError *error))failureBlock;


/**---------------------------------------------------------------------------------------
 * @name Informational Methods
 * ---------------------------------------------------------------------------------------
 */

/** Returns the associated App Store information for the desired apps.
 
 This is used internally to convert appIds to appDictionaries.
 
 Data returned is from the iTunes Search API. (e.g: http://itunes.apple.com/lookup?id=284882215 )
 
 @param appIds An array of appIds you want to search for on the iTunes App Store.
 @param successBlock The block invoked after the search successfully returns.
 @param failureBlock The block to invoke if the search operation fails—for example, if there is a network error.
 */
- (void)retrieveAppDictionariesForAppIds:(NSArray *)appIds
                             withSuccess:(void (^)(NSArray *appDictionaries))successBlock
                             withFailure:(void (^)(NSError *error))failureBlock;

@end
