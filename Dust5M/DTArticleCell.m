//
//  DTArticleCell.m
//  Dust5M
//
//  Created by Kemal Enver on 12/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTArticleCell.h"

@implementation DTArticleCell


- (void) willMoveToSuperview: (UIView *) newSuperview {
    
    [super willMoveToSuperview: newSuperview];
    
    self.descriptionLabel.font = [UIFont fontWithName: @"BetonEF-DemiBold" size: 14.0f];
    self.dateLabel.font = [UIFont fontWithName: @"Arial" size: 12.0f];
    
}


- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect frame = self.thumbnailView.frame;
    
    frame.size = CGSizeMake(55.0f, 55.0f);
    
    self.thumbnailView.frame = frame;
}


@end
