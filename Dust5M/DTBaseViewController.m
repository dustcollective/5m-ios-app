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


- (IBAction) openSearch: (id) sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Open Search" message: @"" delegate: Nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
    
    [alert show];
}

@end
