//
//  TableViewController.h
//  TableViewControllerExample
//
//  Created by Chetan Sanghi on 27/10/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "ShoppingItem.h"


@interface TableViewController : UITableViewController <SaveNewInfoDelegate>
{
    NSMutableArray *allAboutDrinks;
    
    NSMutableArray *fetchedFromURL;
    //DetailViewController *dvc;
    
    NSMutableArray *items;
    
}

@property (strong) NSMutableArray *items;
@property (strong) NSMutableArray *allAboutDrinks;
@property (strong) NSMutableArray *fetchedFromURL;
//@property (strong) DetailViewController *dvc;

//@property(strong) NSMutableDictionary *drinksAndInfo;

@end
