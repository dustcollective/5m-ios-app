//
//  DTAPIClient.m
//  Dust5M
//
//  Created by Kemal Enver on 11/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTAPIClient.h"

// Base URL is defined in config for each target.

@implementation DTAPIClient

+ (instancetype) sharedClient {
    
    static DTAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[DTAPIClient alloc] initWithBaseURL: [NSURL URLWithString: NSLocalizedString(@"FEED_URL", @"Feed URL")]];
        [_sharedClient setSecurityPolicy: [AFSecurityPolicy policyWithPinningMode: AFSSLPinningModePublicKey]];
    });
    
    return _sharedClient;
}
@end
