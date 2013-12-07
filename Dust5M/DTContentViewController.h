//
//  DTWebContentViewController.h
//  Dust5M
//
//  Created by Kemal Enver on 11/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTArticle.h"

@interface DTContentViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) DTArticle *article;

@property (nonatomic, strong) IBOutlet UIWebView *webView;

@end
