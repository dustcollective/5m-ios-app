//
//  DTAPIClient.h
//  Dust5M
//
//  Created by Kemal Enver on 11/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface DTAPIClient : AFHTTPRequestOperationManager

+ (instancetype) sharedClient;

@end
