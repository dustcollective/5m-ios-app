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
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAction target: self action:@selector(share:)];
    
    UIBarButtonItem *favouriteButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target: self action:@selector(favourite:)];
    
    NSArray *rightItems = @[shareButton, favouriteButton];
    
    self.navigationItem.rightBarButtonItems = rightItems;
    
    DTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    self.managedObjectModel = appDelegate.managedObjectModel;
}

- (void) viewDidAppear: (BOOL) animated {
    
    [super viewDidAppear: animated];
    
    if(self.article) {
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: @"res"];
        
        NSURL *baseURL = [NSURL fileURLWithPath: path];
        
        [self.webView loadHTMLString: self.article.htmlBody baseURL: baseURL];
    }
}

- (void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) webViewDidFinishLoad: (UIWebView *) webView {
    
    if(self.article) {
        
        if(self.article.thumbnailURL) {
            
            NSString *javaScript = [NSString stringWithFormat: @"var img = document.createElement('img'); img.src = '%@'; document.body.insertBefore(img,document.body.childNodes[0]);", self.article.thumbnailURL];
            
            [self.webView stringByEvaluatingJavaScriptFromString: javaScript];
        }
        
        NSString *javaScript1 = [NSString stringWithFormat: @"var h1 = document.createElement('h1'); var content = document.createTextNode('%@'); h1.appendChild(content); document.body.insertBefore(h1,document.body.childNodes[0]);;", self.article.headline];
        
        [self.webView stringByEvaluatingJavaScriptFromString: javaScript1];
        
        NSString *javaScript2 = [NSString stringWithFormat: @"var fileref = document.createElement('link'); fileref.setAttribute('rel', 'stylesheet'); fileref.setAttribute('type', 'text/css'); fileref.setAttribute('href', 'app.css'); document.getElementsByTagName('head')[0].appendChild(fileref)"];
        
        [self.webView stringByEvaluatingJavaScriptFromString: javaScript2];
    }
}

- (void) share: (UIBarButtonItem *) button {
    
    NSURL *URL = [NSURL URLWithString: self.article.linkString];
    NSArray *activityItems = @[self.article.headline, URL];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems: activityItems
                                                                                     applicationActivities: @[[[DTSafariActivity alloc] init]]];
    activityController.excludedActivityTypes = @[UIActivityTypeAssignToContact];
    
    [self presentViewController: activityController animated: YES completion: nil];
}

- (void) favourite: (UIBarButtonItem *) button {
    
    self.article.favourite = @1;
    
    NSError *error = nil;
    [self.managedObjectContext save: &error];
    
    
    if(error) {
        NSLog(@"Error setting favourite");
    }

    
}

@end
