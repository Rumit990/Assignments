//
//  CetasGameTransactionItem.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//

/*!
 * @brief : This class encapsulates the details of the virtual goods purchased in the gaming transactions.
 *          It provides a set of methods that allow developers to create gaming transaction items.
 *
 */
#import <Foundation/Foundation.h>

@interface CetasGameTransactionItem : NSObject



// Holds reference to the item name.
@property (strong) NSString *itemName;

// Holds the item price.
@property double itemPrice;

// Holds the item quantity.
@property long itemQuantity;


/*!
 *
 * @brief : This method creates a gaming transaction item.
 *
 * @param : itemName, the item name, must not be 'nil'.
 * @param : itemPrice , the item price, as a double.
 * @param : itemQuantity, the item quantity, as a long.
 * @code :
    Example :
    CetasGameTransaction *transaction = [CetasGameTransaction gameTransactionWithGameId:@"00002" transactionId:@"order_001" totalAmount:18.89 gameVersion:@"2.1" gameLevel:1];
 
    [transaction addItemWithItemName:@"magic_ball" itemPrice:9.99 itemQuantity:2];
 
 [CetasGameTransactionItem itemWithItemName:@"magic_ball" itemPrice:9.99 itemQuantity:2];
 *
 */
+(CetasGameTransactionItem *)itemWithItemName:(NSString *)itemName
                                  itemPrice:(double)itemPrice
                               itemQuantity:(long)itemQuantity;

@end
