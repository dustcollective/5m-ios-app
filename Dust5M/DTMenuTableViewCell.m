//
//  DTMenuTableViewCell.m
//  Dust5M
//
//  Created by Kemal Enver on 06/02/2014.
//  Copyright (c) 2014 dust. All rights reserved.
//

#import "DTMenuTableViewCell.h"

@implementation DTMenuTableViewCell


- (void) setSelected: (BOOL) selected animated: (BOOL) animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) willMoveToSuperview:(UIView *)newSuperview {
    
    self.textLabel.textColor = RGB(88, 88, 91);
    self.textLabel.font = [UIFont fontWithName: @"BetonEF-Demibold" size: 14.0f];
    self.textLabel.textAlignment = NSTextAlignmentLeft;
}

@end
