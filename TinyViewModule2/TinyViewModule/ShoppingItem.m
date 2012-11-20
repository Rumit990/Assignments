//
//  ShoppingItem.m
//  TinyViewModule
//
//  Created by Chetan Sanghi on 16/11/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import "ShoppingItem.h"

@implementation ShoppingItem


@synthesize imageURL;
@synthesize itemIndex;

-(void)createShoppingItem:(NSDictionary *)shoppingItemDictionary
{
    
    NSLog(@"Shopping item, the dictionary item received is %@", [shoppingItemDictionary objectForKey:@"imgUrl"]);
    
    self.imageURL = [NSURL URLWithString:[shoppingItemDictionary objectForKey:@"imgUrl"]];

}

@end
