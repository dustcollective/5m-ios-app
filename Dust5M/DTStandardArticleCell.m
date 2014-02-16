//
//  DTArticleCell.m
//  Dust5M
//
//  Created by Kemal Enver on 12/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTStandardArticleCell.h"

@implementation DTStandardArticleCell

- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect frame = self.thumbnailView.frame;
    
    frame.size = CGSizeMake(55.0f, 55.0f);
    
    self.thumbnailView.frame = frame;
    
    // Reset width so that the sizeTOFit works on the full width available.
    CGRect labelFrame = self.descriptionLabel.frame;
    labelFrame.size.width = 182.0f;
    
    self.descriptionLabel.frame = labelFrame;
    
    [self.descriptionLabel sizeToFit];
}

@end