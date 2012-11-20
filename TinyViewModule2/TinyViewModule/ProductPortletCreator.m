//
//  ProductPortletCreator.m
//  TinyViewModule
//
//  Created by Chetan Sanghi on 20/11/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import "ProductPortletCreator.h"
#import <QuartzCore/QuartzCore.h>

@implementation ProductPortletCreator

@synthesize shortlistButton;
@synthesize shoppingItemImageView;
@synthesize buyButton;
@synthesize itemIndex;

-(void)createUI
{
    //UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 190)];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.borderColor = [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:1.0].CGColor;
    
    self.layer.borderWidth = 1.0f;
    
    
    CGRect imageViewFrame = CGRectMake(5, 5, 140, 140);
    
     self.shoppingItemImageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    
    [self addSubview:self.shoppingItemImageView];
    
    
    
    UIFont *buttonFont = [UIFont fontWithName:@"Noteworthy-Bold" size:17.0];
    UIColor *buttonColorDefault = [UIColor colorWithRed:90.0f/255.0f green:90.0f/255.0f blue:90.0f/255.0f alpha:1.0];
    UIColor *buttonColorHighlight = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0];
    
    CGRect shortlistButtonFrame = CGRectMake(1, 160, 73.5, 30);
    CGRect buyButtonFrame = CGRectMake(75.5, 160, 73.5, 30);
    
    
    self.shortlistButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.shortlistButton setTitle:@"Shortlist" forState:UIControlStateNormal];
    [self.shortlistButton.titleLabel setFont:buttonFont];
    [self.shortlistButton setTitleColor:buttonColorDefault forState:UIControlStateNormal];
    [self.shortlistButton setTitleColor:buttonColorHighlight forState:UIControlStateHighlighted];
    self.shortlistButton.layer.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0].CGColor;
    
    [self.buyButton setTitle:@"Buy" forState:UIControlStateNormal];
    [self.buyButton.titleLabel setFont:buttonFont];
    [self.buyButton setTitleColor:buttonColorDefault forState:UIControlStateNormal];
    [self.buyButton setTitleColor:buttonColorHighlight forState:UIControlStateHighlighted];
    self.buyButton.layer.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0].CGColor;
    
    
    self.shortlistButton.frame = shortlistButtonFrame;
    self.buyButton.frame = buyButtonFrame;
    
    [self addSubview:self.shortlistButton];
    [self addSubview:self.buyButton];
    
    
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        
        [self createUI];
        
        // Initialization code
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame andIndex:(int)index
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.itemIndex = index;
        
        NSLog(@"index for product ---------------------->>> %d",self.itemIndex);
        
        [self createUI];
        
        // Initialization code
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
