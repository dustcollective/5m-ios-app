//
//  DTSafariActivity.m
//  Dust5M
//
//  Created by Kemal Enver on 16/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTSafariActivity.h"

@implementation DTSafariActivity {
    
    NSURL *_URL;
}

- (NSString *)activityType {
    
    return NSStringFromClass([self class]);
}

- (NSString *)activityTitle {
    
    return NSLocalizedStringFromTable(@"OPEN_SAFARI", @"Open in Safari action", nil);
}

- (UIImage *)activityImage {
    
    return [UIImage imageNamed: @"Safari.png"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    
    for (id activityItem in activityItems) {
        
        if ([activityItem isKindOfClass:[NSURL class]] && [[UIApplication sharedApplication] canOpenURL: activityItem]) {
            
            return YES;
        }
    }
    
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    
    for (id activityItem in activityItems) {
        
        if ([activityItem isKindOfClass:[NSURL class]]) {
            
            _URL = activityItem;
        }
    }
}

- (void) performActivity {
    
    BOOL completed = [[UIApplication sharedApplication] openURL: _URL];
    
    [self activityDidFinish: completed];
}

@end