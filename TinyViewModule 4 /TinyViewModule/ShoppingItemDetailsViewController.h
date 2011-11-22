//
//  ShoppingItemDetailsViewController.h
//  TinyViewModule
//
//  Created by Vipin Joshi on 21/11/11.
//  Copyright (c) 2011 sanghichetan@yahoo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingItem.h"

@interface ShoppingItemDetailsViewController : UIViewController
{
    ShoppingItem *shoppingItem;
    IBOutlet UIImageView *itemImageView;
    IBOutlet UIScrollView *scrollView;
    // UILabel *label;
    
}

@property (retain) IBOutlet UIScrollView *scrollView;
@property (strong) ShoppingItem *shoppingItem;
@property (retain) IBOutlet UIImageView *itemImageView;
//@property (retain) IBOutlet UILabel *label;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andItem:(ShoppingItem *)item;

@end