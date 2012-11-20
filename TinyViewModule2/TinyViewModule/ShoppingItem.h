//
//  ShoppingItem.h
//  TinyViewModule
//
//  Created by Chetan Sanghi on 16/11/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingItem : NSObject
{
    int itemIndex;
    NSURL * imageURL;
    
}
@property (strong) NSURL * imageURL;

@property int itemIndex;

-(void)createShoppingItem:(NSDictionary *)shoppingItemDictionary;


@end
