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
    UIImage *itemImageIcon;
    int itemIndex;
    NSURL * imageURL;
    
}
@property (strong) NSURL *imageURL;
@property (strong) UIImage *itemImageIcon; 
@property int itemIndex;
@property (strong) UIImage *itemImage;

-(void)initWithDictionary:(NSDictionary *)shoppingItemDictionary andIndex:(int)index;



@end
