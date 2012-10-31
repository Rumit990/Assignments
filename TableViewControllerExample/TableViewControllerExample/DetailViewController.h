//
//  DetailViewController.h
//  TableViewControllerExample
//
//  Created by Chetan Sanghi on 29/10/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@protocol SaveNewInfoDelegate

-(void)addChanges:(DetailViewController *)requester;
-(void)discardChanges:(DetailViewController *)requester;
-(void)updateChanges:(DetailViewController *)requester forIndexPath:(NSIndexPath *)indexPath;

@end


@interface DetailViewController : UIViewController
{
    NSString *selectedDrink;
    NSString *selectedDrinkIngredients;
    NSString *selectedDrinkDirections;
    NSMutableDictionary *selectedDrinkDetails;
    NSIndexPath *selectedIndexPath;
    
    UITextView *nameOfDrink;
    UITextView *directions;
    UITextView *ingredients;
    UIScrollView *scrView;
    
    BOOL keyboardVisiblityFlag;
    
   id <SaveNewInfoDelegate> delegate;
    
    

}

@property (retain) IBOutlet UITextView *nameOfDrink;
@property (retain) IBOutlet UITextView *ingredients;
@property (retain) IBOutlet UITextView *directions;
@property (retain) IBOutlet UIScrollView *scrView;

@property (strong) id <SaveNewInfoDelegate> delegate;

@property BOOL keyboardVisibilityFlag;
@property (strong) NSString *selectedDrink;
@property (strong) NSString *selectedDrinkIngredients;
@property (strong) NSString *selectedDrinkDirections;
@property (strong) NSMutableDictionary *selectedDrinkDetails;
@property (strong) NSIndexPath *selectedIndexPath;

@end
