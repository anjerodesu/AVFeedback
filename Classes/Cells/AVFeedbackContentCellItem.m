//
//  AVFeedbackContentCellItem.m
//  AVFeedbackDemo
//
//  Created by Angelo Villegas on 12/24/13.
//  Copyright (c) 2013 Studio Villegas. All rights reserved.
//

#import "AVFeedbackContentCellItem.h"

NSUInteger const ContentCellHeight = 100;
NSString * const AVContentCellItemCellHeightKey = @"cellHeight";
NSString * const AVFeedbackTopicDefaultText = @"Your feedback message...";

@implementation AVFeedbackContentCellItem

- (instancetype)init
{
    self = [super init];
	
    if (self)
	{
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 0, 310, ContentCellHeight)];
        self.textView.text = self.content;
        self.textView.delegate = self;
        self.textView.scrollEnabled = NO;
        self.textView.font = [UIFont systemFontOfSize:14];
        self.textView.backgroundColor = [UIColor clearColor];
    }
	
    return self;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    [super configureCell:cell atIndexPath:indexPath];
    [cell.contentView addSubview:self.textView];
}

- (CGFloat)cellHeight
{
    return MAX(ContentCellHeight, self.textView.contentSize.height);
}

#pragma mark - Text view delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	if ( textView.text == (id)[NSNull null] || textView.text.length == 0 )
	{
		textView.text = AVFeedbackTopicDefaultText;
		textView.textColor = [UIColor lightGrayColor];
		textView.font = [UIFont fontWithName: @"Helvetica-Italics" size: 14.0f];
	}
	
	return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self willChangeValueForKey:AVContentCellItemCellHeightKey];
	
    CGRect frame = self.textView.frame;
	
    if (SYSTEM_VERSION_MINIMUM(@"7.0"))
	{
        [self.textView sizeToFit];
        [self.textView layoutIfNeeded];
    }
	
    frame.size.height = MAX(ContentCellHeight, self.textView.contentSize.height);
    self.textView.frame = frame;
	
    [self didChangeValueForKey:AVContentCellItemCellHeightKey];
}

@end
