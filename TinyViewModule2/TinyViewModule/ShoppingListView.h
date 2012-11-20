//
//  ShoppingListView.h
//  TinyViewModule
//
//  Created by Chetan Sanghi on 16/11/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconDownloader.h"

@interface ShoppingListView : UIView <IconDownloaderDelegate>
{
    int shoppingItemCount; // this is to differentiate between odd and even
    int shoppingItemRowCount; // this is set offset for the new row
    UIScrollView *scrollView;
    NSMutableArray *iconDownloaderArray;   
    
    NSMutableArray *arrayOfItemViews;
}

-(void)createViewWithData:(NSMutableArray *)shoppingItems;

@property int shoppingItemCount;
@property int shoppingItemRowCount;
@property (retain) UIScrollView *scrollView;
@property (strong) NSMutableArray *iconDowloaderArray;
@property (strong) NSMutableArray *arrayOfItemViews;

@end
