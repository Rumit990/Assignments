//
//  Common.h
//  TinyViewModule
//
//  Created by Vipin Joshi on 22/11/12.
//  Copyright (c) 2012 sanghichetan@yahoo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject


+(UILabel *)createLabelWithTitle:(NSString *)title;

+ (UIButton *)createPortletButtonWithTitle:(NSString *)title;

+(CGFloat)tableViewFontSize;

+(CGFloat)tableViewCellHeight;

@end
