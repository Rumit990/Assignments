//
//  ProductPortletCreator.h
//  TinyViewModule
//
//  Created by Chetan Sanghi on 20/11/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingItem.h"

@class ProductPortletCreator;

@protocol ProductPortletCreatorDelegate 

-(void)shortlistButtonHandler:(ShoppingItem *)item;
-(void)buyButtonHandler:(ShoppingItem *)item;

@end

@interface ProductPortletCreator : UIView
{
    int itemIndex;
    ShoppingItem *shoppingItem;
    UIImageView *shoppingItemImageView;
    UIButton *shortlistButton;
    UIButton *buyButton;
    id <ProductPortletCreatorDelegate> productPortletCreatorDelegate;
    
}

- (id)initWithFrame:(CGRect)frame andIndex:(int)index;

@property (strong) ShoppingItem *shoppingItem;
@property (strong) id <ProductPortletCreatorDelegate> productPortletCreatorDelegate;
@property int itemIndex;
@property (retain) UIImageView *shoppingItemImageView;
@property (retain) UIButton *shortlistButton;
@property (retain) UIButton *buyButton;

@end
