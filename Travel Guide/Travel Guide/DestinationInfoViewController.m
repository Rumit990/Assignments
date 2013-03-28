//
//  DestinationInfoViewController.m
//  CetasDataIngestionAPI
//
//  Copyright (c) 2011 - 2012 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//


#import "DestinationInfoViewController.h"
#import "CetasTracker.h"
#import "CetasEvent.h"

@interface DestinationInfoViewController ()

@end

@implementation DestinationInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(id)initWithCountry:(NSString*)country destination:(NSString *)destination{
    
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
        self.country = country;
        self.destination = destination;
        self.title = self.destination;
        UILabel *titleView = (UILabel *)self.navigationController.navigationItem.titleView;
        titleView.font = [UIFont systemFontOfSize:12];
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *likeButton = [[UIBarButtonItem alloc] initWithTitle:@"Like" style:UIBarButtonItemStylePlain target:self action:@selector(likeButtonPressed)];
     self.navigationItem.rightBarButtonItem = likeButton;
    NSString *imageFilePath = [NSString stringWithFormat:@"%@_%@.%@",self.country,self.destination,@"jpg"];
    self.imageView.image = [UIImage imageNamed:imageFilePath];
}


-(void)likeButtonPressed{
    
    
    // Track event when the user presses the like button.
    
    CetasEvent *event= [[CetasEvent alloc] init];
    
    NSString *favDestination = [NSString stringWithFormat:@"%@, %@",self.destination,self.country];
    NSMutableDictionary *eventDetail = [NSMutableDictionary dictionaryWithObject:favDestination forKey:@"Favourite_Destination"];
    [event setEventDetail:eventDetail];
    [[CetasTracker getDefaultTracker] logEvent:event];

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
