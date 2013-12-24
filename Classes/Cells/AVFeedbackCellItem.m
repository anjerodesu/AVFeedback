//
//  AVFeedbackCellItem.m
//  AVFeedbackDemo
//
//  Created by Angelo Villegas on 12/23/13.
//  Copyright (c) 2013 Studio Villegas. All rights reserved.
//


#import "AVFeedbackCellItem.h"

@implementation AVFeedbackCellItem

+ (UITableViewCellStyle)cellStyle
{
    return UITableViewCellStyleDefault;
}

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass(self.class);
}

- (CGFloat)cellHeight
{
    return 44.0;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    cell.textLabel.text = nil;
    cell.detailTextLabel.text = nil;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
