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
@synthesize itemImage;

-(void)initWithDictionary:(NSDictionary *)shoppingItemDictionary andIndex:(int)index
{
    
    self.itemIndex = index;
    self.imageURL = [NSURL URLWithString:[shoppingItemDictionary objectForKey:@"imgUrl"]];
    
    
}

@end
