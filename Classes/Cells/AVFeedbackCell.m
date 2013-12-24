//
//  AVFeedbackCell.m
//  AVFeedbackDemo
//
//  Created by Angelo Villegas on 12/23/13.
//  Copyright (c) 2013 Studio Villegas. All rights reserved.
//

#import "AVFeedbackCell.h"
#import "AVFeedbackCellItem.h"

NSString * const AVFeedbackCellIdentifierTopic = @"AVFeedbackCellIdentifierTopic";

@implementation AVFeedbackCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:[NSClassFromString(reuseIdentifier) cellStyle] reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
