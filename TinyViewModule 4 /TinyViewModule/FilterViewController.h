//
//  FilterViewController.h
//  TinyViewModule
//
//  Created by Chetan Sanghi on 17/11/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryListViewController.h"

@protocol ApplyFilterDelegate 

-(void)selectedShoppingItemsFilter:(NSString *)selectedFilter;

@end

@interface FilterViewController : UITableViewController <CategorySetterDelegate>
{
    id <ApplyFilterDelegate> applyFilterDelegate;
    
    UIView *backgrroundView;
    
    NSString *categoryFilter;
}

@property (strong) id <ApplyFilterDelegate> applyFilterDelegate;
@property (strong) NSString *categoryFilter;
@property (retain) IBOutlet UIView *backgroundView;

@end
