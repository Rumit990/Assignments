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
    UIScrollView *scrollView;
    NSMutableArray *iconDownloaderArray;   
    
    NSMutableArray *arrayOfItemViews;
}

-(void)createViewWithData:(NSMutableArray *)shoppingItems;

@property (strong) UIScrollView *scrollView;
@property (strong) NSMutableArray *iconDowloaderArray;
@property (strong) NSMutableArray *arrayOfItemViews;

@end
