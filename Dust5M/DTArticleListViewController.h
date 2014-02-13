//
//  DTMasterViewController.h
//  Dust5M
//
//  Created by Kemal Enver on 11/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTArticleModel.h"
#import "DTStandardArticleCell.h"

#import "DTBaseViewController.h"

@interface DTArticleListViewController : DTBaseViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>


@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) DTArticleModel *model;

@property (nonatomic, strong) NSArray *filteredArticles;

@property (nonatomic, strong) IBOutlet UIView *overlayView;
@property (nonatomic, strong) IBOutlet UIImageView *splashScreenImageView;
@property (nonatomic, strong) IBOutlet UILabel *versionLabel;


@end
