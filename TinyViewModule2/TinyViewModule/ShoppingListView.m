//
//  ShoppingListView.m
//  TinyViewModule
//
//  Created by Chetan Sanghi on 16/11/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//


#import "IconDownloader.h"
#import "ShoppingListView.h"
#import "ShoppingItem.h"
#import <QuartzCore/QuartzCore.h>


@implementation ShoppingListView

@synthesize scrollView;
@synthesize iconDowloaderArray;
@synthesize shoppingItemRowCount;
@synthesize shoppingItemCount;


-(NSMutableArray *)iconDownloaderArray
{
    if(!iconDownloaderArray)
    {
        iconDownloaderArray = [[NSMutableArray alloc] init];
    }
    return iconDownloaderArray;
}

-(void)setIconDownloaderArray:(NSMutableArray *)receivedArray
{
    iconDownloaderArray = receivedArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGRect frame = [[UIScreen mainScreen] applicationFrame];
       
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        
        UIEdgeInsets scrollViewInsets = UIEdgeInsetsMake(40, 0, 40, 0);
        
        self.scrollView.contentInset = scrollViewInsets;
        
    }
    return self;
}

//-(void)awakeFromNib
//{
//    CGRect frame = [[UIScreen mainScreen] applicationFrame];
//    
//    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
//    
//    UIEdgeInsets scrollViewInsets = UIEdgeInsetsMake(20, 0, 40, 0);
//    
//    self.scrollView.contentInset = scrollViewInsets;
//
//    
//
//}

-(UIView *)createShoppingItemWithImage:(UIImage *)itemImage
{
    UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 190)];
    
    itemView.backgroundColor = [UIColor whiteColor];
    
    itemView.layer.borderColor = [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:1.0].CGColor;
    
    itemView.layer.borderWidth = 1.0f;
    
    CGRect imageViewFrame = CGRectMake(5, 5, 140, 140);
    
    UIImageView *itemImageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    
    itemImageView.image = itemImage;
    
    [itemView addSubview:itemImageView];
    
    
    
    UIFont *buttonFont = [UIFont fontWithName:@"Noteworthy-Bold" size:17.0];
    UIColor *buttonColorDefault = [UIColor colorWithRed:90.0f/255.0f green:90.0f/255.0f blue:90.0f/255.0f alpha:1.0];
    UIColor *buttonColorHighlight = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0];
    
    CGRect shortlistButtonFrame = CGRectMake(1, 160, 73.5, 30);
    CGRect buyButtonFrame = CGRectMake(75.5, 160, 73.5, 30);
    
    
    UIButton *shortlistButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [shortlistButton setTitle:@"Shortlist" forState:UIControlStateNormal];
    [shortlistButton.titleLabel setFont:buttonFont];
    [shortlistButton setTitleColor:buttonColorDefault forState:UIControlStateNormal];
    [shortlistButton setTitleColor:buttonColorHighlight forState:UIControlStateHighlighted];
    shortlistButton.layer.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0].CGColor;
    
    [buyButton setTitle:@"Buy" forState:UIControlStateNormal];
    [buyButton.titleLabel setFont:buttonFont];
    [buyButton setTitleColor:buttonColorDefault forState:UIControlStateNormal];
    [buyButton setTitleColor:buttonColorHighlight forState:UIControlStateHighlighted];
    buyButton.layer.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0].CGColor;
    
    
    shortlistButton.frame = shortlistButtonFrame;
    buyButton.frame = buyButtonFrame;
    
    [itemView addSubview:shortlistButton];
    [itemView addSubview:buyButton];
    
    return itemView;
}

-(void)appImageDidLoad:(NSIndexPath *)indexPath iconDownloader:(IconDownloader *)paramIconDownloader
{
    
    NSLog(@"!!!!!!!!!!!! Koi toh image download hui !!!!!!!!!!!!!");

    CGFloat offset = 230;
    
    CGFloat yIndex = offset * self.shoppingItemRowCount;
    
    CGRect oddNumberedItem = CGRectMake(6, 10 + yIndex, 150, 190);
    CGRect evenNumberedItem = CGRectMake(164, 10 + yIndex, 150, 190);
    
    
    if(self.shoppingItemCount%2 == 0) // initialized to zero automatically
    {
        
        UIView *itemView = [self createShoppingItemWithImage:paramIconDownloader.imageDownloaded];
        
        itemView.frame = oddNumberedItem;
        
        [self.scrollView addSubview:itemView];
        
    }
    
    else
    {
        
        UIView *itemView = [self createShoppingItemWithImage:paramIconDownloader.imageDownloaded];
        itemView.frame = evenNumberedItem;
        
        [self.scrollView addSubview:itemView];
        
        self.shoppingItemRowCount++; // each time an even row item is drawn, the row count is set in order to change the frames for the next row
    
    }
    
    self.shoppingItemCount++; // count is kept in order to differentiate between odd and even items
    
    
}

-(void)createViewWithData:(NSMutableArray *)shoppingItems
{
     CGFloat offset = 230;
    
    CGFloat scrollViewContentSize = offset * ((shoppingItems.count + 1) / 2);
    
    self.scrollView.contentSize = CGSizeMake(320.0, scrollViewContentSize);
    
    [self addSubview:self.scrollView];

    
    // ADDED TO THE FRAME EACH TIME A CHANGE OF ROW IS REQUIRED
    
    
    for(ShoppingItem *item in shoppingItems)
    {

        IconDownloader *downloader = [[IconDownloader alloc] init];
        
        downloader.imageURL = item.imageURL;
        
        downloader.delegate = self;
        
        [downloader startDownload];
        
        [self.iconDowloaderArray addObject:downloader];
    
    }
       
}

@end
