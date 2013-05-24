//
//  CetasTransactionItem.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//


/*!
 * @brief : This class encapsulates the details of the item purchased in the ecommerce transactions.
 *          It provides a set of methods that allow developers to create ecommerce transactions items.
 *
 */
#import <Foundation/Foundation.h>

@interface CetasTransactionItem : NSObject


// Holds reference to the sku number.
@property (strong) NSString *skuNo;

// Holds reference to the product name.
@property (strong) NSString *productName;

// Holds reference to the category.
@property (strong) NSString *category;

// Holds the unit price.
@property double unitPrice;

// Holds the quantity of the item.
@property long quantity;


/*!
 *
 * @brief : This method creates an e-commerce transaction item.
 *
 * @param : skuNumber, the sku number, must not be 'nil'.
 * @param : productName, the product name, must not be 'nil'.
 * @param : categoryName, the category name, may be 'nil'.
 * @param : unitPrice, the unit price, as a double.
 * @param : quantity, item quantity, as a long.
 *
 * @code  
 Example :
 
 [CetasTransactionItem itemWithSkuNumber:@"SKU123" productName:@"iPad" category:@"Electronics" unitPrice:500.3 quantity:1];
 
 
 
 */
+(CetasTransactionItem *)itemWithSkuNumber:(NSString *)skuNo
                             productName:(NSString *)productName
                                category:(NSString *)category
                               unitPrice:(double)unitPrice
                                quantity:(long)quantity;


@end
