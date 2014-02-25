//
//  DTMasterViewController.m
//  Dust5M
//
//  Created by Kemal Enver on 11/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTAppDelegate.h"

#import "DTContentViewController.h"
#import "DTAdvertViewController.h"

#import "DTArticleListViewController.h"
#import "DTAdvertCell.h"
#import "DTBaseArticleCell.h"

#import "DTWebViewController.h"

@interface DTArticleListViewController () {
    
    BOOL _searchMode;
}

@end

@implementation DTArticleListViewController


- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.messageLabel.text = NSLocalizedString(@"NO_NEWS_EVENTS",  @"No Articles");
    
    self.searchDisplayController.searchBar.placeholder = NSLocalizedString(@"SEARCH", @"Search");
    
    self.logoLabel.textColor = logoColor();
    self.logoLabel.text = NSLocalizedString(@"APP_NAME", @"Name of Application");
    
    [self.allButton setTitle: NSLocalizedString(@"INICIO", @"Home Button") forState: UIControlStateNormal];
    [self.newsButton setTitle: NSLocalizedString(@"NOTICIAS", @"News Button") forState: UIControlStateNormal];
    [self.eventButton setTitle: NSLocalizedString(@"EVENTOS", @"Events Button") forState: UIControlStateNormal];
    
    if(IOS_MAJOR_VERSION < 7) {
        
        self.allButton.titleLabel.font = [UIFont systemFontOfSize: 16];
        self.newsButton.titleLabel.font = [UIFont systemFontOfSize: 16];
        self.eventButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    }
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame: CGRectZero];
    
    UINib *mainCellNib = [UINib nibWithNibName: @"DTMainArticleCell" bundle: nil];
    [self.tableView registerNib: mainCellNib forCellReuseIdentifier: @"MainArticleCell"];
    
    UINib *nib = [UINib nibWithNibName: @"DTStandardArticleCell" bundle: nil];
    [self.tableView registerNib: nib forCellReuseIdentifier: @"StandardArticleCell"];
    
    [self.searchDisplayController.searchResultsTableView registerNib: nib forCellReuseIdentifier: @"StandardArticleCell"];
    
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame: CGRectZero];
    [self.refreshControl addTarget: self
                            action: @selector(pullToLoadData)
                  forControlEvents: UIControlEventAllEvents];
    
    [self.tableView addSubview: self.refreshControl];
    
    if(!splashShown) {
        
        splashShown = YES;
        
        self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
        
        NSString *splashImageName = self.view.bounds.size.height > 480 ? @"TallLaunchImage" : @"LaunchImage";
        
        self.splashScreenImageView.image = [UIImage imageNamed: splashImageName];
        
        NSString *versionString = [NSString stringWithFormat: @"v %@",
                                    [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey]];
        
        self.versionLabel.text = versionString;
        
        [NSTimer scheduledTimerWithTimeInterval: 2
                                         target: self
                                       selector: @selector(hideSplash:)
                                       userInfo: nil
                                        repeats: NO];
    }
    else {
        
        [self hideSplash: nil];
    }    
}

// Called after X seconds.  Hides splash screen and enables gestures.

- (void) hideSplash: (NSTimer *) timer {
    
    [self.overlayView removeFromSuperview];
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
}


- (void) viewWillAppear: (BOOL) animated {
    
    [super viewWillAppear: animated];
    
    [self.navigationController setNavigationBarHidden: YES animated: YES];
    
    [self.tableView deselectRowAtIndexPath: self.tableView.indexPathForSelectedRow animated: YES];
    
    [self loadData];
}


- (void) pullToLoadData {
    
    self.model = nil;
    [self loadData];
}


- (void) loadData {
    
    if(!self.model) {
        
        [DTArticleModel articleListWithBlock: ^(DTArticleModel *articleModel, NSError *error) {
            
            if(error) {
                
                NSLog(@"Network error");
            }
            
            // We load territories after we have our model loaded so that we can do the filtering
            
            [self loadTerritoriesData];

            self.model = articleModel;
            
           // [self.model fetchContentForContentType: @"*" withRegionModel: self.regionModel]; // news, event, *
            
            [self filterToEverythig: nil];
            
            [self.tableView reloadData];
            
            [self.refreshControl endRefreshing];
        }];
    }
}


