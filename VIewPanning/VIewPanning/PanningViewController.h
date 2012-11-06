//
//  PanningViewController.h
//  VIewPanning
//
//  Created by Chetan Sanghi on 06/11/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiggerView.h"


@interface PanningViewController : UIViewController
{
    IBOutlet BiggerView *bigView;
        
    IBOutlet UILabel * bigViewLabel;
    IBOutlet UIButton *mainButton;

    UIButton *duplicatePanButton;
    CGRect baseFrame;
    CGRect duplicateFrame; // temporary check
}

@property (retain) UILabel *bigViewLabel;

@property (strong) IBOutlet BiggerView *bigView;
@property (retain) IBOutlet UIButton *mainButton;
@property (strong) UIButton *duplicatePanButton;
@property CGRect baseFrame;
@property CGRect duplicateFrame;

@end
