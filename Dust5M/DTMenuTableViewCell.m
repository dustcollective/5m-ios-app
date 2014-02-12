//
//  DTMenuTableViewCell.m
//  Dust5M
//
//  Created by Kemal Enver on 06/02/2014.
//  Copyright (c) 2014 dust. All rights reserved.
//

#import "DTMenuTableViewCell.h"

@implementation DTMenuTableViewCell


- (void) willMoveToSuperview:(UIView *)newSuperview {
    
    self.textLabel.textColor = RGB(88, 88, 91);
    self.textLabel.font = [UIFont fontWithName: @"BetonEF-Demibold" size: 14.0f];
    self.textLabel.textAlignment = NSTextAlignmentLeft;
}

- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(10, 10, 40, 40);
    
    CGRect frame = self.textLabel.frame;
    frame.origin.x = 56;
    frame.origin.y +=2;
    
    self.textLabel.frame = frame;
}

@end
