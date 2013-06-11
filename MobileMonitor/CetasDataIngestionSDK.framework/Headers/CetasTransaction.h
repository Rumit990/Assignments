//
//  CetasTransaction.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//



/*!
 * @brief : This class encapsulates ecommerce transaction data.
 *
 *  It provides a set of methods that allow developers to create ecommerce transactions and add items to it.
 *
 */

#import <Foundation/Foundation.h>
#import "CetasTransactionItem.h"

@interface CetasTransaction : NSObject

// Holds reference to the order ID.
@property (strong) NSString *orderId;

// Holds reference to the store name.
@property (strong) NSString *storeName;

// Holds the total amount.
@property double totalAmount;

// Holds the tax.
@property double tax;

// Holds the shipping charges.
@property double shipping;

// Holds reference to the payment gateway.
@property (strong) NSString *paymentGateway;

// Holds reference to the city name.
@property (strong) NSString *city;

// Holds reference to the state name.
@property (strong) NSString *state;

// Holds reference to the country name.
@property (strong) NSString *country;

// Holds reference to the array of items (instances of CetasTransactionItem) involved in the transaction.
@property (strong) NSMutableArray *items;


/*!
 *
 * @brief : This method initiates and returns a reference to an e-commerce 
 *          transaction instance.
 * @param :orderId, the order Id, must not be 'nil'.
 * @param :storeName, the store name, may be 'nil'.
 * @param :totalAmount, the total amount, as a double.
 * @param :tax, the tax, as a double.
 * @param :shipping, the shipping charges, as a double.
 * @param :paymentGateway, the payment gateway, eg : paypal, may be 'nil'.
 * @param :city, the city, may be 'nil'.
 * @param :state , the state, may be 'nil'.
 * @param :country, the country, may be 'nil'
 
 * @code
 
 *  Example :
 
    CetasTransaction *ecomTrans = [CetasTransaction transactionWithOrderId:@"order123" storeName:@"walmart" totalAmount:200.22 tax:10.25 shipping:20.5 paymentGateway:@"paypal" city:@"Palo Alto" state:@"CA" country:@"United States"];
 
 
 */
+(CetasTransaction *)transactionWithOrderId:(NSString *)orderId
                                  storeName:(NSString *)storeName
                                totalAmount:(double)totalAmount
                                        tax:(double)tax
                                   shipping:(double)shipping
                             paymentGateway:(NSString *)paymentGateway
                                       city:(NSString *)city
                                      state:(NSString *)state
                                    country:(NSString *)country;

/*!
 *
 * @brief : This method creates an e-commerce transaction item and adds it to the
 *          array of items invloved in the e-commerce transaction.
 *
 * @param : skuNumber, the sku number, must not be 'nil'.
 * @param : productName, the product name, must not be 'nil'.
 * @param : categoryName, the category name, may be 'nil'.
 * @param : unitPrice, the unit price, as a double.
 * @param : quantity, item quantity, as a long.
 *
 * @code  :
    Example :
 
    CetasTransaction *ecomTrans = [CetasTransaction transactionWithOrderId:@"order123" storeName:@"walmart" totalAmount:200.22 tax:10.25 shipping:20.5 paymentGateway:@"paypal" city:@"Palo Alto" state:@"CA" country:@"United States"];
    [ecomTrans addItemWithSkuNumber:@"SKU123" productName:@"iPad" categoryName:@"Electronics" unitPrice:500.3 quantity:1];

 *
 */
-(void)addItemWithSkuNumber:(NSString *)skuNumber
              productName:(NSString *)productName
             categoryName:(NSString *)categoryName
                unitPrice:(double)unitPrice
                 quantity:(long)quantity;


/*!
 *
 * @brief : This method accepts an e-commerce transaction item and adds it the array     
 *          of items invloved in the gaming transaction.
 *
 * @param : item, reference to the e-commerce transaction item.
 */
-(void)addItem:(CetasTransactionItem *)item;


@end
