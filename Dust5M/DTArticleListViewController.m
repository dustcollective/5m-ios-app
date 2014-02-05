//
//  DTMasterViewController.m
//  Dust5M
//
//  Created by Kemal Enver on 11/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTContentViewController.h"
#import "DTArticleListViewController.h"
#import "DTAdvertCell.h"
#import "DTArticleCell.h"

@interface DTArticleListViewController () {
    
    BOOL _searchMode;
}

@end

@implementation DTArticleListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"MAIN_LIST_TITLE", @"List title for the main page");
    
    UINib *nib = [UINib nibWithNibName: @"DTArticleCell" bundle: nil];
    [self.tableView registerNib: nib forCellReuseIdentifier: @"ArticleCell"];
    [self.searchDisplayController.searchResultsTableView registerNib: nib forCellReuseIdentifier: @"ArticleCell"];
    
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame: CGRectZero];
    [self.refreshControl addTarget: self
                            action: @selector(pullToLoadData)
                  forControlEvents: UIControlEventAllEvents];
    
    [self.tableView addSubview: self.refreshControl];
    
    
    self.segmentControl = [[UISegmentedControl alloc] initWithItems: @[@"Inicio", @"Noticias", @"Eventos"]];
    
    [self.segmentControl addTarget: self
                            action: @selector(segmentAction:)
                  forControlEvents: UIControlEventValueChanged];
    
    self.segmentControl.backgroundColor = [UIColor whiteColor];
    self.segmentControl.frame = CGRectMake(10, 10, 300, 30);
}

- (void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear: animated];
    
    [self.tableView deselectRowAtIndexPath: self.tableView.indexPathForSelectedRow animated: YES];
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear: animated];
    
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
                
                NSLog(@"Netowrk error?");
            }
            
            self.model = articleModel;
            
            self.segmentControl.selectedSegmentIndex = 0;
            [self segmentAction: self.segmentControl];
            
            [self.refreshControl endRefreshing];
        }];
    }
}

#pragma mark - Table View

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.0f;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        
        return nil;
    }
    
    if(section == 0) {
        
        UIView *containerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 320, 50)];
        containerView.backgroundColor = [UIColor whiteColor];
        
        [containerView addSubview: self.segmentControl];
        
        return containerView;
    }
    
    
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        
        return 0.0f;
    }
    return 50.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        
        return self.filteredArticles.count;
    }
    
    return self.model.content.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDateFormatter  *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"dd MMMM"];
    
    if([self.model.content[indexPath.row] isKindOfClass: [NSNumber class]]) {
        
        NSNumber *advertIndex = self.model.content[indexPath.row];
        NSDictionary *advert = self.model.adverts[advertIndex.intValue];
        
        DTAdvertCell *adCell = [tableView dequeueReusableCellWithIdentifier: @"AdCell"];
        
        if(!adCell) {
            
            adCell = [[DTAdvertCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"AdCell"];
        }
        [adCell.imageView setImageWithURL: [NSURL URLWithString: advert[@"inline"]]
                         placeholderImage: [UIImage imageNamed: @"adplaceholder.png"]];
        
        return adCell;
    }
    
    DTArticle *article = nil;
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        article = self.filteredArticles[indexPath.row];
    }
    else {
        article = self.model.content[indexPath.row];
    }
    DTArticleCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ArticleCell" forIndexPath: indexPath];
    
    // use border rather than background color.  In selected state background colors are hidden by the system
    
    cell.colorBarView.layer.borderWidth = 5.0f;
    
    cell.descriptionLabel.text = article.headline;
    cell.dateLabel.text = [formatter stringFromDate: article.date];
    
    if([article.contentType isEqualToString: @"news"]) {
        
        cell.colorBarView.layer.borderColor = RGB(93, 176, 226).CGColor;
        
        loadImage(cell.thumbnailView, [NSURL URLWithString: article.thumbnailURL], @"defaultnews.png");
    }
    else if ([article.contentType isEqualToString: @"event" ]) {
        
        cell.colorBarView.layer.borderColor = RGB(0, 176, 0).CGColor;
        
        loadImage(cell.thumbnailView, [NSURL URLWithString: article.thumbnailURL], @"defaultevent.png");
    }
    
    NSString *flagLink = [NSString stringWithFormat:@"http://app.5mpublishing.com/feed/flag/mono/%@.png", article.countryCode.lowercaseString];
    
    [cell.flagView setImageWithURL: [NSURL URLWithString: flagLink] placeholderImage: [UIImage imageNamed: @"defaultnews.png"]];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
}


- (void) segmentAction: (UISegmentedControl *) control {
    
    switch (control.selectedSegmentIndex) {
        case 0:
            [self.model fetchContentForContentType: @"*" withRegion: @"*"];
            break;
            
        case 1:
             [self.model fetchContentForContentType: @"news" withRegion: @"*"];
            break;
            
        case 2:
            [self.model fetchContentForContentType: @"event" withRegion: @"*"];
            break;
            
        default:
            break;
    }
    
    [self.tableView reloadData];
}


- (void) searchBar: (UISearchBar *) searchBar textDidChange: (NSString *) searchText {
    
    NSMutableArray *resultArray = [NSMutableArray arrayWithArray: self.model.content];
    
    [resultArray filterUsingPredicate: [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        
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


BOOL checkmatch(NSString *item, NSString *matchphrase) {
    
    matchphrase = [matchphrase stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSArray *searchTermns = [matchphrase componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    BOOL match = YES;
    
    for(NSString *term in searchTermns) {
        
        BOOL termMatch = NO;
        
        NSPredicate *containPred = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", term];
        termMatch = termMatch | [containPred evaluateWithObject: item];
        
        NSPredicate *matchPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", term];
        termMatch = termMatch | [matchPred evaluateWithObject: item];
        
        match = match & termMatch;
    }
    
    return match;
}


- (IBAction) openSearch:(id)sender {
    
    [self.searchDisplayController setActive: YES animated: YES];
}

@end
