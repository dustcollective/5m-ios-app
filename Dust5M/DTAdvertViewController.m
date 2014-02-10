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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    loadImage(self.advertImageView, [NSURL URLWithString: self.advertURL], nil);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) closeAdvert : (id) sender {
    
    [self dismissViewControllerAnimated: YES completion:^{
        
        
    }];
}

@end
