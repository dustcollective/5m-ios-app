//
//  DTSettingsViewController.m
//  Dust5M
//
//  Created by Kemal Enver on 13/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import <EventKit/EventKit.h>

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
    
    self.logoLabel.textColor = logoColor();
    self.logoLabel.text = NSLocalizedString(@"APP_NAME", @"Name of Application");
    
    
    self.titleLabel.text = NSLocalizedString(@"EVENTS_TITLE", @"Events Title");
    [self.eventButton setTitle: NSLocalizedString(@"EVENTS_BUTTON", @"Events Button")
                      forState: UIControlStateNormal];
    self.instruc1.text = NSLocalizedString(@"EVENT_INSTRUCTIONS_1", @"Add Favourite Events to Calendar");
    self.instruc2.text = NSLocalizedString(@"EVENT_INSTRUCTIONS_2", @"You can remove these events in");
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame: CGRectZero];
    self.tableView.backgroundColor = [UIColor whiteColor];
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
    
    return 1.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    
    tempView.backgroundColor = [UIColor lightGrayColor];
    
    return  tempView;
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


- (IBAction) addFavouriteEventsToCalendar: (id) sender {
    
    NSString *path = [documentPath() stringByAppendingPathComponent: @"storedevents"];
    
    [DTArticleModel articleListWithBlock: ^(DTArticleModel *articleModel, NSError *error) {
            
            EKEventStore *store = [[EKEventStore alloc] init];
            
            [store requestAccessToEntityType: EKEntityTypeEvent completion: ^(BOOL granted, NSError *error) {
            
                if (!granted) {
                    
                    return;
                }
                else {
                    
                    // Remove all the old events we stored so we don't get duplicates
                    NSMutableArray *previousEventIDs = [NSMutableArray arrayWithContentsOfFile: path];
                    if(previousEventIDs) {
                        
                        for(NSString *eventID in previousEventIDs) {
                            
                            EKEvent *eventToRemove = [store eventWithIdentifier: eventID];
                            
                            if (eventToRemove) {
                                
                                NSError* error = nil;
                                
                                [store removeEvent: eventToRemove span: EKSpanThisEvent commit: YES error: &error];
                                
                                if(error) {
                                    
                                    NSLog(@"Error! %@", error);
                                }
                            }
                        }
                    }
                    
                    // Add all the new events
                    [articleModel fetchFavouriteContentForContentType: @"event"];
                    
                    NSMutableArray *storedEventIDs = [NSMutableArray arrayWithCapacity: articleModel.content.count];
                    
                    for(DTArticle *event in articleModel.content) {
                        
                        EKEvent *calendarEvent = [EKEvent eventWithEventStore:store];
                        calendarEvent.title = event.headline;
                        calendarEvent.location = event.location;
                        calendarEvent.startDate = event.startDate;
                        calendarEvent.endDate = event.endDate;
                        calendarEvent.calendar = [store defaultCalendarForNewEvents];
                        calendarEvent.allDay = YES;
                        calendarEvent.URL = [NSURL URLWithString: event.linkString];
                        calendarEvent.alarms = @[[EKAlarm alarmWithAbsoluteDate: calendarEvent.startDate]];
                        
                        error = nil;
                        [store saveEvent: calendarEvent span: EKSpanThisEvent commit: YES error: &error];
                        
                        if(error) {
                            
                            NSLog(@"Error! %@", error);
                        }
                        
                        [storedEventIDs addObject: calendarEvent.eventIdentifier];
                        
                    }
                    
                    [storedEventIDs writeToFile: path atomically: YES];
                }
                
                [self showAlert: NSLocalizedString(@"EVENTS_ADDED", @"EVENTS ADDED")];
  
            }];
    }];
}


- (void) showAlert: (NSString *) alertText {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: nil
                                                    message: alertText
                                                   delegate: nil
                                          cancelButtonTitle: NSLocalizedString(@"OK", @"Ok")
                                          otherButtonTitles: nil];
    [alert show];
}


@end
