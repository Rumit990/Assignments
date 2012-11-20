//
//  CentredTableView.h
//
//  Created by Dan Hanly on 27/04/2012.
//  Copyright (c) 2012 DanielHanly.com All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CentredTableView : NSObject

+(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section withDataSource:(NSDictionary *)dataSource;
+(CGFloat)getTotalTableHeightByDataSource:(NSDictionary *)dataSource;

@end
