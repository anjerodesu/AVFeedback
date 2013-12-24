//
//  AVFeedbackTopicsViewController.h
//  AVFeedbackDemo
//
//  Created by Angelo Villegas on 12/23/13.
//  Copyright (c) 2013 Studio Villegas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVFeedbackTopicsViewController : UITableViewController

@property (nonatomic, strong) NSArray *topics;
@property (nonatomic, strong) NSDictionary *localizedTopics;
@property (nonatomic, copy) void (^action)(NSString *);

@end
