//
//  ShoppingListController.h
//  TableViewControllerExample
//
//  Created by Chetan Sanghi on 31/10/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingItem.h"

@interface ShoppingListController : UIViewController
{
    
    UILabel *itemName;
    UILabel *itemId;
    UILabel *noOfItemsSelected;
    
    ShoppingItem *selectedItem;
    
    
    
}
@property (retain) IBOutlet UILabel *itemName;
@property (retain) IBOutlet UILabel *itemId;
@property (retain) IBOutlet UILabel *noOfItemsSelected;

@property (strong) ShoppingItem *selectedItem;

@end
