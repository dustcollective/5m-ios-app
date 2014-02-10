//
//  DTAdvertViewController.h
//  Dust5M
//
//  Created by Kemal Enver on 09/02/2014.
//  Copyright (c) 2014 dust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTAdvertViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView *advertImageView;
@property (nonatomic, strong) IBOutlet UIButton *closeButton;

@property (nonatomic, strong) NSString *advertURL;

- (IBAction) closeAdvert : (id) sender;

@end
