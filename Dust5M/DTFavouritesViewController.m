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
    
    self.screenName = @"Favourites";
	// Do any additional setup after loading the view.
    
    self.messageLabel.text = NSLocalizedString(@"NO_FAVOURITES",  @"No Favourites");
    
    DTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
}


- (void) loadData {
    
    self.messageLabel.hidden = YES;
    
    if(!self.model) {
        
        [DTArticleModel articleListWithBlock: ^(DTArticleModel *articleModel, NSError *error) {
            
            if(error) {
            
                NSLog(@"Network error in favourites...Kinda dumb");
            }
            
            self.model = articleModel;
            
            [self filterArticleModelTo: @"*"];
            
            [self.tableView reloadData];
            
            [self.refreshControl endRefreshing];
        }];
    }
}

- (void) filterArticleModelTo: (NSString *) filterString {
    
    self.tableView.contentOffset = CGPointMake(0, 0);
    
    [self.model fetchFavouriteContentForContentType: filterString];
    
    [self.tableView reloadData];
    
    self.messageLabel.hidden = self.model.content.count != 0;
}


@end
