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
    
    NSMutableDictionary *_territoryFileDict;
}


@end


@implementation DTSettingsViewController


- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.logoLabel.font = [UIFont fontWithName: @"BetonEF-Light" size: 52];
    self.logoLabel.text = NSLocalizedString(@"APP_NAME", @"Name of Application");
    
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame: CGRectZero];
}


- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear: animated];

    if(!_territoryFileDict) {
        
        [self reload: nil];
    }
}


- (void) reload: (id) sender {
    
    NSString *territoryPath = [documentPath() stringByAppendingPathComponent: @"territories.plist"];
 
    // Check if the database has already been created in the users filesystem
    if (![[NSFileManager defaultManager] fileExistsAtPath: territoryPath]) {
        
        NSString *file = [[NSBundle mainBundle] pathForResource: @"territories.plist" ofType: nil];
        
        NSError *error = nil;
        
        [[NSFileManager defaultManager] copyItemAtPath: file toPath: territoryPath error: &error];
    }
    
    _territoryFileDict = [NSMutableDictionary dictionaryWithContentsOfFile: territoryPath];
    
    [self.tableView reloadData];
    [_refreshControl endRefreshing];
}


#pragma mark -
#pragma mark - Table View
     
- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView {
    
    return 2;
}


- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section {
    
    if(section == 0) {
        
        return 1;
    }
    else {
        
        NSArray *terArray = _territoryFileDict[@"territories"];
        
        return terArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL allEnabled = [_territoryFileDict[@"all"] boolValue];
    
    DTSettingsCell *cell = [tableView dequeueReusableCellWithIdentifier: @"territoryCell"];
    
    if(indexPath.section == 0) {
        
        cell.countryLabel.text = NSLocalizedString(@"ALL_ENABLED", @"All enabled country switch");
        
        ((UISwitch *)cell.accessoryView).on = allEnabled;
        cell.accessoryView.tag = 999;
        
    }
    else {
        
        NSArray *terArray = _territoryFileDict[@"territories"];
        
        NSString *territoryName = terArray[indexPath.row][@"name"];
        bool selected = allEnabled ? NO : [terArray[indexPath.row][@"selected"] boolValue];
        
        cell.countryLabel.text = [territoryName stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        ((UISwitch *)cell.accessoryView).on = selected;
        cell.accessoryView.tag = indexPath.row;

    }
    return cell;
    
}


- (CGFloat) tableView: (UITableView *) tableView heightForHeaderInSection: (NSInteger) section {
    
    return 8.0f;
}


- (IBAction) switchPressed: (id) sender {
    
    UISwitch *toggleSwitch = sender;
    
    BOOL newStatus = toggleSwitch.on;
    
    NSArray *terArray = _territoryFileDict[@"territories"];
    
    if(toggleSwitch.tag == 999) {
        
        _territoryFileDict[@"all"] = [NSNumber numberWithBool: newStatus];
        
        if(newStatus) {
            
            for(NSMutableDictionary *territory in terArray) {
                
                territory[@"selected"] =  [NSNumber numberWithBool: NO];
            }
        }
    }
    else {
        
        NSMutableDictionary *territory = terArray[toggleSwitch.tag];
        territory[@"selected"] =  [NSNumber numberWithBool: newStatus];
        
        _territoryFileDict[@"all"] = [NSNumber numberWithBool: NO];
    }
    
    NSString *territoryPath = [documentPath() stringByAppendingPathComponent: @"territories.plist"];
    
    [_territoryFileDict writeToFile: territoryPath atomically: YES];
    
    [self.tableView reloadData];
}


@end
