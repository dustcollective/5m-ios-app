//
//  DTSettingsViewController.h
//  Dust5M
//
//  Created by Kemal Enver on 13/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DTBaseViewController.h"

@interface DTSettingsViewController : DTBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIButton *eventButton;
@property (nonatomic, strong) IBOutlet UILabel *instruc1;
@property (nonatomic, strong) IBOutlet UILabel *instruc2;

@end
