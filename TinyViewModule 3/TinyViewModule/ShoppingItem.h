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
    UIImage *itemImage;
    int itemIndex;
    NSURL * imageURL;
    
}
@property (strong) NSURL *imageURL;
@property (strong) UIImage *itemImage; 
@property int itemIndex;

-(void)initWithDictionary:(NSDictionary *)shoppingItemDictionary andIndex:(int)index;



@end
