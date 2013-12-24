//
//  AVFeedbackTopicCellItem.m
//  AVFeedbackDemo
//
//  Created by Angelo Villegas on 12/24/13.
//  Copyright (c) 2013 Studio Villegas. All rights reserved.
//

#import "AVFeedbackTopicCellItem.h"

@implementation AVFeedbackTopicCellItem

+ (UITableViewCellStyle)cellStyle
{
    return UITableViewCellStyleValue1;
}

- (instancetype)init
{
    self = [super init];
	
    if (self)
	{
        self.title = NSLocalizedStringFromTable(@"Topic", @"AVFeedbackLocalizable", @"Topic");
    }
	
    return self;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    [super configureCell:cell atIndexPath:indexPath];
	
    cell.textLabel.text = self.title;
    cell.detailTextLabel.text = self.topic;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
}

@end
