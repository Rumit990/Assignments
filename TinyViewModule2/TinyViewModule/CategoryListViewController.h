//
//  CategoryListViewController.h
//  TinyViewModule
//
//  Created by Chetan Sanghi on 18/11/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategorySetterDelegate;

@interface CategoryListViewController : UITableViewController <UITableViewDelegate>
{
    NSMutableArray *categoryList;
    id <CategorySetterDelegate> categorySetterDelegate;
}

@property (strong) NSMutableArray *categoryList;
@property (strong) id <CategorySetterDelegate> categorySetterDelegate;

@end

@protocol CategorySetterDelegate

-(void)setCategoryForFilter:(NSString *)selectedCategory;

@end