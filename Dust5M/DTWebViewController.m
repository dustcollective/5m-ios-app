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
    
    self.logoLabel.font = [UIFont fontWithName: @"BetonEF-Light" size: 52];
    self.logoLabel.text = NSLocalizedString(@"Appname", @"Name of Application");
    
    self.webView.delegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString: @"http://app.5mpublishing.com/apps_es.php"]];
    
    [self.webView loadRequest: request];
}


@end