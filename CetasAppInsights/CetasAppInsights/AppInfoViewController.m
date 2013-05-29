//
//  AppInfoViewController.m
//  CetasAppInsights
//
//  Copyright (c) 2013 Cetas Software, Inc. All rights reserved.
//  This is Cetas proprietary and confidential material and its use
//  is subject to license terms.
//
//This class is used to display Application Information.

#import "AppInfoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SingletonClass.h"

@interface AppInfoViewController ()

@end

@implementation AppInfoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"App Info";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView reloadData];
    [SingletonClass setNavigationTitleFont:self.navigationItem];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setAppIconImage:(UIImage *)paramAppIconimage{
    appIconImage = paramAppIconimage;
    [self.tableView reloadData];
}
-(UIImage *)appIconImage{
    return appIconImage;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.appInfoItemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.detailTextLabel.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *item = [self.appInfoItemArray objectAtIndex:indexPath.row];
    NSString *title = [item objectForKey:kAppInfoItemKeyTitle] ;
    NSString *value = [NSString stringWithFormat:@"%@",[item objectForKey:kAppInfoItemKeyValue]] ;
    
    cell.textLabel.text = title;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:13.0];
    cell.detailTextLabel.font =[UIFont systemFontOfSize:12.0];
    cell.detailTextLabel.text = value;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [self.appInfoItemArray objectAtIndex:indexPath.row];
    NSString *value = [[item objectForKey:kAppInfoItemKeyValue] description];

    
    CGSize maxSize = CGSizeMake(self.view.bounds.size.width - 20.0f, CGFLOAT_MAX);
    CGSize labelSize = [value sizeWithFont:[UIFont systemFontOfSize:14.0f]
                         constrainedToSize:maxSize
                             lineBreakMode:NSLineBreakByTruncatingTail];
    
    return (labelSize.height + 30.0f);
    return 50.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 124;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(10,10, self.tableView.frame.size.width-20, 124)];
    headerView.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1.0];
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(8, 17, 90 , 90)];
    imageView.image = [UIImage imageNamed:@"placeholder-icon"];
    if(self.appIconImage){
        imageView.image = self.appIconImage;
    }
    [headerView addSubview:imageView];
    
    UILabel *appNameLabel =[[UILabel alloc] initWithFrame:CGRectMake(120, 45, 200, 50)];
    appNameLabel.textColor =[UIColor blackColor];
    appNameLabel.textAlignment = UITextAlignmentLeft;
    appNameLabel.backgroundColor = [UIColor clearColor];
    appNameLabel.font =[UIFont boldSystemFontOfSize:17.0];
    appNameLabel.text = self.appName;
    appNameLabel.numberOfLines = 0;
    [headerView addSubview:appNameLabel];
    return headerView;
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
