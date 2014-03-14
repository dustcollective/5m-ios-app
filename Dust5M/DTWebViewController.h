//
//  DTWebViewController.h
//  Dust5M
//
//  Created by Kemal Enver on 13/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DTBaseViewController.h"

@interface DTWebViewController : DTBaseViewController <UIWebViewDelegate>

@property (nonatomic, strong) IBOutlet UIWebView *webView;

@property (nonatomic, strong) NSString *htmlString;

@property (nonatomic, strong) NSString *pageURLString;

@end
