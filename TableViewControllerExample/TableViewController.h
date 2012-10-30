//
//  TableViewController.h
//  TableViewControllerExample
//
//  Created by Chetan Sanghi on 27/10/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"



@interface TableViewController : UITableViewController <SaveNewInfoDelegate>
{
    NSMutableArray *allAboutDrinks;
    //DetailViewController *dvc;
    
}

@property (strong) NSMutableArray *allAboutDrinks;
//@property (strong) DetailViewController *dvc;

//@property(strong) NSMutableDictionary *drinksAndInfo;

@end
