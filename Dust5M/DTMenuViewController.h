//
//  DTMenuViewController.h
//  Dust5M
//
//  Created by Kemal Enver on 06/02/2014.
//  Copyright (c) 2014 dust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTMenuViewController : GAITrackedViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
