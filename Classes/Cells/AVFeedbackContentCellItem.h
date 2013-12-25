//
//  AVFeedbackContentCellItem.h
//  AVFeedbackDemo
//
//  Created by Angelo Villegas on 12/24/13.
//  Copyright (c) 2013 Studio Villegas. All rights reserved.
//

#import "AVFeedbackCellItem.h"

#define SYSTEM_VERSION_MINIMUM(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

extern NSUInteger const ContentCellHeight;
extern NSString * const AVContentCellItemCellHeightKey;
extern NSString * const AVFeedbackTopicDefaultText;

@interface AVFeedbackContentCellItem : AVFeedbackCellItem <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@end
