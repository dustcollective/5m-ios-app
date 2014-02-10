//
//  DTSettingsViewController.h
//  Dust5M
//
//  Created by Kemal Enver on 13/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTSettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UILabel *logoLabel;

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
