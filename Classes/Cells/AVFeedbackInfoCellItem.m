//
//  AVFeedbackInfoCellItem.m
//  AVFeedbackDemo
//
//  Created by Angelo Villegas on 12/24/13.
//  Copyright (c) 2013 Studio Villegas. All rights reserved.
//

#import "AVFeedbackInfoCellItem.h"

@implementation AVFeedbackInfoCellItem

+ (UITableViewCellStyle)cellStyle
{
    return UITableViewCellStyleValue1;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    [super configureCell:cell atIndexPath:indexPath];
	
    cell.textLabel.text = self.title;
    cell.detailTextLabel.text = self.value;
}

@end

