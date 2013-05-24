//
//  AppCategoriesViewController.m
//  CetasAppInsights
//
//  Created by Vipin Joshi on 23/05/13.
//  Copyright (c) 2013 Cetas. All rights reserved.
//

#import "AppCategoriesViewController.h"
#import "Constants.h"
#import "SingletonClass.h"
#import <QuartzCore/QuartzCore.h>

@interface AppCategoriesViewController ()

@property (strong) NSArray *categories;


@end

@implementation AppCategoriesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        // Custom initialization
        self.title = @"Cetas App Insights";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.categories = [NSArray arrayWithObjects:@"Installed Apps",@"Running Apps", nil];
    [SingletonClass setNavigationTitleFont:self.navigationItem];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1.0];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [self.categories objectAtIndex:indexPath.section];
    
    // Configure the cell...
    
    return cell;
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


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 185;
        
    }else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(self.tableView.frame.origin.x,0, self.tableView.frame.size.width, 185)];
        headerView.backgroundColor = [UIColor clearColor];
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.tableView.frame.size.width-20, 120)];
        containerView.backgroundColor = [UIColor colorWithWhite:0.80 alpha:1.0];
        containerView.layer.cornerRadius = 10.0;
        UIView *innerContainerView = [[UIView alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width/2-70, 10, 120, 100)];
        innerContainerView.backgroundColor = [UIColor whiteColor];
        innerContainerView.layer.cornerRadius = 10.0;
        [containerView addSubview:innerContainerView];
        headerView.backgroundColor = [UIColor clearColor];
        
        NSString *imageFilePath = [NSString stringWithFormat:@"%@.%@",@"Logo",@"png"];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 90, 60)];
        UIImage *logo = [UIImage imageNamed:imageFilePath];
        imgView.image = logo;
        [innerContainerView addSubview:imgView];
        
        UIView *labelBackView = [[UIView alloc] initWithFrame:CGRectMake(11, 145, self.tableView.frame.size.width-20, 25)];
        labelBackView.backgroundColor = [UIColor colorWithWhite:0.72 alpha:1.0];
        labelBackView.layer.cornerRadius = 20.0;
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, headerView.frame.size.width, 25)];
        headerLabel.text = @"Please select a category";
        headerLabel.font = [UIFont systemFontOfSize:14.0];
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.backgroundColor = [UIColor clearColor];
        [labelBackView addSubview:headerLabel];
        
        [headerView addSubview:labelBackView];
        [headerView addSubview:containerView];
        return headerView;
        
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *categoryType = @"";
    if(indexPath.section == 0){
        categoryType = kApplicationCategoryInstalled;
    }else{
        categoryType = kApplicationCategoryActive;
    }
    AppListViewController *appList = [[AppListViewController alloc] initWithStyle:UITableViewStyleGrouped category:categoryType];
    [self.navigationController pushViewController:appList animated:YES];
    
}




@end
