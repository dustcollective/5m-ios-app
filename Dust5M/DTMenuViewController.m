//
//  DTMenuViewController.m
//  Dust5M
//
//  Created by Kemal Enver on 06/02/2014.
//  Copyright (c) 2014 dust. All rights reserved.
//

#import "DTMenuViewController.h"

@interface DTMenuViewController ()

@end

@implementation DTMenuViewController


- (void) viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark - Table View

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"MenuCell" forIndexPath: indexPath];
    
    cell.textLabel.text = NSLocalizedString(@"FAVOURITES", @"Menu Favourites");
    
    return cell;
}



@end
