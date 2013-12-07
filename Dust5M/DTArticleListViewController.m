//
//  DTMasterViewController.m
//  Dust5M
//
//  Created by Kemal Enver on 11/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTContentViewController.h"
#import "DTArticleListViewController.h"

@interface DTArticleListViewController () {
    
    BOOL _searchMode;
}

@end

@implementation DTArticleListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"MAIN_LIST_TITLE", @"List title for the main page");
    
    [self.searchDisplayController.searchResultsTableView registerClass: [DTArticleCell class]
                                                forCellReuseIdentifier: @"Cell"];
    
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame: CGRectZero];
    [self.refreshControl addTarget: self action:@selector(loadData) forControlEvents: UIControlEventAllEvents];
    [self.tableView addSubview: self.refreshControl];
    
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

- (void) loadData {
    
    if(!self.model) {
        
        [DTArticleModel articleListWithBlock:^(DTArticleModel *articleModel, NSError *error) {
            
            _model = articleModel;
            [self.tableView reloadData];
            
            [self.tableView scrollToRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition: UITableViewScrollPositionTop animated: NO];
            
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
    
    if(section == 0) {
        
        UIView *containerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 320, 50)];
        containerView.backgroundColor = [UIColor whiteColor];
        
        UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems: @[@"Inicio", @"Noticias", @"Eventos"]];
        
        [segmentControl addTarget: self
                           action: @selector(segmentAction:)
                 forControlEvents: UIControlEventValueChanged];
        
        if(_model.selectedArticleType == ArticleTypeInicio) {
            
            segmentControl.selectedSegmentIndex = 0;
        }
        
        else if(_model.selectedArticleType == ArticleTypeNoticias) {
            
            segmentControl.selectedSegmentIndex = 1;
        }
        else if(_model.selectedArticleType == ArticleTypeEvent) {
            
            segmentControl.selectedSegmentIndex = 2;
        }
        
        
        segmentControl.backgroundColor = [UIColor whiteColor];
        segmentControl.frame = CGRectMake(10, 10, 300, 30);
        
        [containerView addSubview: segmentControl];
        
        return containerView;
    }
    
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(_model.selectedArticleType == ArticleTypeInicio) {
        
        return _model.newsContent.count;
    }
    else if(_model.selectedArticleType == ArticleTypeEvent) {
        
        return _model.eventContent.count;
    }
    else if(_model.selectedArticleType == ArticleTypeNoticias) {
        
        return _model.newsContent.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDateFormatter  *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"dd MMMM"];
    
    DTArticle *article = nil;
    
    if(_model.selectedArticleType == ArticleTypeInicio) {
        
        article = _model.newsContent[indexPath.row];
    }
    else if(_model.selectedArticleType == ArticleTypeEvent) {
        
        article = _model.eventContent[indexPath.row];
    }
    else if(_model.selectedArticleType == ArticleTypeNoticias) {
        
        article = _model.newsContent[indexPath.row];
    }
    
    DTArticleCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Cell" forIndexPath: indexPath];
    
    // use border rather than background color.  In selected state background colors are hidden by the system
   
    cell.colorBarView.layer.borderWidth = 5.0f;
    
    cell.descriptionLabel.text = article.headline;
    cell.dateLabel.text = [formatter stringFromDate: article.date];
    
    if(article.articleType == ContentTypeNews) {
        
         cell.colorBarView.layer.borderColor = RGB(93,176,226).CGColor;
        [cell.thumbnailView setImageWithURL: [NSURL URLWithString: article.thumbnailURL]
                           placeholderImage: [UIImage imageNamed:@"defaultnews.png"]];
    }
    else if (article.articleType == ContentTypeEvent) {
        
         cell.colorBarView.layer.borderColor = RGB(0,176,0).CGColor;
        [cell.thumbnailView setImageWithURL: [NSURL URLWithString: article.thumbnailURL]
                           placeholderImage: [UIImage imageNamed:@"defaultevent.png"]];
    }
    
    NSString *flagLink = [NSString stringWithFormat:@"http://app.5mpublishing.com/feed/flag/mono/%@.png", article.countryCode.lowercaseString];
    
    [cell.flagView setImageWithURL: [NSURL URLWithString: flagLink] placeholderImage: [UIImage imageNamed: @"defaultnews.png"]];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier: @"contentSegue" sender: indexPath];
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender {
    
    NSIndexPath *indexPath = sender;
    
    if([segue.identifier isEqualToString:@"contentSegue"]) {
        
        DTArticle *article = nil;
        
        if(_model.selectedArticleType == ArticleTypeInicio) {
            
            article = _model.newsContent[indexPath.row];
        }
        else if(_model.selectedArticleType == ArticleTypeEvent) {
            
            article = _model.eventContent[indexPath.row];
        }
        else if(_model.selectedArticleType == ArticleTypeNoticias) {
            
            article = _model.newsContent[indexPath.row];
        }
        
        ((DTContentViewController *)segue.destinationViewController).article = article;
        
    }
}


- (void) segmentAction: (UISegmentedControl *) control {
    
    switch (control.selectedSegmentIndex) {
        case 0:
            _model.selectedArticleType = ArticleTypeInicio;
            break;
        case 1:
             _model.selectedArticleType = ArticleTypeNoticias;
            break;
        case 2:
             _model.selectedArticleType = ArticleTypeEvent;
            break;
            
        default:
            break;
    }
    
    [self.tableView reloadData];
}

@end
