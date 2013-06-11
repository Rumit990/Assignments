//
//  CetasGameTransaction.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

/*!
 * @brief : This class encapsulates gaming transaction data.
 *
 *  It provides a set of methods that allow developers to create gaming transactions and add items to it.
 *
 */
#import <Foundation/Foundation.h>
#import "CetasGameTransactionItem.h"

@interface CetasGameTransaction : NSObject

// Holds reference to the game ID.
@property (strong) NSString *gameId;

// Holds reference to the transaction ID.
@property (strong) NSString *transactionId;

// Holds the total amount.
@property double totalAmount;

// Holds reference to the game version.
@property (strong) NSString *gameVersion;

// Holds the game level.
@property int gameLevel;


// Holds reference to the array of items (instances of CetasGameTransactionItem) involved in the transaction.
@property (strong) NSMutableArray *items;

/*!
 *
 * @brief : This method initiates and returns reference to a gaming transaction 
 *          instance.
 *
 * @param : gameId, the game id, must not be 'nil'.
 * @param : transactionId, the transaction id, must not be 'nil'.
 * @param : total amount, as a double.
 * @param : game version, the game version, may be 'nil'.
 * @param : game level, the game level, as an NSInteger.
 * @code : 
 *  Example :
 
 CetasGameTransaction *transaction = [CetasGameTransaction gameTransactionWithGameId:@"00002" transactionId:@"order_001" totalAmount:18.89 gameVersion:@"2.1" gameLevel:1];
 
 *
 
 
 */
+(CetasGameTransaction *)gameTransactionWithGameId:(NSString *)gameId
                                     transactionId:(NSString *)transactionId
                                       totalAmount:(double)totalAmount
                                       gameVersion:(NSString *)gameVersion
                                         gameLevel:(NSInteger)gameLevel;


/*!
 *
 * @brief : This method creates a gaming transaction item and adds it the array of 
 *          items invloved in the gaming transaction.
 *
 * @param : itemName, the item name, must not be 'nil'.
 * @param : itemPrice , the item price, as a double.
 * @param : itemQuantity, the item quantity, as a long.
 * @code : 
    Example :
 CetasGameTransaction *transaction = [CetasGameTransaction gameTransactionWithGameId:@"00002" transactionId:@"order_001" totalAmount:18.89 gameVersion:@"2.1" gameLevel:1];
 
 [transaction addItemWithItemName:@"magic_ball" itemPrice:9.99 itemQuantity:2];
 *
 */
-(void)addItemWithItemName:(NSString *)itemName
               itemPrice:(double)itemPrice
            itemQuantity:(long)itemQuantity;


/*!
 *
 * @brief : This method accepts a gaming transaction item and adds it the array of
 *          items invloved in the gaming transaction.
 *
 * @param : item, reference to the gaming transaction item.
 *
 */
-(void)addItem:(CetasGameTransactionItem *)item;


@end
