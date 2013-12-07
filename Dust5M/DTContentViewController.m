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
#import "FavouriteArticle.h"

@interface DTContentViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

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
}

- (void) viewDidAppear: (BOOL) animated {
    
    [super viewDidAppear: animated];
    
    /*
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask , YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: @"app.css"];
    NSString *destinationPath = [documentsDirectory stringByAppendingPathComponent: @"app.css"];

    NSError *error = nil;
    
    [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath: destinationPath error: &error];
     */
    
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
    
    
    
    NSError * error;
    NSFetchRequest * checkExistance = [[NSFetchRequest alloc] init];
    [checkExistance setEntity: [NSEntityDescription entityForName:@"FavouriteArticle" inManagedObjectContext:self.managedObjectContext]];
    [checkExistance setFetchLimit:1];
    [checkExistance setPredicate:[NSPredicate predicateWithFormat:@"contentId == %@", self.article.contentId]];
    FavouriteArticle *checkedArticle = [[self.managedObjectContext executeFetchRequest:checkExistance error:&error] lastObject];
    
    
    
    
    if(checkedArticle == nil) {
        FavouriteArticle *favouriteArticle = [NSEntityDescription insertNewObjectForEntityForName: @"FavouriteArticle"
                                                                           inManagedObjectContext: self.managedObjectContext];
        
        favouriteArticle.contentId = self.article.contentId;
        favouriteArticle.contentType = [NSNumber numberWithInt: self.article.contentType];
        favouriteArticle.countryCode = self.article.countryCode;
        favouriteArticle.date = self.article.date;
        favouriteArticle.headline = self.article.headline;
        favouriteArticle.htmlBody = self.article.htmlBody;
        favouriteArticle.linkString = self.article.linkString;
        favouriteArticle.thumbnailURL = self.article.thumbnailURL;
        
        
        if (![self.managedObjectContext save: &error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
    
}

@end
