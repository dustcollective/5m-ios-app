//
//  DTMenuViewController.m
//  Dust5M
//
//  Created by Kemal Enver on 06/02/2014.
//  Copyright (c) 2014 dust. All rights reserved.
//

#import "DTMenuViewController.h"

#import "DTArticleModel.h"

@interface DTMenuViewController ()

@end


@implementation DTMenuViewController


- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.screenName = @"Main Menu";

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame: CGRectZero];
    
    self.tableView.scrollsToTop = NO;
}


#pragma mark -
#pragma mark - Table View


- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView {
    
    return 1;
}


- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section {
    
    return 5;
}


- (UITableViewCell *)tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"MenuCell" forIndexPath: indexPath];
    
    UIImage *icon = nil;
    NSString *rowTitle = nil;
    
    switch (indexPath.row) {
            
        case 0:
            icon = [UIImage imageNamed: @"HomeIcon"];
            rowTitle = NSLocalizedString(@"MAIN_PAGE", @"Main View Menu item");
            break;
            
        case 1:
            icon = [UIImage imageNamed: @"FavouritesIcon"];
            rowTitle = NSLocalizedString(@"FAVOURITES", @"Favourites Menu Item");
            break;
            
        case 2:
            icon = [UIImage imageNamed: @"MobileIcon"];
            rowTitle = NSLocalizedString(@"OUR_APPS", @"Our Apps Menu Item");
            break;
            
        case 3:
            icon = [UIImage imageNamed: @"SettingsIcon"];
            rowTitle = NSLocalizedString(@"SETTINGS", @"Settings Menu Item");
            break;
        
        case 4:
            icon = [UIImage imageNamed: @"HelpIcon"];
            rowTitle = NSLocalizedString(@"HELP_PAGE", @"Settings Help Item");
            break;
            
        default:
            break;
    }
    
    cell.textLabel.text = rowTitle;
    cell.imageView.image = icon;
    
    return cell;
}


- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
    
    UIViewController *controllerToSwitch = nil;
    
    switch (indexPath.row) {
            
        case 0:
            controllerToSwitch = [self.storyboard instantiateViewControllerWithIdentifier: @"StartController"];
            break;
            
        case 1:
            controllerToSwitch = [self.storyboard instantiateViewControllerWithIdentifier: @"FavouritesController"];
            break;
            
        case 2:
            
            controllerToSwitch = [self.storyboard instantiateViewControllerWithIdentifier: @"WebController"];
            break;
        case 3:
            
            controllerToSwitch = [self.storyboard instantiateViewControllerWithIdentifier: @"SettingsController"];
            break;
            
        case 4:
            
            [self openHelp: nil];
            return;
            
        default:
            break;
    }
    
    [self.mm_drawerController setCenterViewController: controllerToSwitch withCloseAnimation: YES completion: ^(BOOL finished) {  
    }];
}


- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    
    return 60.0f;
}


- (IBAction) openHelp: (id) sender {
    
    NSMutableDictionary *event = [[GAIDictionaryBuilder createEventWithCategory: @"UI"
                                                                         action: @"Pressed Help"
                                                                          label: @"dispatch"
                                                                          value: nil] build];
    [[GAI sharedInstance].defaultTracker send: event];
    [[GAI sharedInstance] dispatch];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"HELP_TITLE", @"Help Title")
                                                    message: NSLocalizedString(@"HELP_MESSAGE", @"Help Message")
                                                   delegate: nil
                                          cancelButtonTitle: NSLocalizedString(@"OK", @"Ok")
                                          otherButtonTitles: nil];
    
    [alert show]; 
}


@end
