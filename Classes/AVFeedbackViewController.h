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

@property (nonatomic, strong) NSArray *topics;
@property (nonatomic, strong) NSDictionary *localizedTopics;

/*
 * selectedTopic's default value is first item of topics.
 */
@property (nonatomic, strong) NSString *selectedTopic;

@property (nonatomic, strong) NSArray *toRecipients;
@property (nonatomic, strong) NSArray *ccRecipients;
@property (nonatomic, strong) NSArray *bccRecipients;

+ (AVFeedbackViewController *)controllerWithDefaultLocalizedTopics;
+ (AVFeedbackViewController *)controllerWithTopics:(NSArray *)topics localizedTopics:(NSDictionary *)localizedTopics;

+ (NSArray *)defaultTopics;
+ (NSDictionary *)defaultLocalizedTopics;
- (instancetype)initWithTopics:(NSArray *)topics localizedTopics:(NSDictionary *)localizedTopics;

@end
