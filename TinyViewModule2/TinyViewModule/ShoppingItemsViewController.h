//
//  ShoppingItemsViewController.h
//  TinyViewModule
//
//  Created by Chetan Sanghi on 16/11/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingItem.h"
#import "ShoppingListView.h"
#import "FilterViewController.h"

@interface ShoppingItemsViewController : UIViewController <ApplyFilterDelegate>
{
        
    ShoppingListView * shoppingItemsView;
    
    NSMutableArray *shoppingItems;
    
    NSString *shoppingItemsFilter;
}

@property (strong) NSMutableArray *shoppingItems;
@property (retain) IBOutlet ShoppingListView *shoppingItemsView;
@property (strong) NSString *shoppingItemsFilter;

@end

