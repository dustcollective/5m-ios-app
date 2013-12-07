//
//  DTFavouritesViewController.m
//  Dust5M
//
//  Created by Kemal Enver on 05/12/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTFavouritesViewController.h"
#import "FavouriteArticle.h"

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
   
    // Get the favourite events
    NSFetchRequest * eventFetch = [[NSFetchRequest alloc] init];
    [eventFetch setEntity: [NSEntityDescription entityForName: @"FavouriteArticle" inManagedObjectContext:self.managedObjectContext]];
    [eventFetch setPredicate: [NSPredicate predicateWithFormat: @"contentType == %@", [NSNumber numberWithInt: ContentTypeEvent]]];
    
    NSArray *eventContent = [self.managedObjectContext executeFetchRequest: eventFetch error: nil];
    
    
    
    // Get the news events
    NSFetchRequest * newsFetch = [[NSFetchRequest alloc] init];
    [newsFetch setEntity: [NSEntityDescription entityForName: @"FavouriteArticle" inManagedObjectContext:self.managedObjectContext]];
    [newsFetch setPredicate: [NSPredicate predicateWithFormat: @"contentType == %@", [NSNumber numberWithInt: ContentTypeNews]]];
    
    NSArray *newsContent = [self.managedObjectContext executeFetchRequest: newsFetch error: nil];
    
    // Returning Fetched Records
    DTArticleModel *model = [[DTArticleModel alloc] init];
    model.eventContent = eventContent;
    model.newsContent = newsContent;
    
    self.model = model;
    
    [self.tableView reloadData];
    
    [self.refreshControl endRefreshing];
}


@end
