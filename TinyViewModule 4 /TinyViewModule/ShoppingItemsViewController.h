//
//  ShoppingItemsViewController.h
//  TinyViewModule
//
//  Created by Chetan Sanghi on 16/11/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingItem.h"
#import "FilterViewController.h"
#import "ProductPortletCreator.h"
#import "IconDownloader.h"

@interface ShoppingItemsViewController : UIViewController <ApplyFilterDelegate>
{
        
   // ShoppingListView * shoppingItemsView;
    
    IBOutlet UIScrollView *scrollView;
    
    NSMutableArray *shoppingItems;
    
    NSString *shoppingItemsFilter;
    
}


@property (strong) NSMutableArray *shoppingItems;
@property (strong) NSString *shoppingItemsFilter;
@property (retain) IBOutlet UIScrollView *scrollView;

@end

