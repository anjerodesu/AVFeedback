//
//  AVFeedbackViewController.h
//  AVFeedbackDemo
//
//  Created by Angelo Villegas on 12/23/13.
//  Copyright (c) 2013 Studio Villegas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class AVFeedbackTopicCellItem;
@class AVFeedbackContentCellItem;

@interface AVFeedbackViewController : UITableViewController <MFMailComposeViewControllerDelegate>

@property (nonatomic, copy) id topics;

@property (nonatomic, copy) NSArray *toRecipients;
@property (nonatomic, copy) NSArray *ccRecipients;
@property (nonatomic, copy) NSArray *bccRecipients;

+ (AVFeedbackViewController *)controllerWithDefaultTopics;
+ (AVFeedbackViewController *)controllerWithDefaultTopicsAndImages;
+ (AVFeedbackViewController *)controllerWithTopics:(id)topics;

+ (NSArray *)defaultTopics;
+ (NSDictionary *)defaultTopicsAndImages;

- (instancetype)initWithTopics:(id)topics;

@end