- (void) loadTerritoriesData {
    
    NSString *territoryPath = [documentPath() stringByAppendingPathComponent: @"territories.plist"];
    
    // Check if the database has already been created in the users filesystem
    if (![[NSFileManager defaultManager] fileExistsAtPath: territoryPath]) {
        
        NSString *file = [[NSBundle mainBundle] pathForResource: @"territories.plist" ofType: nil];
        
        NSError *error = nil;
        
        [[NSFileManager defaultManager] copyItemAtPath: file toPath: territoryPath error: &error];
    }
    
    self.regionModel = [NSMutableDictionary dictionaryWithContentsOfFile: territoryPath];
}


#pragma mark -
#pragma mark - Table View


- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        
        return  75.0f;
    }
    
    if(indexPath.row == 0) {
        
        return 226.0f;
    }
    else {
        
        return 75.0f;
    }
}


- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView {
    
    return 1;
}


- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section {
    
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        
        return self.filteredArticles.count;
    }
    
    return self.model.content.count;
}


- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {
    
    NSDateFormatter  *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat: @"EEE, dd MMM YYYY"];
    
    if([self.model.content[indexPath.row] isKindOfClass: [NSNumber class]]) {
        
        NSNumber *advertIndex = self.model.content[indexPath.row];
        NSDictionary *advert = self.model.adverts[advertIndex.intValue];
        
        DTAdvertCell *adCell = [tableView dequeueReusableCellWithIdentifier: @"AdCell"];
        
        if(!adCell) {
            
            adCell = [[DTAdvertCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"AdCell"];
            
            adCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        loadImage(adCell.imageView, [NSURL URLWithString: advert[@"inline"]], @"AdvertPH");
        
        return adCell;
    }
    
    DTArticle *article = nil;
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        
        article = self.filteredArticles[indexPath.row];
    }
    else {
        
        article = self.model.content[indexPath.row];
    }
    
    DTBaseArticleCell *cell = nil;
    
    if(indexPath.row == 0 && tableView != self.searchDisplayController.searchResultsTableView) {
        
        cell = [tableView dequeueReusableCellWithIdentifier: @"MainArticleCell" forIndexPath: indexPath];
    }
    else {
        
        cell = [tableView dequeueReusableCellWithIdentifier: @"StandardArticleCell" forIndexPath: indexPath];
    }
    
    
    // use border rather than background color.  In selected state background colors are hidden by the system
    
    cell.colorBarView.layer.borderWidth = 2.0f;
    cell.descriptionLabel.text = article.headline;
    cell.dateLabel.text = [formatter stringFromDate: article.date];
    
    NSString *link = [article.thumbnailURL stringByAddingPercentEscapesUsingEncoding: NSStringEncodingConversionExternalRepresentation];
    
    if(indexPath.row == 0) {
        
        cell.colorBarView.layer.borderColor = [UIColor whiteColor].CGColor;
        
        if([article.contentType isEqualToString: @"event"]) {
            
            loadImage(cell.thumbnailView, [NSURL URLWithString: link] , @"EventLargePH");
        }
        else {
            
            loadImage(cell.thumbnailView, [NSURL URLWithString: link] , @"NewsLargePH");
        }
            
        
    }
    else if([article.contentType isEqualToString: @"news"]) {
        
        cell.colorBarView.layer.borderColor = RGB(0, 173, 239).CGColor;
                
        loadImage(cell.thumbnailView, [NSURL URLWithString: link], @"NewsPH");
    }
    else if ([article.contentType isEqualToString: @"event" ]) {
        
        cell.colorBarView.layer.borderColor = RGB(0, 176, 0).CGColor;
        
        loadImage(cell.thumbnailView, [NSURL URLWithString: link], @"EventPH");
    }
    
    return cell;
}


- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
    if([self.model.content[indexPath.row] isKindOfClass: [NSNumber class]]) {
        
        NSNumber *advertIndex = self.model.content[indexPath.row];
        NSDictionary *advert = self.model.adverts[advertIndex.intValue];
        
        [self performSegueWithIdentifier: @"advertSegue" sender: advert];
    }
    
    DTArticle *article = nil;
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        
        article = self.filteredArticles[indexPath.row];
    }
    else {
        
        article = self.model.content[indexPath.row];
    }
    
    if([self.model.content[indexPath.row] isKindOfClass: [NSNumber class]]) {
    
        // Advert pressed
    }
    else {
        
        [self performSegueWithIdentifier: @"contentSegue" sender: article];
    }
}


- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender {
    
    if([segue.identifier isEqualToString:@"contentSegue"]) {
        
        DTArticle *article = sender;

        ((DTContentViewController *)segue.destinationViewController).article = article;
    }
    else if([segue.identifier isEqualToString:@ "advertSegue"]) {
    
        NSDictionary *adDictionary = sender;
        
        NSString *adURLString = adDictionary[@"fullscreen"];
        
        ((DTAdvertViewController *)segue.destinationViewController).advertURL = adURLString;
    }
}


- (IBAction) filterToEverythig: (id) sender {
 
    [self filterArticleModelTo: @"*"];
}


- (IBAction) filterToNews: (id) sender {
    
    [self filterArticleModelTo: @"news"];
}


- (IBAction) filterToEvents: (id) sender {
    
    [self filterArticleModelTo: @"event"];
}


- (void) filterArticleModelTo: (NSString *) filterString {
    
    self.tableView.contentOffset = CGPointMake(0, 0);
    
    [self.model fetchContentForContentType: filterString withRegionModel: self.regionModel];
            
    [self.tableView reloadData];
    
    self.messageLabel.hidden = self.model.content.count != 0;
}


- (void) searchBar: (UISearchBar *) searchBar textDidChange: (NSString *) searchText {
    
    NSMutableArray *resultArray = [NSMutableArray arrayWithArray: self.model.content];
    
    [resultArray filterUsingPredicate: [NSPredicate predicateWithBlock: ^BOOL(id evaluatedObject, NSDictionary *bindings) {
        
        if([evaluatedObject isKindOfClass:[DTArticle class]]) {
            
            return checkmatch(((DTArticle *)evaluatedObject).headline, searchText) ||
            checkmatch(((DTArticle *)evaluatedObject).htmlBody, searchText);
        }
        else {
            
            return NO;
        }
    }]];
    
    self.filteredArticles = resultArray;
    
    [self.searchDisplayController.searchResultsTableView reloadData];
}


- (IBAction) openSearch: (id) sender {
    
    CGRect searchFrame = self.searchDisplayController.searchBar.frame;
    
    searchFrame.origin.y = (searchFrame.origin.y < 120.0f) ? searchFrame.origin.y + 44 : searchFrame.origin.y - 44;
    
    if(self.searchDisplayController.active) {
        
        [self.searchDisplayController setActive: NO animated: NO];
    }
    
    [UIView animateWithDuration: 0.3f animations: ^{
       
        
        self.searchDisplayController.searchBar.frame = searchFrame;
        
    }completion:^(BOOL finished) {
        
        
        if (!(searchFrame.origin.y < 120.0f)) {
            
            [self.searchDisplayController setActive: YES animated: YES];
            [self.searchDisplayController.searchBar becomeFirstResponder];
        }
        
    }];
}


BOOL checkmatch(NSString *item, NSString *matchphrase) {
    
    matchphrase = [matchphrase stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSArray *searchTermns = [matchphrase componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    BOOL match = YES;
    
    for(NSString *term in searchTermns) {
        
        BOOL termMatch = NO;
        
        NSPredicate *containPred = [NSPredicate predicateWithFormat: @"SELF contains[cd] %@", term];
        termMatch = termMatch | [containPred evaluateWithObject: item];
        
        NSPredicate *matchPred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", term];
        termMatch = termMatch | [matchPred evaluateWithObject: item];
        
        match = match & termMatch;
    }
    
    return match;
}


- (void) searchBarCancelButtonClicked: (UISearchBar *) searchBar {
    
    [self openSearch: nil];
}


@end
