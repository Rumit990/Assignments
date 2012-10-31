//
//  ShoppingItem.h
//  TableViewControllerExample
//
//  Created by Chetan Sanghi on 31/10/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingItem : NSObject

{
    NSString *itemName;
    NSString *itemId;
    NSString *itemCount;
}

@property (strong) NSString *itemName;
@property (strong) NSString *itemId;
@property (strong) NSString *itemCount;

@end
