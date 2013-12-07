//
//  DTSettingsViewController.m
//  Dust5M
//
//  Created by Kemal Enver on 13/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTSettingsViewController.h"
#import "DTSettingsCell.h"
// Article model also contains a list of territories
#import "DTArticleModel.h"

@interface DTSettingsViewController () {
    
    UIRefreshControl *_refreshControl;
    NSArray *_territoriesModel;
}

@end

@implementation DTSettingsViewController

- (void) viewDidLoad {
    
    [super viewDidLoad];
	    
    self.title = NSLocalizedString(@"SETTINGS_TITLE", @"Title of settings controller");
    
    _refreshControl = [[UIRefreshControl alloc] initWithFrame: CGRectZero];
    [_refreshControl addTarget: self action: @selector(reload:) forControlEvents: UIControlEventValueChanged];
    [self.tableView addSubview: _refreshControl];
}


- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear: animated];

    if(!_territoriesModel) {
        
        [self reload: nil];
    }
}

- (void) reload: (id) sender {
    
    [DTArticleModel articleListWithBlock: ^(DTArticleModel *articleModel, NSError *error) {
        
        _territoriesModel = articleModel.territories;
        [self.tableView reloadData];
        [_refreshControl endRefreshing];
    }];
}

#pragma mark - Table View
     
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 0) {
        return 1;
    }
    else {
        return _territoriesModel.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0) {
        
        DTSettingsCell *cell = [tableView dequeueReusableCellWithIdentifier: @"territoryCell"];
        cell.countryLabel.text = @"All of them";
        
        return cell;
    }
    else {
        
        NSString *territoryName = _territoriesModel[indexPath.row];
        
        DTSettingsCell *cell = [tableView dequeueReusableCellWithIdentifier: @"territoryCell"];
        cell.countryLabel.text = [territoryName stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        return cell;
    }
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 8.0f;
}


@end
