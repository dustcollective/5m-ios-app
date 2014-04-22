//
//  DTWebViewController.m
//  Dust5M
//
//  Created by Kemal Enver on 13/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTWebViewController.h"
#import "DTAppDelegate.h"
#import "GAI.h"

@interface DTWebViewController ()

@end

@implementation DTWebViewController


- (void) viewWillAppear: (BOOL) animated {
    
    [super viewWillAppear: animated];
    
    CGSize limitedWidthSize = CGSizeMake(self.view.frame.size.width, self.webView.scrollView.contentSize.height);
    self.webView.scrollView.contentSize = limitedWidthSize;
    
    if(self.htmlString) {
        
        [self.webView loadHTMLString: self.htmlString baseURL: nil];
    }
    else if(self.pageURLString) {
        
        NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString: self.pageURLString]];
        
        [self.webView loadRequest: request];
    }
    else {
        
        NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString: NSLocalizedString(@"MORE_APPS_LINK", @"More apps link")]];
        
        [self.webView loadRequest: request];
    }
}


- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.webView.delegate = self;
}


- (void) webViewDidFinishLoad: (UIWebView *) webView {
    
    // Webpage seems to be too wide.  Force it to the width of the screen so that the
    // drawer gesture is recognised instead of the webview scroll recogniser.
    webView.scrollView.contentSize = CGSizeMake(webView.frame.size.width, webView.scrollView.contentSize.height);
    
    NSString *screen = self.pageURLString ? [NSString stringWithFormat: @"Web Content: %@", self.pageURLString] : @"More Apps";
    
    DTAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.tracker set: kGAIScreenName
                    value: screen];
    [delegate.tracker send: [[GAIDictionaryBuilder createAppView] build]];
}


- (IBAction) toggleDrawer: (id) sender {
    
    if(self.pageURLString) {
        
        [self.navigationController popViewControllerAnimated: YES];
    }
    else {
        if(self.mm_drawerController.openSide == MMDrawerSideNone) {
            
            [self.mm_drawerController openDrawerSide: MMDrawerSideLeft animated: YES completion:nil];
        }
        else {
            [self.mm_drawerController closeDrawerAnimated: YES completion: nil];
        }
    }
}

@end