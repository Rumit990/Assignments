//
//  ProductPortletCreator.h
//  TinyViewModule
//
//  Created by Chetan Sanghi on 20/11/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ProductPortletCreator : UIView
{
    int itemIndex;
    
    UIImageView *shoppingItemImageView;
    UIButton *shortlistButton;
    UIButton *buyButton;
    
}

- (id)initWithFrame:(CGRect)frame andIndex:(int)index;

@property int itemIndex;
@property (retain) UIImageView *shoppingItemImageView;
@property (retain) UIButton *shortlistButton;
@property (retain) UIButton *buyButton;

@end
