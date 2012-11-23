//
//  Common.m
//  TinyViewModule
//
//  Created by Vipin Joshi on 22/11/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import "Common.h"
#import <QuartzCore/QuartzCore.h>

@implementation Common


+(UILabel *)createLabelWithTitle:(NSString *)title
{
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    
    titlelabel.textAlignment = UITextAlignmentCenter;
    titlelabel.text = title;
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.font = [UIFont systemFontOfSize:13.0];
    titlelabel.adjustsFontSizeToFitWidth = YES;
    return titlelabel;
}


+(UIButton *)createPortletButtonWithTitle:(NSString *)title
{
    UIFont *buttonFont = [UIFont fontWithName:@"Noteworthy-Bold" size:17.0];
    UIColor *buttonColorDefault = [UIColor colorWithRed:90.0f/255.0f green:90.0f/255.0f blue:90.0f/255.0f alpha:1.0];
    UIColor *buttonColorHighlight = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:buttonFont];
    [button setTitleColor:buttonColorDefault forState:UIControlStateNormal];
    [button setTitleColor:buttonColorHighlight forState:UIControlStateHighlighted];
    button.layer.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0].CGColor;
    
    [button.titleLabel setFont:buttonFont];
    [button setTitleColor:buttonColorDefault forState:UIControlStateNormal];
    [button setTitleColor:buttonColorHighlight forState:UIControlStateHighlighted];
    button.layer.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0].CGColor;
    
    return button;
    
}

+(CGFloat)tableViewFontSize
{
    return 14;
}

+(CGFloat)tableViewCellHeight
{
    return 35;

}

@end
