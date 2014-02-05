//
//  DTMasterViewController.h
//  Dust5M
//
//  Created by Kemal Enver on 11/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTArticleModel.h"
#import "DTArticleCell.h"

@interface DTArticleListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentControl;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) DTArticleModel *model;

@property (nonatomic, strong) NSArray *filteredArticles;

@end
