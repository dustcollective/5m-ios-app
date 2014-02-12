//
//  DTWebViewController.m
//  Dust5M
//
//  Created by Kemal Enver on 13/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTWebViewController.h"

@interface DTWebViewController ()

@end

@implementation DTWebViewController


- (void) viewWillAppear: (BOOL) animated {
    
    [super viewWillAppear: animated];
    
    CGSize limitedWidthSize = CGSizeMake(self.view.frame.size.width, self.webView.scrollView.contentSize.height);
    self.webView.scrollView.contentSize = limitedWidthSize;
}


- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.webView.delegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString: @"http://app.5mpublishing.com/apps_es.php"]];
    
    [self.webView loadRequest: request];
}


- (void) webViewDidFinishLoad: (UIWebView *) webView {
    
    // Webpage seems to be too wide.  Force it to the width of the screen so that the
    // drawer gesture is recognised instead of the webview scroll recogniser.
    webView.scrollView.contentSize = CGSizeMake(webView.frame.size.width, webView.scrollView.contentSize.height);
    
}

@end