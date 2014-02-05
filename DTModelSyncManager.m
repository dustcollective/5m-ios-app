//
//  DTModelSyncManager.m
//  Dust5M
//
//  Created by Kemal Enver on 07/12/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTModelSyncManager.h"
#import "DTArticleModel.h"

@implementation DTModelSyncManager

+ (DTModelSyncManager *) sharedClient {
    
    static DTModelSyncManager *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedClient = [[DTModelSyncManager alloc] init];
    });
    
    return sharedClient;
}



@end
