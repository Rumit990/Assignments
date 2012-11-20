//
//  CentredTableView.m
//
//  Created by Dan Hanly on 27/04/2012.
//  Copyright (c) 2012 DanielHanly.com All rights reserved.
//
//  The dataSource variable must be in a string dictionary->array format as follows:
//
//  Section 1,
//      Row 1,
//      Row 2,
//      Row 3,
//      Row 4,
//      Row 5,
//  Section 2,
//      Row 1,
//      Row 2,
//      Row 3,
//      Row 4,
//      Row 5,


#import "CentredTableView.h"

@implementation CentredTableView

#define CELL_HEIGHT 44.0
#define SECTION_HEADER_HEIGHT 22.0

+(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section withDataSource:(NSDictionary *)dataSource{
    
    CGFloat height = 0.0;
    CGFloat totalTableHeight = [self getTotalTableHeightByDataSource:dataSource];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    if (totalTableHeight>=bounds.size.height){
        return SECTION_HEADER_HEIGHT;
    } else {
        if(section==0){
            height = (bounds.size.height/2)-(totalTableHeight/2);
            return height;
        } else {
            return SECTION_HEADER_HEIGHT;
        }        
    }   
}

+(CGFloat)getTotalTableHeightByDataSource:(NSDictionary *)dataSource{
    CGFloat height;
    for (NSString *section in dataSource) {
        height += SECTION_HEADER_HEIGHT;
        for (NSString *row in [dataSource objectForKey:section]) {
            height += CELL_HEIGHT;
        }
    }
    return height;
}



@end
