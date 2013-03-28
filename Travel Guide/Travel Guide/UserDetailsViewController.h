//
//  UserDetailsViewController.h
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//


#import <UIKit/UIKit.h>


@protocol UserCheckInDelegate <NSObject>

-(void)checkInWithUserName:(NSString *)name userId:(NSString *)userID userAge:(NSString *)userAge;

@end


@interface UserDetailsViewController : UIViewController <UITextFieldDelegate>


@property (strong) IBOutlet UITextField *userNameField;
@property (strong) IBOutlet UITextField *userIDField;
@property (strong) IBOutlet UITextField *userAgeField;
@property (strong) IBOutlet UILabel *invalidIDMessage;
@property (strong) IBOutlet UIScrollView *scrollView;


@property (unsafe_unretained) id<UserCheckInDelegate> checkInDelegate;

-()initWithDelegate:(id)delegate;

-(IBAction)checkInButtonPressed:(id)sender;

@end
