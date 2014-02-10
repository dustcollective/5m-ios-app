//
//  DTFavouritesViewController.m
//  Dust5M
//
//  Created by Kemal Enver on 05/12/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTFavouritesViewController.h"

#import "DTAppDelegate.h"

@interface DTFavouritesViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end


@implementation DTFavouritesViewController


- (void) viewDidLoad {
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    DTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
}


- (void) loadData {
    
    if(!self.model) {
        
        [DTArticleModel articleListWithBlock: ^(DTArticleModel *articleModel, NSError *error) {
            
            if(error) {
            
                NSLog(@"Netowrk error in favourites...Kinda dumb");
            }
            
            self.model = articleModel;
            
            [self.model fetchFavouriteContentForContentType: @"*"]; // news, event, *
            
            [self.tableView reloadData];
            
            [self.refreshControl endRefreshing];
        }];
    }
}


@end
