//
//  ShoppingItemPortletViewController.h
//  TinyViewModule
//
//  Created by Vipin Joshi on 21/11/11.
//  Copyright (c) 2011 sanghichetan@yahoo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingItem.h"
#import "IconDownloader.h"

@interface ShoppingItemPortletViewController : UIViewController <IconDownloaderDelegate>
{
    ShoppingItem *shoppingItem;
    IconDownloader *iconDownloader;
    UIImageView *shoppingItemImageView;
    UIButton *shortlistButton;
    UIButton *buyButton;
}



@property (strong) ShoppingItem *shoppingItem;
@property (strong) IconDownloader *iconDownloader;
@property (retain) UIImageView *shoppingItemImageView;
@property (retain) UIButton *shortlistButton;
@property (retain) UIButton *buyButton;

- initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andItem:(ShoppingItem *)item;


@end
