//
//  NSBundle+AVFeedback.h
//  AVFeedbackDemo
//
//  Created by Angelo Villegas on 12/23/13.
//  Copyright (c) 2013 Studio Villegas. All rights reserved.
//


#import <Foundation/Foundation.h>

#define AVFeedbackLocalizedString(key) [[NSBundle feedbackBundle] localizedStringForKey:key value:nil table:@"AVFeedbackLocalizable"]

@interface NSBundle (AVFeedback)

+ (NSBundle *)feedbackBundle;

@end