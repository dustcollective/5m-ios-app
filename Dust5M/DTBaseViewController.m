//
//  DTBaseViewController.m
//  Dust5M
//
//  Created by Kemal Enver on 12/02/2014.
//  Copyright (c) 2014 dust. All rights reserved.
//

#import "DTBaseViewController.h"

@interface DTBaseViewController ()

@end

@implementation DTBaseViewController


- (void) viewDidLoad {

    [super viewDidLoad];
    
    self.logoLabel.font = [UIFont fontWithName: @"BetonEF-Light" size: 52];
    self.logoLabel.text = NSLocalizedString(@"APP_NAME", @"Name of Application");
    self.logoLabel.textColor = logoColor();
    
    [self.allButton setTitle: NSLocalizedString(@"INICIO", @"Home Button") forState: UIControlStateNormal];
    [self.newsButton setTitle: NSLocalizedString(@"NOTICIAS", @"News Button") forState: UIControlStateNormal];
    [self.eventButton setTitle: NSLocalizedString(@"EVENTOS", @"Events Button") forState: UIControlStateNormal];
    
    if(IOS_MAJOR_VERSION < 7) {
        
        self.allButton.titleLabel.font = [UIFont systemFontOfSize: 16];
        self.newsButton.titleLabel.font = [UIFont systemFontOfSize: 16];
        self.eventButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    }
}


- (IBAction) toggleDrawer: (id) sender {
    
    if(self.mm_drawerController.openSide == MMDrawerSideNone) {
        
        [self.mm_drawerController openDrawerSide: MMDrawerSideLeft animated: YES completion:nil];
    }
    else {
        [self.mm_drawerController closeDrawerAnimated: YES completion: nil];
    }
}


- (IBAction) openHelp: (id) sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Open Help" message: @"" delegate: Nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
    
    [alert show];
}


/*
- (IBAction) openSearch: (id) sender {
    
    NSMutableDictionary *event = [[GAIDictionaryBuilder createEventWithCategory: @"UI"
                                                                         action: @"Pressed Search"
                                                                          label: @"dispatch"
                                                                          value: nil] build];
    [[GAI sharedInstance].defaultTracker send: event];
    [[GAI sharedInstance] dispatch];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Open Search" message: @"" delegate: Nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
    
    [alert show];
}*/

@end
