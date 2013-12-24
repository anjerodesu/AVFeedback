//
//  NSBundle+AVFeedback.h
//  AVFeedbackDemo
//
//  Created by Angelo Villegas on 12/23/13.
//  Copyright (c) 2013 Studio Villegas. All rights reserved.
//


#import "NSBundle+AVFeedback.h"

@implementation NSBundle (AVFeedback)

+ (NSBundle *)feedbackBundle
{
    static NSBundle *bundle = nil;
    static dispatch_once_t predicate;

    dispatch_once(&predicate, ^{
        NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"AVFeedback" withExtension:@"bundle"];

        if (bundleURL)
		{
            bundle = [NSBundle bundleWithURL:bundleURL];
        }
		else
		{
            bundle = [NSBundle mainBundle];
        }
    });

    return bundle;
}

@end