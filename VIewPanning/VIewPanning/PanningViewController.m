//
//  PanningViewController.m
//  VIewPanning
//
//  Created by Chetan Sanghi on 06/11/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import "PanningViewController.h"

@implementation PanningViewController

@synthesize bigView, mainButton, duplicatePanButton;
@synthesize baseFrame,duplicateFrame;
@synthesize bigViewLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)panningHandler:(UIPanGestureRecognizer *)panGesture
{

    
    switch (panGesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            
            NSLog(@"Panning began");
            
            CGPoint panStartPoint = [panGesture locationInView:self.mainButton];
            
            if([self.mainButton pointInside:panStartPoint withEvent:nil])
            {
                NSLog(@"Should pan");
                if (self.duplicatePanButton) {
                    [self.duplicatePanButton removeFromSuperview];
                    self.duplicatePanButton = nil;
                }
                
                // CGRect duplicateButtonFrame = CGRectMake(self.view.frame.origin.x , self.view.frame.origin.y, self.baseFrame.size.width, self.baseFrame.size.height);
                CGRect frame = CGRectMake(self.mainButton.frame.origin.x - 10, self.mainButton.frame.origin.y - 10, self.mainButton.frame.size.width, self.mainButton.frame.size.height);
                
                
                self.duplicatePanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                self.duplicatePanButton.frame = frame;
                
                [self.duplicatePanButton setTitle:@"PAN" forState:UIControlStateNormal];
                [self.duplicatePanButton setTitle:@"PAN" forState:UIControlStateHighlighted];

                
                [self.view addSubview:self.duplicatePanButton];
                [self.view bringSubviewToFront:self.duplicatePanButton];
                
            }
            
            else
            {
                NSLog(@"Should not pan");
                
            }
        }
            
            break;
            
        case UIGestureRecognizerStateChanged:{
        
            if(!duplicatePanButton){
                return;
            }
            
            
            NSLog(@"State changed");
    
                
            NSLog(@"Still in the duplicate button");
                
            CGPoint translation = [panGesture translationInView:self.view];
            
            
            
            //creation of new frame as per the translation in the gesture
            
            CGFloat newXCoordinate = self.duplicatePanButton.center.x+translation.x;
            CGFloat newYCoordinate = self.duplicatePanButton.center.y+translation.y;
            
            CGPoint center = CGPointMake(newXCoordinate, newYCoordinate);
            
            //CGRect newFrame = CGRectMake( newXCoordinate, newYCoordinate, self.mainButton.frame.size.width, self.mainButton.frame.size.height);
            
           // self.duplicatePanButton.frame = newFrame;
            self.duplicatePanButton.center = center;
            
            [panGesture setTranslation:CGPointZero inView:self.view];

            
//            CGFloat newXCoordinate = self.mainButton.frame.origin.x+translation.x;
//            CGFloat newYCoordinate = self.mainButton.frame.origin.y+translation.y;
//            
//            
//            CGRect newFrame = CGRectMake( newXCoordinate, newYCoordinate, self.mainButton.frame.size.width, self.mainButton.frame.size.height);
//            
//            self.mainButton.frame = newFrame;
//            
//            [panGesture setTranslation:CGPointZero inView:self.mainButton];

        }             
            break;
            
        case UIGestureRecognizerStateEnded:{
            if (!duplicatePanButton) {
                return;
            }
                
                NSLog(@"Gesture ended");
            CGPoint endGesturePoint = [panGesture locationInView:bigView];
            
            if([self.bigView pointInside:endGesturePoint withEvent:nil])
            {
                self.mainButton.frame = self.duplicatePanButton.frame;
                self.bigViewLabel.text = @"Its in";
                
            }
                
            else
            {
                self.mainButton.frame = self.baseFrame;
                self.bigViewLabel.text = @"";
            }
            [self.duplicatePanButton removeFromSuperview];
            self.duplicatePanButton = nil;
        }
            
                break;
        case UIGestureRecognizerStateFailed:
            NSLog(@"Gesture failed");
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"Gesture cancelled");
            break;
        case UIGestureRecognizerStatePossible:
            NSLog(@"gesture possible");
            break;
            
        default:
            break;
    }
}
    
- (void)viewDidLoad
{
    self.baseFrame = self.mainButton.frame;
    
    UIGestureRecognizer * panGesture  = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panningHandler:)];
    
    [self.view addGestureRecognizer:panGesture];
           
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
