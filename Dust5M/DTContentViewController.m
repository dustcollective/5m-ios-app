//
//  DTWebContentViewController.m
//  Dust5M
//
//  Created by Kemal Enver on 11/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTContentViewController.h"
#import "DTSafariActivity.h"
#import "DTAppDelegate.h"

@interface DTContentViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;

@end


@implementation DTContentViewController


- (id) initWithNibName: (NSString *) nibNameOrNil bundle: (NSBundle *) nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.webView.delegate = self;
    
    self.webView.scrollView.scrollEnabled = NO;
    
    self.titleLabel.font = [UIFont fontWithName: @"BetonEF-DemiBold" size: 14.0f];
    
    [self.titleLabel sizeToFit];

    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAction target: self action:@selector(share:)];
    
    UIBarButtonItem *favouriteButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target: self action:@selector(favourite:)];
    
    NSArray *rightItems = @[shareButton, favouriteButton];
    
    self.navigationItem.rightBarButtonItems = rightItems;
    
    DTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    self.managedObjectModel = appDelegate.managedObjectModel;
}


- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear: animated];
    
    [self.navigationController setNavigationBarHidden: YES animated: NO];
    
    NSDateFormatter  *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat: @"EEE, dd MMM YYYY"];
    
    NSString *link = [self.article.thumbnailURL stringByAddingPercentEscapesUsingEncoding: NSStringEncodingConversionExternalRepresentation];
    
    if([self.article.contentType isEqualToString: @"event"]) {
        loadImage(self.imageView, [NSURL URLWithString: link] , @"EventLargePH");
    }
    else {
        loadImage(self.imageView, [NSURL URLWithString: link] , @"NewsLargePH");
    }
    
    self.titleLabel.text = self.article.headline;
    
    if([self.article.contentType isEqualToString: @"event"]) {
        
        NSString *dateRange = [NSString stringWithFormat: @"%@ - %@", [formatter stringFromDate: self.article.startDate], [formatter stringFromDate: self.article.endDate]];
        self.dateLabel.text = dateRange;
    }
    
    else {
        self.dateLabel.text = [formatter stringFromDate: self.article.date];
    }
    
    self.imageView.frame = CGRectMake(0, 0, 320, 226);
    
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: @"res"];
    
    NSURL *baseURL = [NSURL fileURLWithPath: path];
    
    [self.webView loadHTMLString: self.article.htmlBody baseURL: baseURL];
}


- (void) webViewDidFinishLoad: (UIWebView *) webView {
    
    if(self.article) {
        
        if([self.article.contentType isEqualToString: @"event"]) {
            NSString *insertLocation = [NSString stringWithFormat: @"var locationDiv=document.createElement('h2'); locationDiv.appendChild(document.createTextNode('%@')); var childNode=document.getElementsByTagName('body')[0].firstChild; document.getElementsByTagName('body')[0].insertBefore(locationDiv,childNode)", self.article.location];
            
            [self.webView stringByEvaluatingJavaScriptFromString: insertLocation];
        }
        
        
        NSString *javaScript1 = @"var fileref = document.createElement('link'); fileref.setAttribute('rel', 'stylesheet'); fileref.setAttribute('type', 'text/css'); fileref.setAttribute('href', 'app.css'); document.getElementsByTagName('head')[0].appendChild(fileref)";
        
        [self.webView stringByEvaluatingJavaScriptFromString: javaScript1];
        
        

        double delayInSeconds = 0.5f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            self.webView.frame = CGRectMake(0, 226, 320, self.webView.scrollView.contentSize.height);
            self.scrollView.contentSize = CGSizeMake(320, self.webView.scrollView.contentSize.height + 226);
        });
        
    }
}


- (IBAction) share: (id) button {
    
    NSURL *URL = [NSURL URLWithString: self.article.linkString];
    NSArray *activityItems = @[self.article.headline, URL];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems: activityItems
                                                                                     applicationActivities: @[[[DTSafariActivity alloc] init]]];
    activityController.excludedActivityTypes = @[UIActivityTypeAssignToContact];
    
    [self presentViewController: activityController animated: YES completion: nil];
}


- (IBAction) favourite: (id) button {
    
    if(self.article.favourite == 0) {
        self.article.favourite = @1;
    }
    else {
        self.article.favourite = @0;
    }
    
    NSError *error = nil;
    [self.managedObjectContext save: &error];
    
    if(error) {
        
        NSLog(@"Error setting favourite");
    }
}


- (BOOL) webView: (UIWebView *) webView shouldStartLoadWithRequest: (NSURLRequest *) request
  navigationType: (UIWebViewNavigationType) navigationType {
    
    if(navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        // Maybe open in a browser on top?
        
        return  NO;
    }
    
    return YES;
}


- (IBAction) toggleDrawer: (id) sender {
    
    [self.navigationController popViewControllerAnimated: YES];
}


@end
