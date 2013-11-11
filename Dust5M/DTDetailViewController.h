//
//  DTDetailViewController.h
//  Dust5M
//
//  Created by Kemal Enver on 11/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
