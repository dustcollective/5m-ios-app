//
//  DTBaseViewController.h
//  Dust5M
//
//  Created by Kemal Enver on 12/02/2014.
//  Copyright (c) 2014 dust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTBaseViewController : GAITrackedViewController

@property (nonatomic, strong) IBOutlet UILabel *logoLabel;

@property (nonatomic, strong) IBOutlet UIButton *allButton;
@property (nonatomic, strong) IBOutlet UIButton *newsButton;
@property (nonatomic, strong) IBOutlet UIButton *eventButton;

@end
