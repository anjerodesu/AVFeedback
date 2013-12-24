//
//  AVPlatform.m
//  AVFeedbackDemo
//
//  Created by Angelo Villegas on 12/23/13.
//  Copyright (c) 2013 Studio Villegas. All rights reserved.
//

#include <sys/sysctl.h>
#import "AVPlatform.h"

static NSString * const CFBundleDisplayName = @"CFBundleDisplayName";
static NSString * const CFBundleShortVersionString = @"CFBundleShortVersionString";

@interface AVPlatform (Private)

- (NSString *)platform;

@end

@implementation AVPlatform

#pragma mark - Singleton
+ (instancetype)sharedPlatform
{
    static AVPlatform *sharedConstant = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedConstant = [[[self class] alloc] initWithDeviceNames];
    });
	
    return sharedConstant;
}

#pragma mark - Initialisers
- (instancetype)initWithDeviceNames
{
	self = [super init];
	
	if (self)
	{
		NSArray *keys = @[
						  /* iPhones   */ @"iPhone1,1", @"iPhone1,2", @"iPhone2,1", @"iPhone3,1", @"iPhone3,3", @"iPhone4,1", @"iPhone5,1", @"iPhone5,2", @"iPhone5,3", @"iPhone5,4", @"iPhone6,1", @"iPhone6,2",
						  /* iPods	   */ @"iPod1,1", @"iPod2,1", @"iPod3,1", @"iPod4,1", @"iPod5,1",
						  /* iPads     */ @"iPad1,1", @"iPad2,1", @"iPad2,2", @"iPad2,3", @"iPad2,4", @"iPad3,1", @"iPad3,2", @"iPad3,3", @"iPad3,4", @"iPad3,5", @"iPad3,6", @"iPad4,1", @"iPad4,2",
						  /* Minis     */ @"iPad2,5", @"iPad2,6", @"iPad2,7", @"iPad4,4", @"iPad4,5",
						  /* Simulator */ @"i386", @"x86_64"];
		
		NSArray *objects = @[
							 /* iPhones   */ @"iPhone 1G", @"iPhone 3G", @"iPhone 3GS", @"iPhone 4", @"Verizon iPhone 4", @"iPhone 4S", @"iPhone 5 (GSM)", @"iPhone 5 (GSM+CDMA)", @"iPhone 5c (GSM)", @"iPhone 5c (Global)", @"iPhone 5s (GSM)", @"iPhone 5s (Global)",
							 /* iPods     */ @"iPod Touch 1G", @"iPod Touch 2G", @"iPod Touch 3G", @"iPod Touch 4G", @"iPod Touch 5G",
							 /* iPads     */ @"iPad", @"iPad 2 (WiFi)", @"iPad 2 (GSM)", @"iPad 2 (CDMA)", @"iPad 2", @"iPad-3G (WiFi)", @"iPad-3G (4G)", @"iPad-3G (4G)", @"iPad-4G (WiFi)", @"iPad-4G (GSM)", @"iPad-4G (GSM+CDMA)", @"iPad Air (WiFi)", @"iPad Air (Cellular)",
							 /* Minis     */ @"iPad mini-1G (WiFi)", @"iPad mini-1G (GSM)", @"iPad mini-1G (GSM+CDMA)", @"iPad mini-2G (WiFi)", @"iPad mini-2G (Cellular)",
							 /* Simulator */ @"Simulator", @"Simulator"];
		
		NSDictionary *deviceNames = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
		_deviceNames = deviceNames;
	}
	
	return self;
}

#pragma mark - Instance methods
- (NSString *)deviceName:(NSString *)platform
{
	return _deviceNames[platform];
}

- (NSString *)platform
{
    int mib[2];
    size_t len;
    char *machine;
	
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
	
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    return platform;
}

/*
 * http://theiphonewiki.com/wiki/Models
 *
 * Identifiers is being updated everytime a new
 * device is launched. Make sure to visit the site
 * after a release and add the identifier properly.
 *
 */
- (NSString *)platformString
{
    NSString *platform = [self platform];
	NSString *deviceName = _deviceNames[platform];
    return (deviceName)? deviceName : platform ;
}

- (NSString *)systemVersion
{
    return [UIDevice currentDevice].systemVersion;
}

- (NSString *)appName
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:CFBundleDisplayName];
}

- (NSString *)appVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:CFBundleShortVersionString];
}

- (NSString *)appBuild
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
}

@end
