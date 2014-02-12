//
//  DTWebContentViewController.h
//  Dust5M
//
//  Created by Kemal Enver on 11/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTArticle.h"

#import "DTBaseViewController.h"

@interface DTContentViewController : DTBaseViewController <UIWebViewDelegate>

@property (nonatomic, strong) DTArticle *article;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) IBOutlet UIWebView *webView;

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end
