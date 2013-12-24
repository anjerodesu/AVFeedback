//
//  AVFeedbackCellItem.m
//  AVFeedbackDemo
//
//  Created by Angelo Villegas on 12/23/13.
//  Copyright (c) 2013 Studio Villegas. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface AVFeedbackCellItem : NSObject

+ (UITableViewCellStyle)cellStyle;
+ (NSString *)reuseIdentifier;

@property (nonatomic, readonly) CGFloat cellHeight;
@property (nonatomic, copy) void (^action)(id sender);

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
