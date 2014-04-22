//
//  DTAdvertViewController.m
//  Dust5M
//
//  Created by Kemal Enver on 09/02/2014.
//  Copyright (c) 2014 dust. All rights reserved.
//

#import "DTAdvertViewController.h"

@interface DTAdvertViewController ()

@end

@implementation DTAdvertViewController


- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.screenName = @"Advertisement";
	   
    loadImage(self.advertImageView, [NSURL URLWithString: self.advertURL], nil);
}


- (IBAction) closeAdvert : (id) sender {
    
    [self dismissViewControllerAnimated: YES completion:^{
 
    }];
}

@end
