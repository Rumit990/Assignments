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
#import "ProductPortletCreator.h"

@implementation ShoppingListView

@synthesize scrollView;
@synthesize iconDowloaderArray;
@synthesize arrayOfItemViews;


-(NSMutableArray *)arrayOfItemViews
{
    if(!arrayOfItemViews)
    {
        arrayOfItemViews = [[NSMutableArray alloc] init];
    }
    return arrayOfItemViews;
}

-(void)setArrayOfItemViews:(NSMutableArray *)receivedArray
{
    arrayOfItemViews = receivedArray;
}

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

/*
-(void)awakeFromNib
{
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    
    UIEdgeInsets scrollViewInsets = UIEdgeInsetsMake(40, 6, 20, 0);
    
    self.scrollView.contentInset = scrollViewInsets;
}
*/

-(void)appImageDidLoad:(NSIndexPath *)indexPath iconDownloader:(IconDownloader *)paramIconDownloader
{
    
    [[[self.arrayOfItemViews objectAtIndex:paramIconDownloader.itemIndex] shoppingItemImageView] setImage:paramIconDownloader.imageDownloaded];
    
}

#define gapInRows 8
#define gapInItems 8
#define frameWidth 150
#define frameHeight 190


-(void)createViewWithData:(NSMutableArray *)shoppingItems
{
    int count = 0;
    
    CGRect itemViewFrame = CGRectMake(0, 0, frameWidth, frameHeight);
    
    CGFloat scrollViewContentSize = (gapInRows + itemViewFrame.size.height) * ((shoppingItems.count + 1) / 2);
    
    self.scrollView.contentSize = CGSizeMake(320.0, scrollViewContentSize);
    
    [self addSubview:self.scrollView];
    
    
    for(ShoppingItem *item in shoppingItems)
    {

        IconDownloader *downloader = [[IconDownloader alloc] init];
        
        downloader.imageURL = item.imageURL;
        
        downloader.delegate = self;
        
        downloader.itemIndex = count;
        
        [downloader startDownload];
        
        [self.iconDowloaderArray addObject:downloader];

        if(count%2 == 0)
        {
            
            itemViewFrame.origin.x = 0;
            
            ProductPortletCreator *itemView = [[ProductPortletCreator alloc] initWithFrame:itemViewFrame andIndex:count];
            
            
            
            [self.arrayOfItemViews addObject:itemView];
            [self.scrollView addSubview:itemView];
            
        }
        
        else
        {
            
            itemViewFrame.origin.x = itemViewFrame.size.width + gapInItems;
            
            ProductPortletCreator *itemView = [[ProductPortletCreator alloc] initWithFrame:itemViewFrame andIndex:count];
    
            
            
            [self.arrayOfItemViews addObject:itemView];
            [self.scrollView addSubview:itemView];
            
            // each time a portlet for an even number is created, the  index is updated
            
            itemViewFrame.origin.y = itemViewFrame.origin.y + itemViewFrame.size.height + gapInRows;
            
            //self.shoppingItemRowCount++; // each time an even row item is drawn, the row count is set in order to change the frames for the next row
            
        }
        
        
        count++;
        
        
    
    }
       
}

@end
