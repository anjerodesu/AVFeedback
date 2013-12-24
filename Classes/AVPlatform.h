//
//  AVPlatform.h
//  AVFeedbackDemo
//
//  Created by Angelo Villegas on 12/23/13.
//  Copyright (c) 2013 Studio Villegas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVPlatform : NSObject

@property (copy, nonatomic, readonly) NSDictionary *deviceNames;

// Singleton
+ (instancetype)sharedPlatform;

// Initialisers
- (instancetype)initWithDeviceNames;

// Instance methods
- (NSString *)deviceName:(NSString *)platform;

- (NSString *)platformString;
- (NSString *)systemVersion;
- (NSString *)appName;
- (NSString *)appVersion;
- (NSString *)appBuild;

@end
